import 'dart:io';

import 'package:pass_flutter/src/models/pass_image.dart';
import 'package:pass_flutter/src/models/pass_json/pass_json.dart';

class PassFile {
  String id;

  File file;
  File passJson;

  Directory directory;

  PassImage background;
  PassImage footer;
  PassImage icon;
  PassImage logo;
  PassImage strip;
  PassImage thumbnail;

  PassJson pass;

  PassFile(String id, File passFile, Directory passDirectory) {
    this.id = id;
    this.file = passFile;
    this.directory = passDirectory;
  }
}
