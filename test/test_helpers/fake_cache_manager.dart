import 'package:file/memory.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mocktail/mocktail.dart';
import 'dart:async';

class FakeCacheManager extends Mock implements CacheManager {
  void throwsNotFound(String url) {
    when(() => getFileStream(
          url,
          key: any(named: 'key'),
          headers: any(named: 'headers'),
          withProgress: any(named: 'withProgress'),
        )).thenThrow(HttpExceptionWithStatus(404, 'Invalid statusCode: 404', uri: Uri.parse(url)));
  }

  ExpectedData returns(
    String url,
    List<int> imageData, {
    Duration? delayBetweenChunks,
  }) {
    const chunkSize = 8;
    final chunks = <Uint8List>[
      for (int offset = 0; offset < imageData.length; offset += chunkSize)
        Uint8List.fromList(imageData.skip(offset).take(chunkSize).toList()),
    ];

    when(() => getFileStream(
          url,
          key: any(named: 'key'),
          headers: any(named: 'headers'),
          withProgress: any(named: 'withProgress'),
        )).thenAnswer((_) => _createResultStream(
          url,
          chunks,
          imageData,
          delayBetweenChunks,
        ));

    return ExpectedData(
      chunks: chunks.length,
      totalSize: imageData.length,
      chunkSize: chunkSize,
    );
  }

  Stream<FileResponse> _createResultStream(
    String url,
    List<Uint8List> chunks,
    List<int> imageData,
    Duration? delayBetweenChunks,
  ) async* {
    var file = MemoryFileSystem().systemTempDirectory.childFile('testando.jpg');
    await file.writeAsBytes(imageData);
    yield FileInfo(file, FileSource.Cache, DateTime.now().add(const Duration(days: 1)), url);
  }
}

class ExpectedData {
  final int chunks;
  final int totalSize;
  final int chunkSize;

  const ExpectedData({
    required this.chunks,
    required this.totalSize,
    required this.chunkSize,
  });
}
