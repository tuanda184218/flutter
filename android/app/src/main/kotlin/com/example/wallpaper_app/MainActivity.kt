package com.example.wallpaper_app

import android.app.WallpaperManager
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.IOException

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.flutter.epic/epic"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                val data = call.arguments as String
                val str = data.split(" ")

                if (call.method == "setWall") {
                    val imgFile = File(applicationContext.cacheDir, str[0])
                    val bitmap = BitmapFactory.decodeFile(imgFile.absolutePath)
                    val wallpaperManager: WallpaperManager? = WallpaperManager.getInstance(applicationContext)

                    try {
                        when (str[1]) {
                            "home" -> wallpaperManager?.setBitmap(bitmap, null, true, WallpaperManager.FLAG_SYSTEM)
                            "lock" -> wallpaperManager?.setBitmap(bitmap, null, true, WallpaperManager.FLAG_LOCK)
                            "both" -> wallpaperManager?.setBitmap(bitmap)
                        }
                        result.success("success")
                    } catch (e: IOException) {
                        result.success("failed")
                    }
                }
            }
    }
}