import 'dart:io';

/// Element of images in passkit
class PassImage {
  /// [File] png image for standard-resolution display
  File image;

  /// [File] png image for retina-resolution display
  File image2x;

  /// [File] png original image
  File image3x;

  /// Creates a new [PassImage]
  PassImage(File image, File image2x, File image3x) {
    this.image = image;
    this.image2x = image2x;
    this.image3x = image3x;
  }
}
