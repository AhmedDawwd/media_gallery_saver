import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:media_gallery_saver/media_gallery_saver.dart';
import 'package:media_gallery_saver/src/media_gallery_saver_platform_interface.dart';
import 'package:media_gallery_saver/src/media_gallery_saver_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMediaGallerySaverPlatform
    with MockPlatformInterfaceMixin
    implements MediaGallerySaverPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<List<String>> getExternalStorageDirectories() {
    throw UnimplementedError();
  }

  @override
  Future<String> getExternalStorageDefaultDirectoriesPath(String type) {
    // TODO: implement getExternalStorageDefaultDirectoriesPath
    throw UnimplementedError();
  }

  @override
  Future<String> getExternalStoragePublicDirectory(String type) {
    // TODO: implement getExternalStoragePublicDirectory
    throw UnimplementedError();
  }

  @override
  Future<bool?> saveImage(String path,
      {String? albumName, String? albumType, Map<String, String>? headers}) {
    // TODO: implement saveImage
    throw UnimplementedError();
  }

  @override
  Future<bool?> saveVideo(String path,
      {String? albumName, String? albumType, Map<String, String>? headers}) {
    // TODO: implement saveVideo
    throw UnimplementedError();
  }

  @override
  Future<File> downloadFile(String url, {Map<String, String>? headers}) {
    // TODO: implement downloadFile
    throw UnimplementedError();
  }

  @override
  Future<bool?> createAlbum({String? albumName, String? albumType}) {
    // TODO: implement createAlbum
    throw UnimplementedError();
  }

  @override
  Future<String?> getPathAlbum({String? albumName, String? albumType}) {
    // TODO: implement getPathAlbum
    throw UnimplementedError();
  }

  @override
  Future<String?> getPathFileInAlbum(
      {String? albumName, String? albumType, String? fileName}) {
    // TODO: implement getPathFileInAlbum
    throw UnimplementedError();
  }

  @override
  Future<bool?> saveAlbum(
      {String? albumName, List<String>? filePaths, String? albumType}) {
    // TODO: implement saveAlbum
    throw UnimplementedError();
  }
}

void main() {
  final MediaGallerySaverPlatform initialPlatform =
      MediaGallerySaverPlatform.instance;

  test('$MethodChannelMediaGallerySaver is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMediaGallerySaver>());
  });

  test('getPlatformVersion', () async {
    MediaGallerySaver mediaGallerySaverPlugin = MediaGallerySaver();
    MockMediaGallerySaverPlatform fakePlatform =
        MockMediaGallerySaverPlatform();
    MediaGallerySaverPlatform.instance = fakePlatform;

    expect(await mediaGallerySaverPlugin.getPlatformVersion(), '42');
  });
}
