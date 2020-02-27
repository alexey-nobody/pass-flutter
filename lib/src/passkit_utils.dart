part of 'passkit_core.dart';

class _PasskitUtils {
  static Future<File> generatePassFile() async {
    Directory passesDir = await _PasskitIo().getPassesDir();
    String passFileName = Uuid().v1() + '.passkit';
    return File('${passesDir.path}/$passFileName');
  }
}
