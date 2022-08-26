import 'dart:io';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'media_gallery_saver_method_channel.dart';

abstract class MediaGallerySaverPlatform extends PlatformInterface {
  /// Constructs a MediaGallerySaverPlatform.
  MediaGallerySaverPlatform() : super(token: _token);

  static final Object _token = Object();

  static MediaGallerySaverPlatform _instance = MethodChannelMediaGallerySaver();

  /// The default instance of [MediaGallerySaverPlatform] to use.
  ///
  /// Defaults to [MethodChannelMediaGallerySaver].
  static MediaGallerySaverPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MediaGallerySaverPlatform] when
  /// they register themselves.
  static set instance(MediaGallerySaverPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<List<String>> getExternalStorageDirectories() {
    throw UnimplementedError(
        'getExternalStorageDirectories() has not been implemented.');
  }

  Future<String> getExternalStoragePublicDirectory(String type) {
    throw UnimplementedError(
        'getExternalStoragePublicDirectory() has not been implemented.');
  }

  Future<String> getExternalStorageDefaultDirectoriesPath(String type) {
    throw UnimplementedError(
        'getExternalStorageDefaultDirectoriesPath() has not been implemented.');
  }

  Future<bool?> createAlbum({
    String? albumName,
    String? albumType,
  }) {
    throw UnimplementedError('createAlbum() has not been implemented.');
  }

  Future<String?> getPathAlbum({
    String? albumName,
    String? albumType,
  }) {
    throw UnimplementedError('getPathAlbum() has not been implemented.');
  }

  Future<String?> getPathFileInAlbum(
      {String? albumName, String? albumType, String? fileName}) {
    throw UnimplementedError('getPathFileInAlbum() has not been implemented.');
  }

  Future<bool?> saveAlbum(
      {String? albumName, List<String>? filePaths, String? albumType}) {
    throw UnimplementedError('saveAlbum() has not been implemented.');
  }

  Future<bool?> saveVideo(
    String path, {
    String? albumName,
    String? albumType,
    Map<String, String>? headers,
  }) {
    throw UnimplementedError('saveVideo() has not been implemented.');
  }

  Future<bool?> saveImage(
    String path, {
    String? albumName,
    String? albumType,
    Map<String, String>? headers,
  }) {
    throw UnimplementedError('saveImage() has not been implemented.');
  }

  Future<File> downloadFile(String url, {Map<String, String>? headers}) {
    throw UnimplementedError('_downloadFile() has not been implemented.');
  }
}
