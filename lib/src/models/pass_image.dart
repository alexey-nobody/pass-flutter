import 'dart:io';

class PassImage {
  File image;
  File image2x;
  File image3x;

  PassImage(File image, File image2x, File image3x) {
    this.image = image;
    this.image2x = image2x;
    this.image3x = image3x;
  }
}
