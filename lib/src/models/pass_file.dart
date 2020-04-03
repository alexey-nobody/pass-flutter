import 'dart:io';

import 'package:pass_flutter/src/models/pass_image.dart';
import 'package:pass_flutter/src/models/pass_json/pass_json.dart';
import 'package:pass_flutter/src/pass_core.dart';

/// Parsed Apple Wallet pass file
class PassFile {
  /// Pass file id
  String id;

  /// passkit [File]
  File file;

  /// pass.json [File]
  File passJson;

  /// [Directory] with unpacked pass files
  Directory directory;

  /// The image displayed as the background of the front of the pass.
  PassImage background;

  /// The image displayed on the front of the pass near the barcode.
  PassImage footer;

  /// The pass’s icon. This is displayed in notifications and in emails that have a pass attached, and on the lock screen.
  /// When it is displayed, the icon gets a shine effect and rounded corners.
  PassImage icon;

  /// The image displayed on the front of the pass in the top left.
  PassImage logo;

  /// The image displayed behind the primary fields on the front of the pass.
  PassImage strip;

  /// An additional image displayed on the front of the pass. For example, on a membership card, the thumbnail could be used to a picture of the cardholder.
  PassImage thumbnail;

  /// A JSON dictionary that defines the pass.
  PassJson pass;

  /// Creates a new [PassFile]
  PassFile(String id, File passFile, Directory passDirectory) {
    this.id = id;
    this.file = passFile;
    this.directory = passDirectory;
  }

  /// Delete current pass file from memory
  void delete() {
    PassIo().delete(this.directory, this.file);
  }
}
