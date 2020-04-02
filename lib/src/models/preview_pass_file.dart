import 'dart:io';

import 'package:pass_flutter/pass_flutter.dart';
import 'package:pass_flutter/src/models/pass_file.dart';
import 'package:pass_flutter/src/pass_core.dart';

/// Preview of parsed Apple Wallet pass file
class PreviewPassFile extends PassFile {
  /// Save current PassFile to internal memory
  Future<PassFile> save() async {
    return await PassIo().saveFromPath(externalPassFile: this.file);
  }

  /// Create a new [PreviewPassFile]
  PreviewPassFile(
    String id,
    File passFile,
    Directory passDirectory,
  ) : super(id, passFile, passDirectory);
}
