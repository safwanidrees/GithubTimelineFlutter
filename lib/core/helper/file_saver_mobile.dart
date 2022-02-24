import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';

class FileSaverHelper {
  static Future<void> saveAndLaunchFile(
      Uint8List bytes, String fileName) async {
    // Uint8List data = Uint8List.fromList(bytes);
    MimeType type = MimeType.ZIP;

    await FileSaver.instance.saveAs(fileName, bytes, "zip", type);
  }
}
