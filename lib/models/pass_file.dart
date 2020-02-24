import 'package:pass_flutter/models/images/passkit_image.dart';
import 'package:pass_flutter/models/passkit/passkit_pass.dart';

class PassFile {
  String id;

  PasskitImage background;
  PasskitImage footer;
  PasskitImage icon;
  PasskitImage logo;
  PasskitImage strip;
  PasskitImage thumbnail;

  PasskitPass pass;
}