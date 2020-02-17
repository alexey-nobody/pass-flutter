part of 'passkit.dart';

class _PasskitUtils {
  static Future<String> generatePathToPass() async {
    String passesDir = await _PasskitIo().getPassesDir();
    String passFileName = Uuid().v1() + '.passkit';
    return '$passesDir$passFileName';
  }
}
