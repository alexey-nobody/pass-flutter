import 'dart:io';

import 'package:pass_flutter/pass_flutter.dart';
import 'package:pass_flutter/src/models/pass_file.dart';

/// Preview of parsed Apple Wallet pass file
class PreviewPassFile extends PassFile {
  /// Create a new [PreviewPassFile]
  PreviewPassFile({
    String id,
    File passFile,
    Directory passDirectory,
  }) : super(id, passFile, passDirectory);
}
