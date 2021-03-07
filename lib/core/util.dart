import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Util {
  static Future<String> getPath({
    required String directoryPath,
  }) async {
    final appDirectory = await getApplicationDocumentsDirectory();
    Directory directory = Directory('${appDirectory.path}/$directoryPath/');
    if (await directory.exists()) {
      return directory.path;
    }

    directory = await directory.create(
      recursive: true,
    );
    return directory.path;
  }

  static Future<String?> saveFileWithPath(String? filePath) async {
    if (filePath != null) {
      final localFile = File(filePath);
      final directoryPath = await getPath(
        directoryPath: 'assets/beers',
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
