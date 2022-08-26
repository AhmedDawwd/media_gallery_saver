import 'dart:math';

import 'package:media_gallery_saver/src/media_gallery_saver_method_channel.dart';
import 'package:media_gallery_saver/src/type.dart';

import 'src/media_gallery_saver_platform_interface.dart';
export 'src/type.dart';

class MediaGallerySaver {
  Future<String?> getPlatformVersion() {
    return MediaGallerySaverPlatform.instance.getPlatformVersion();
  }

  Future<List<String>> getExternalStorageDirectories() async {
    return await MediaGallerySaverPlatform.instance
        .getExternalStorageDirectories();
  }

  Future<String> getExternalStoragePublicDirectory(
      {required Environment environment}) async {
    return await MediaGallerySaverPlatform.instance
        .getExternalStoragePublicDirectory(getEnvironmentDir(environment));
  }

  Future<String> getExternalStorageDefaultDirectoriesPath(
      {required Environment environment}) async {
    return await MediaGallerySaverPlatform.instance
        .getExternalStorageDefaultDirectoriesPath(
            getEnvironmentDir(environment));
  }

  Future<bool?> createAlbum({
    required String albumName,
    required Environment environment,
  }) async {
    return await MediaGallerySaverPlatform.instance.createAlbum(
        albumName: albumName, albumType: getEnvironmentDir(environment));
  }

  Future<String?> getPathAlbum({
    required String albumName,
    required Environment environment,
  }) async {
    return await MediaGallerySaverPlatform.instance.getPathAlbum(
        albumName: albumName, albumType: getEnvironmentDir(environment));
  }

  Future<String?> getPathFileInAlbum(
      {required String albumName,
      required Environment environment,
      required String fileName}) async {
    return await MediaGallerySaverPlatform.instance.getPathFileInAlbum(
        albumName: albumName,
        albumType: getEnvironmentDir(environment),
        fileName: fileName);
  }

  Future<bool?> saveAlbum(
      {required String albumName,
      required Environment environment,
      required List<String> filePath}) async {
    return await MediaGallerySaverPlatform.instance.saveAlbum(
        albumName: albumName,
        filePaths: filePath,
        albumType: getEnvironmentDir(environment));
  }

  saveVideo(
    String path, {
    String? albumName,
    required Environment environment,
    Map<String, String>? headers,
  }) async {
    return await MediaGallerySaverPlatform.instance.saveVideo(path,
        albumName: albumName,
        albumType: getEnvironmentDir(environment),
        headers: headers);
  }

  Future<bool?> saveImage(
    String path, {
    String? albumName,
    required Environment environment,
    Map<String, String>? headers,
  }) async {
    return await MediaGallerySaverPlatform.instance.saveImage(path,
        albumName: albumName,
        albumType: getEnvironmentDir(environment),
        headers: headers);
  }

  String getEnvironmentDir(Environment environment) {
    switch (environment) {
      case Environment.DIRECTORY_DCIM:
        return dirDCIM;
      case Environment.DIRECTORY_ALARMS:
        return dirALARMS;
      case Environment.DIRECTORY_AUDIOBOOKS:
        return dirAUDIOBOOKS;
      case Environment.DIRECTORY_DOCUMENTS:
        return dirDOCUMENTS;
      case Environment.DIRECTORY_DOWNLOADS:
        return dirDOWNLOADS;
      case Environment.DIRECTORY_MOVIES:
        return dirMOVIES;
      case Environment.DIRECTORY_MUSIC:
        return dirMUSIC;
      case Environment.DIRECTORY_NOTIFICATIONS:
        return dirNOTIFICATIONS;
      case Environment.DIRECTORY_PICTURES:
        return dirPICTURES;
      case Environment.DIRECTORY_RINGTONES:
        return dirRINGTONES;
      case Environment.DIRECTORY_PODCASTS:
        return dirPODCASTS;
      case Environment.DIRECTORY_SCREENSHOTS:
        return dirSCREENSHOTS;
      default:
        return throw UnimplementedError('null String');
    }
  }
}
