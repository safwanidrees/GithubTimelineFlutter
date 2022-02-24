import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class FileSaverHelper {
  static Future<void> saveAndLaunchFile(
      List<int> bytes, String fileName) async {
    html.AnchorElement anchorElement = html.AnchorElement(href: fileName);
    anchorElement.download = fileName;
    anchorElement.click();
  }
}
