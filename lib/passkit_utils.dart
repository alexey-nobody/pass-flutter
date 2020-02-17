library passkit.utils;

import 'package:uuid/uuid.dart';

import 'passkit_io.dart';

class PasskitUtils {
  static Future<String> generatePathToPass() async {
    String passesDir = await PasskitIo().getPassesDir();
    String passFileName = Uuid().v1() + '.passkit';
    return '$passesDir$passFileName';
  }
}
