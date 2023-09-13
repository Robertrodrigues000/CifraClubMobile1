import 'package:cifraclub/domain/songbook/use_cases/update_songbook_preview.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/version/repository/version_repository.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class RefreshAllSongbooks {
  final SongbookRepository _songbookRepository;
  final UserSongbookRepository _userSongbookRepository;
  final UserVersionRepository _userVersionRepository;
  final VersionRepository _versionRepository;
  final UpdateSongbookPreview _updateSongbookPreview;

  const RefreshAllSongbooks(
    this._songbookRepository,
    this._userSongbookRepository,
    this._userVersionRepository,
    this._versionRepository,
    this._updateSongbookPreview,
  );

  Future<Result<List<Songbook>, RequestError>> call() {
    return _songbookRepository.getAllSongbooks().then((result) async {
      if (result.isSuccess) {
        final response = result.get()!;

        final localSongbooks = await _userSongbookRepository.getAllUserSongbooks().first;

        //Caso o songbook exista no local mas não no remoto e tenha algum songbook mais atual do que o que está sendo deletado,
        //deleta todas as informações desse songbook
        final remoteLastUpdated =
            response.sortedBy((element) => element.songbook.lastUpdated ?? DateTime.now()).last.songbook.lastUpdated ??
                DateTime.now();

        final remoteSongbookIds = response.map((e) => e.songbook.id).toSet();
        final localSongbookIds =
            localSongbooks.where((element) => element.type == ListType.user).map((e) => e.id).toSet();
        final diffIds = localSongbookIds.difference(remoteSongbookIds);

        for (var id in diffIds) {
          final localSongbook = localSongbooks.firstWhereOrNull((element) => element.id == id);

          if (localSongbook != null && (localSongbook.lastUpdated ?? DateTime.now()).isBefore(remoteLastUpdated)) {
            await Future.wait([
              _songbookRepository.deleteSongbook(localSongbook.id!),
              _userVersionRepository.deleteVersionsBySongbookId(localSongbook.id!),
              _userSongbookRepository.deleteUserSongbook(localSongbook.id!),
            ]);
          }
        }

        for (var remoteSongbookVersions in response) {
          final songbookId = remoteSongbookVersions.songbook.type == ListType.user
              ? remoteSongbookVersions.songbook.id
              : remoteSongbookVersions.songbook.type.localId;

          // coverage:ignore-start
          if (remoteSongbookVersions.songbook.type == ListType.recents) {
            //TODO: Implementar a sync das recents
            if (localSongbooks.none((element) => element.type == ListType.recents)) {
              await _userSongbookRepository.putUserSongbook(remoteSongbookVersions.songbook);
              await _addVersionsData(remoteSongbookVersions.versions, ListType.recents.localId);
            }
            continue;
          }
          // coverage:ignore-end

          if (songbookId == null) {
            // coverage:ignore-start
            logger?.sendNonFatalCrash(
              exception: Exception("User list with id null ${remoteSongbookVersions.songbook.name}"),
            );
            // coverage:ignore-end
            continue;
          }

          final localSongbook = localSongbooks.firstWhereOrNull((element) => element.id == songbookId);

          //Caso songbook não exista do DB local, adiciona o songbook e todas as versions
          if (localSongbook == null) {
            await _userSongbookRepository.putUserSongbook(remoteSongbookVersions.songbook);
            await _addVersionsData(remoteSongbookVersions.versions, songbookId);
            continue;
          }

          if (localSongbook.lastUpdated!.isAtSameMomentAs(remoteSongbookVersions.songbook.lastUpdated!)) {
            continue;
          }

          //Caso o lastUpdated do localSongbook for menor ou igual ao do remoteSongbook, vai ser verificado todas as possiveis mudanças,
          //podendo ser remover versions, adicionar versions e caso as configurações da version tenha mudado atualiza-lá.
          if (localSongbook.lastUpdated!.isBefore(remoteLastUpdated)) {
            final userVersions = await _userVersionRepository.getUserVersionsFromSongbook(songbookId);

            final versionIds = remoteSongbookVersions.versions.map((e) => e.remoteDatabaseId!);
            final deletedIds = userVersions
                .where((element) => !versionIds.contains(element.remoteDatabaseId))
                .map((e) => e.localDatabaseId!)
                .toList();

            final addVersions = List<Version>.empty(growable: true);
            final updateVersions = List<Version>.empty(growable: true);
            final updateVersionsOrders = List<Version>.empty(growable: true);

            for (var version in remoteSongbookVersions.versions) {
              final userVersion = userVersions.firstWhereOrNull(
                (element) => element.remoteDatabaseId == version.remoteDatabaseId,
              );

              if (userVersion == null) {
                addVersions.add(version);
              } else if (_isConfigChanged(version, userVersion)) {
                updateVersions.add(version.copyWith(localDatabaseId: userVersion.localDatabaseId));
              } else if (version.order != userVersion.order) {
                updateVersionsOrders.add(userVersion.copyWith(order: version.order));
              }
            }

            await Future.wait([
              _userSongbookRepository.putUserSongbook(remoteSongbookVersions.songbook),
              if (deletedIds.isNotEmpty) _userVersionRepository.deleteVersionsById(deletedIds, songbookId),
              if (updateVersionsOrders.isNotEmpty)
                _userVersionRepository.putVersionsToSongbook(updateVersionsOrders, songbookId),
            ]);
            await _addVersionsData(addVersions, songbookId);
            await _updateVersionData(updateVersions, songbookId);
          }
          //Caso o lastUpdated do localSongbook for maior ao do remoteSongbook, vai ser verificado somente as versions para adicionar.
          else if (localSongbook.lastUpdated!.isAfter(remoteLastUpdated)) {
            final userVersions = await _userVersionRepository.getUserVersionsFromSongbook(songbookId);
            final addVersions = List<Version>.empty(growable: true);

            for (var version in remoteSongbookVersions.versions) {
              final userVersion = userVersions.firstWhereOrNull(
                (element) => element.remoteDatabaseId == version.remoteDatabaseId,
              );

              if (userVersion == null) {
                addVersions.add(version);
              }
            }

            await _addVersionsData(addVersions, songbookId);
            await Future.wait([
              _userSongbookRepository.updateTotalSongs(songbookId: songbookId),
              _updateSongbookPreview(songbookId),
            ]);
          }
        }
      }
      return result.map((value) => value.map((e) => e.songbook).toList());
    });
  }

  bool _isConfigChanged(Version version, Version userVersion) {
    return !(version.key == userVersion.key &&
        version.stdKey == userVersion.stdKey &&
        version.capo == userVersion.capo &&
        version.tuning == userVersion.tuning &&
        userVersion.instrument == version.instrument &&
        userVersion.versionId == version.versionId);
  }

  Future<void> _addVersionsData(List<Version> addVersions, int songbookId) async {
    if (addVersions.isEmpty) {
      return;
    }

    for (var versions in addVersions.slices(5)) {
      final results = await _getVersionDataInBlock(versions);

      final localDatabaseIds = await _userVersionRepository.putVersionsToSongbook(versions, songbookId);

      for (var i = 0; i < versions.length; i++) {
        final result = results[i];
        if (result.isSuccess) {
          await _userVersionRepository.addVersionData(
            versionData: result.get()!,
            versionLocalDatabaseId: localDatabaseIds[i],
            songbookId: songbookId,
          );
        }
      }
    }
  }

  Future<void> _updateVersionData(List<Version> updateVersions, int songbookId) async {
    if (updateVersions.isEmpty) {
      return;
    }

    for (var versions in updateVersions.slices(5)) {
      final results = await _getVersionDataInBlock(versions);
      final versionLocalIds = await _userVersionRepository.putVersionsToSongbook(versions, songbookId);

      for (var i = 0; i < versions.length; i++) {
        final result = results[i];
        if (result.isSuccess) {
          final versionData = result.get()!;

          await _userVersionRepository.addVersionData(
            versionData: versionData,
            versionLocalDatabaseId: versionLocalIds[i],
            songbookId: songbookId,
          );
        }
      }
    }
  }

  Future<List<Result<VersionData, RequestError>>> _getVersionDataInBlock(List<Version> versions) async {
    return Future.wait(
      versions.map(
        (element) {
          return _versionRepository.getVersionDataByVersionId(
            versionId: element.versionId,
            apiType: element.instrument.apiType,
          );
        },
      ),
    );
  }
}
