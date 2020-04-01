import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pass_flutter/src/models/pass_image.dart';
import 'package:pass_flutter/src/models/pass_file.dart';
import 'package:pass_flutter/src/models/pass_json/pass_json.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

part 'pass_io.dart';
part 'pass_parser.dart';

/// The Android implementation of Apple Passkit.
///
/// This class implements the `package:pass_flutter` functionality for
/// the Android platform.
class Pass {
  static const String _channelName = 'pass_flutter';
  static const MethodChannel _channel = MethodChannel(_channelName);

  /// Save pass file from [url] to internal memory,
  /// parse and return [PassFile]
  Future<PassFile> getFromUrl(String url) async {
    PassFile passFile = await _PassIo().createOrGetPass();
    String pathToSave = passFile.file.path;
    Response responce = await Dio().download(url, pathToSave);
    if (responce.statusCode == 200) {
      return await _PassParser().parse(passFile);
    }
    throw ('Unable to download pass file at specified url');
  }

  /// Return all saved pass files from internal memory in List of [PassFile]
  Future<List<PassFile>> getAllSaved() async {
    List<PassFile> parsedPasses = [];
    Directory passesDir = await _PassIo().getPassesDir();
    List<FileSystemEntity> passes = await passesDir.list().toList();
    for (var entity in passes) {
      if (entity is File) {
        String passId = path.basenameWithoutExtension(entity.path);
        PassFile passFile = await _PassIo().createOrGetPass(passId: passId);
        try {
          passFile = await _PassParser().parse(passFile);
          parsedPasses.add(passFile);
        } catch (e) {
          debugPrint('Error parse pass file - ${passFile.file.path}');
          this.delete(passFile);
        }
      }
    }
    return parsedPasses;
  }

  /// Delete all files and folders for [passFile] from internal memory
  void delete(PassFile passFile) {
    _PassIo().delete(passFile.directory, passFile.file);
  }

  /// Platform version
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
