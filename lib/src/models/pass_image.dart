import 'dart:io';

/// Element of images in passkit
class PassImage {
  /// Creates a new [PassImage]
  const PassImage({
    required this.image,
    required this.image2x,
    required this.image3x,
  });

  /// [File] png image for standard-resolution display
  final File? image;

  /// [File] png image for retina-resolution display
  final File? image2x;

  /// [File] png original image
  final File? image3x;
}
