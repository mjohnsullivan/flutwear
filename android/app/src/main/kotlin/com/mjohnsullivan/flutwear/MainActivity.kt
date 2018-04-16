package com.mjohnsullivan.flutwear

import android.os.Bundle
import android.support.v4.view.OnApplyWindowInsetsListener
import android.support.v4.view.ViewCompat.requestApplyInsets
import android.support.v4.view.ViewCompat.setOnApplyWindowInsetsListener
import android.support.v4.view.WindowInsetsCompat

import android.support.wear.ambient.AmbientMode
import android.util.Log
import android.view.View

import io.flutter.app.FlutterActivity
import io.flutter.view.FlutterView
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


private const val ambientChannel = "com.mjohnsullivan.flutwear/ambient"
private const val shapeChannel = "com.mjohnsullivan.flutwear/shape"

class MainActivity: FlutterActivity(), AmbientMode.AmbientCallbackProvider {

  private var mAmbientController: AmbientMode.AmbientController? = null

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)

    // Keep the app running
    // window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)

    GeneratedPluginRegistrant.registerWith(this)

    // Set the Flutter ambient callbacks
    mAmbientController = AmbientMode.attachAmbientSupport(this)

    // Passes the watch face shape to Flutter through the shapeChannel
    MethodChannel(flutterView, shapeChannel).setMethodCallHandler { _, result ->
      setOnApplyWindowInsetsListener(flutterView, MyOnApplyWindowInsetsListener(result))
      requestApplyInsets(flutterView)
    }
  }

  override fun onPause() {
    MethodChannel(flutterView, ambientChannel).invokeMethod("unknown", null)
    super.onPause()
  }

  override fun getAmbientCallback(): AmbientMode.AmbientCallback {
    return FlutterAmbientCallback(flutterView)
  }
}

/*
 * Passes watch face shape back through the
 */
private class MyOnApplyWindowInsetsListener(val result: MethodChannel.Result) : OnApplyWindowInsetsListener {

  private val tag = "Watch Face Shape Detect"

  override fun onApplyWindowInsets(v: View?, insets: WindowInsetsCompat?): WindowInsetsCompat {
    if (insets?.isRound == true) {
      Log.d(tag, "round watchface")
      result.success(0)
    }
    else {
      Log.d(tag, "square watchface")
      result.success(1)
    }
    return WindowInsetsCompat(insets)
  }
}

/*
 * Pass ambient callback back to Flutter
 */
private class FlutterAmbientCallback(val flutterView: FlutterView): AmbientMode.AmbientCallback() {

  private val tag = "Ambient Callback"
  
  override fun onEnterAmbient(ambientDetails: Bundle) {
    MethodChannel(flutterView, ambientChannel).invokeMethod("enter", null)
    Log.d(tag, "Entering Ambient")
    super.onEnterAmbient(ambientDetails)
  }

  override fun onExitAmbient() {
    MethodChannel(flutterView, ambientChannel).invokeMethod("exit", null)
    Log.d(tag, "Exiting Ambient")
    super.onExitAmbient()
  }

  override fun onUpdateAmbient() {
    MethodChannel(flutterView, ambientChannel).invokeMethod("update", null)
    Log.d(tag, "Updating Ambient")
    super.onUpdateAmbient()
  }

}