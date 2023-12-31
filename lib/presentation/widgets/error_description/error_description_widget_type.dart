import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:flutter/material.dart';

enum ErrorDescriptionWidgetType {
  connection,
  server,
  privateList,
  loggedOut,
  videoLesson,
  resultNotFound,
  youtubeResultNotFound,
  emptyList,
  searchResultNotFound,
  localSongsResultNotFound,
  localSongsPermissionDenied;

  // coverage:ignore-start
  String? getImageLight() {
    switch (this) {
      case connection:
      case server:
        return AppWebp.withoutConnectionLight;
      case privateList:
        return AppWebp.privateListErrorLight;
      case loggedOut:
        return AppWebp.loggedOutListErrorLight;
      case videoLesson:
        return AppWebp.artistVideoLessonEmptyStateLight;
      case searchResultNotFound:
        return AppWebp.searchResultNotFoundLight;
      default:
        return null;
    }
  }

  String? getImageDark() {
    switch (this) {
      case connection:
      case server:
        return AppWebp.withoutConnectionDark;
      case privateList:
        return AppWebp.privateListErrorDark;
      case loggedOut:
        return AppWebp.loggedOutListErrorDark;
      case videoLesson:
        return AppWebp.artistVideoLessonEmptyStateDark;
      case searchResultNotFound:
        return AppWebp.searchResultNotFoundDark;
      default:
        return null;
    }
  }
  // coverage:ignore-end

  String? getTitle(BuildContext context) {
    switch (this) {
      case connection:
        return context.text.connectionErrorTitle;
      case server:
        return context.text.serverErrorTitle;
      case privateList:
        return context.text.privateListErrorTitle;
      case loggedOut:
        return context.text.loggedOutListErrorTitle;
      case videoLesson:
        return context.text.noVideoLessonYetTitle;
      case resultNotFound:
      case searchResultNotFound:
        return context.text.resultNotFoundTitle;
      case emptyList:
        return context.text.emptyListTitle;
      default:
        return null;
    }
  }

  String getDescription(BuildContext context) {
    switch (this) {
      case connection:
        return context.text.connectionErrorDescription;
      case server:
        return context.text.serverErrorDescription;
      case privateList:
        return context.text.privateListErrorDescription;
      case loggedOut:
        return context.text.loggedOutListErrorDescription;
      case videoLesson:
        return context.text.noVideoLessonYetDescription;
      case emptyList:
        return context.text.emptyListDescription;
      case resultNotFound:
        return context.text.resultNotFoundDescription;
      case youtubeResultNotFound:
        return context.text.youtubeResultNotFound;
      case searchResultNotFound:
        return context.text.searchResultNotFoundDescription;
      case localSongsResultNotFound:
        return context.text.localSongsResultNotFound;
      case localSongsPermissionDenied:
        return context.text.localSongsPermissionDenied;
    }
  }

  String? getButtonText(BuildContext context) {
    switch (this) {
      case connection:
        return context.text.reload;
      case server:
        return context.text.tryAgain;
      case privateList:
        return context.text.privateListErrorButtonText;
      case loggedOut:
        return context.text.loggedOutListErrorButtonText;
      case emptyList:
        return context.text.searchSongs;
      default:
        return null;
    }
  }
}
