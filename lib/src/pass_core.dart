import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pass_flutter/pass_flutter.dart';
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

  /// Return all saved pass files from internal memory in List of [PassFile]
  Future<List<PassFile>> getAllSaved() async {
    List<PassFile> parsedPasses = await PassIo().getAllSaved();
    return parsedPasses;
  }

  /// Save pass file from [urlToPass] to internal memory, parse and return [PassFile]
  Future<PassFile> saveFromUrl({@required String urlToPass}) async {
    PassFile savedPass = await PassIo().saveFromUrl(url: urlToPass);
    return savedPass;
  }

  /// Delete all files and folders for [passFile] from internal memory and return saved passes
  Future<List<PassFile>> delete(PassFile passFile) async {
    PassIo().delete(passFile.directory, passFile.file);
    List<PassFile> parsedPasses = await PassIo().getAllSaved();
    return parsedPasses;
  }

  /// Platform version
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
