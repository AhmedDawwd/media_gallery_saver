package com.metalap.media_gallery_saver

import android.content.Context
import android.os.Build
import android.os.Environment
import android.os.Environment.getExternalStoragePublicDirectory
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File

/** MediaGallerySaverPlugin */
class MediaGallerySaverPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var mediaGallerySaver: MediaGallerySaver
  private lateinit var  manageStorageDirectories:ManageStorageDirectories
  private lateinit var mediaSaver:MediaSaver

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "media_gallery_saver")
    channel.setMethodCallHandler(this)
  }

  @RequiresApi(Build.VERSION_CODES.KITKAT)
  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }
    else if(call.method == "getExternalStorageDirectories"){
      result.success(manageStorageDirectories.getExternalStorageDirectories())
    }
    else if(call.method == "getExternalStoragePublicDirectory"){
      result.success(manageStorageDirectories.getExternalStoragePublicDirectory(call.argument<String>("type")))
    }
    else if(call.method == "getExternalStorageDefaultDirectoriesPath"){
      result.success(manageStorageDirectories.getExternalStorageDefaultDirectoriesPath(call.argument<String>("type")))
    }
    else if(call.method == "createAlbum"){
      result.success(manageStorageDirectories.createAlbum(call,result))
    }
    else if(call.method == "getPathAlbum"){
      result.success(manageStorageDirectories.getPathAlbum(call))
    }
    else if(call.method == "getPathFileInAlbum"){
      result.success(manageStorageDirectories.getPathFileInAlbum(call))
    }
    else if(call.method == "saveAlbum"){
      result.success(mediaSaver.saveAlbum(call,result))
    }
    else if(call.method == "saveImage"){
      result.success(mediaGallerySaver.checkPermissionAndSaveFile(call,result,MediaType.Image))
    }
    else if(call.method == "saveVideo"){
      result.success(mediaGallerySaver.checkPermissionAndSaveFile(call,result,MediaType.Video))
    }
    else {
      result.notImplemented()
    }
  }


  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
