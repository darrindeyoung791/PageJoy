package com.pagejoy.app

import android.os.Bundle
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import io.flutter.embedding.android.FlutterActivity


class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // 必须在 super.onCreate 之前
        installSplashScreen()
        super.onCreate(savedInstanceState)
    }
}
