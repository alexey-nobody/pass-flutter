import 'dart:io';

import 'package:pass_flutter/src/models/images/passkit_image.dart';
import 'package:pass_flutter/src/models/passkit/passkit_pass.dart';

class PassFile {
  String id;

  File file;
  Directory directory;

  PasskitImage background;
  PasskitImage footer;
  PasskitImage icon;
  PasskitImage logo;
  PasskitImage strip;
  PasskitImage thumbnail;

  PasskitPass pass;
}