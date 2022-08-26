package com.metalap.media_gallery_saver

import android.content.Context
import android.content.Intent
import android.content.Intent.ACTION_MEDIA_SCANNER_SCAN_FILE
import android.content.Intent.ACTION_MEDIA_SCANNER_STARTED
import android.net.Uri
import android.os.Environment
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result
import android.os.Handler
import java.io.File
import java.io.FileInputStream
import kotlin.concurrent.thread

class MediaSaver {

    private lateinit var context: Context
    private lateinit var handler: Handler




     fun saveAlbum(call: MethodCall, result: Result) {

        val albumName = call.argument<String>("albumName")
        val filePaths = call.argument<List<String>>("filePaths")
        val albumType = call.argument<String>("albumType")

        if (albumName == null) {
            result.error("100", "albumName is not null", null)
            return
        }
        if (filePaths == null) {
            result.error("101", "filePaths is not null", null)
            return
        }
        thread {
            val rootFile = File(context.getExternalFilesDir(albumType), albumName)
            if (!rootFile.exists()) {
                rootFile.mkdirs()
            }

            val resultPaths = mutableListOf<String>()

            try {
                for (path in filePaths) {
                    val fileName: String = if (path.lastIndexOf('.') == -1) {
                        "${System.currentTimeMillis()}"
                    } else {
                        val suffix: String = path.substring(path.lastIndexOf(".") + 1)
                        "${System.currentTimeMillis()}.$suffix"
                    }
                    val itemFile = File(rootFile, fileName)
                    if (!itemFile.exists()) itemFile.createNewFile()
                    val outPut = itemFile.outputStream()
                    val inPut = FileInputStream(path)
                    val buf = ByteArray(1024)
                    var len = 0
                    while (true) {
                        len = inPut.read(buf)
                        if (len == -1) break
                        outPut.write(buf, 0, len)
                    }
                    outPut.flush()
                    outPut.close()

                    inPut.close()
                    resultPaths.add(itemFile.absolutePath)
                    handler.post {
                        context!!.sendBroadcast(Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, Uri.fromFile(itemFile)))
                    }
                }
                handler.post {
                    result.success(true)
                }
            } catch (e: Exception) {
                handler.post {
                    result.success(false)
                }
            }
        }
    }
}