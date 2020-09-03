import 'dart:io';

class DirectoryOps {
  static List<String> existingAdrs(String dir) {
    final directory = Directory(dir);
    return !directory.existsSync()
        ? []
        : (directory
            .listSync()
            .map((file) => file is File
                ? file.path.split(Platform.pathSeparator).last
                : null)
            .where((filename) =>
                RegExp('^ADR[0-9]{4}').hasMatch(filename) &&
                !filename.startsWith('ADR0000'))
            .toList()
              ..sort());
  }

  static int numberOfAdrs(String dir) {
    return existingAdrs(dir).length;
  }
}
