import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:pass_flutter/pass_flutter.dart';
import 'package:pass_flutter/src/models/pass_json/pass_json.dart';
import 'package:pass_flutter/src/pass_core.dart';

/// Parsed Apple Wallet pass file
class PassFile extends Equatable {
  /// Creates a new instance of [PassFile]
  const PassFile({
    required this.id,
    required this.file,
    required this.directory,
    required this.pass,
    this.background,
    this.footer,
    this.icon,
    this.logo,
    this.strip,
    this.thumbnail,
  });

  /// Pass file id
  final String id;

  /// passkit [File]
  final File file;

  /// [Directory] with unpacked pass files
  final Directory directory;

  /// The image displayed as the background of the front of the pass.
  final PassImage? background;

  /// The image displayed on the front of the pass near the barcode.
  final PassImage? footer;

  /// The pass’s icon. This is displayed in notifications and in emails that have a pass attached, and on the lock screen.
  /// When it is displayed, the icon gets a shine effect and rounded corners.
  final PassImage? icon;

  /// The image displayed on the front of the pass in the top left.
  final PassImage? logo;

  /// The image displayed behind the primary fields on the front of the pass.
  final PassImage? strip;

  /// An additional image displayed on the front of the pass. For example, on a membership card, the thumbnail could be used to a picture of the cardholder.
  final PassImage? thumbnail;

  /// A JSON dictionary that defines the pass.
  final PassJson pass;

  @override
  List<Object> get props => [pass];

  /// Save current [PassFile] to internal memory and delete previewed pass file
  Future<void> save() async {
    await PassFileIO().saveFromPath(externalPassFile: file);
    PassFileIO().delete(directory, file);
  }

  /// Delete current pass file from memory
  void delete() {
    PassFileIO().delete(directory, file);
  }
}
