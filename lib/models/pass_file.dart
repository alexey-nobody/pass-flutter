import 'package:passkit/models/images/passkit_image.dart';
import 'package:passkit/models/passkit/passkit_pass.dart';

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