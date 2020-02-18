import 'dart:io';

class PasskitImage {
  File image;
  File image2x;
  File image3x;

  PasskitImage({File image, File image2x, File image3x}) {
    this.image = image;
    this.image2x = image2x;
    this.image3x = image3x;
  }
}
