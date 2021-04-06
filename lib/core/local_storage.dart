import 'dart:io';

import 'package:hoppy/core/core.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  static Future<void> delete(String filePath) async {
    final file = File(filePath);
    await file.delete();
  }

  static Future<void> deleteFiles(String path) async {
    final appDirectory = await getApplicationDocumentsDirectory();
    final directory = Directory('${appDirectory.path}/$path/');
    if (await directory.exists()) {
      await directory.delete(
        recursive: true,
      );
    }
  }

  static Future<String> _getOrCreatePath({
    required String path,
  }) async {
    final appDirectory = await getApplicationDocumentsDirectory();
    var directory = Directory('${appDirectory.path}/$path/');
    if (await directory.exists()) {
      return directory.path;
    }

    directory = await directory.create(
      recursive: true,
    );
    return directory.path;
  }

  static Future<String?> save(String? filePath) async {
    if (filePath != null) {
      final localFile = File(filePath);
      final directoryPath = await _getOrCreatePath(
        path: kBeerAssetsDirectory,
      );
      final localPath = join(
        directoryPath,
        '${DateTime.now().millisecondsSinceEpoch}.png',
      );

      await localFile.copy(localPath);
      return localPath;
    }

    return filePath;
  }
}
