part of 'passkit_core.dart';

class _PasskitUtils {
  static Future<String> generatePathToPass() async {
    Directory passesDir = await _PasskitIo().getPassesDir();
    String passFileName = Uuid().v1() + '.passkit';
    return '${passesDir.path}/$passFileName';
  }
}
