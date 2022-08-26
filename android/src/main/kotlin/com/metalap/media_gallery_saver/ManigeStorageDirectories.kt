package com.metalap.media_gallery_saver

import android.content.Context
import android.os.Build
import android.os.Environment
import android.os.Handler
import android.provider.ContactsContract
import androidx.annotation.RequiresApi
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File
import kotlin.concurrent.thread

class ManageStorageDirectories {

    private lateinit var context: Context
    private lateinit var handler: Handler

    @RequiresApi(Build.VERSION_CODES.KITKAT)
    fun getExternalStorageDirectories() : ArrayList<String> {
        val appsDir: Array<File> = context.getExternalFilesDirs(null)
        var extRootPaths: ArrayList<String> = ArrayList<String>()
        for (file: File in appsDir)
            extRootPaths.add(file.getAbsolutePath())
        return extRootPaths;
        // return Environment.getExternalStorageDirectory().toString();
    }

    fun getExternalStorageDefaultDirectoriesPath(type: String?): String {
        val path : File? = context.getExternalFilesDir(type)
        return  path?.path.toString()
    }

    fun getExternalStoragePublicDirectory(type: String?) : String {
        return context.getExternalFilesDir(type).toString()
    }


     fun createAlbum(call: MethodCall, result: Result) {
         val albumName = call.argument<String>("albumName")
         val albumType = call.argument<String>("albumType")

        if (albumName == null) {
            result.success(false)
            return
        }
        thread {
            val rootFile = File(context.getExternalFilesDir(albumType), albumName)
            if (!rootFile.exists()) {
                rootFile.mkdirs()
            }
            handler.post {
                result.success(true)
            }
        }
    }

    fun getPathAlbum(call: MethodCall): String? {
        val albumName = call.argument<String>("albumName")
        val albumType = call.argument<String>("albumType")
        if (albumName == null) {
            //result.success(false)
            return null
        }
            val rootFile = File(context.getExternalFilesDir(albumType)?.path,albumName)
            //return rootFile.path.toString();
            if (rootFile.exists()) {
                return rootFile.path.toString()
            }
            return null
    }

    fun getPathFileInAlbum(call: MethodCall): String? {
        val albumName = call.argument<String>("albumName")
        val albumType = call.argument<String>("albumType")
        val fileName = call.argument<String>("fileName")
        if (albumName == null) {
            //result.success(false)
            return null
        }
        val rootFile = File(context.getExternalFilesDir(albumType)?.path+albumName,fileName)
        //return rootFile.path.toString();
        if (rootFile.exists()) {
            return rootFile.path.toString()
        }
        return null
    }
}