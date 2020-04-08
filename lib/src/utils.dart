import 'package:uuid/uuid.dart';

/// Utils
class Utils {
  /// Generate [String] pass id
  static String generatePassId() {
    return Uuid().v1();
  }
}
