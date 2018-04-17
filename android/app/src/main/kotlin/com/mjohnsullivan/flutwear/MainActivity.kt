package com.mjohnsullivan.flutwear

import android.os.Bundle
import android.support.v4.view.ViewCompat.requestApplyInsets
import android.support.v4.view.ViewCompat.setOnApplyWindowInsetsListener
import android.support.v4.view.WindowInsetsCompat

import android.support.wear.ambient.AmbientMode
import android.util.Log

import io.flutter.app.FlutterActivity
import io.flutter.view.FlutterView
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


private const val ambientChannel = "com.mjohnsullivan.flutwear/ambient"
private const val shapeChannel = "com.mjohnsullivan.flutwear/shape"

class MainActivity: FlutterActivity(), AmbientMode.AmbientCallbackProvider {

  private val tag = "FlutterActivity"

  private var mAmbientController: AmbientMode.AmbientController? = null

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)

    // Keep the app running
    // window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)

    GeneratedPluginRegistrant.registerWith(this)

    // Set the Flutter ambient callbacks
    mAmbientController = AmbientMode.attachAmbientSupport(this)

    // Set a MethodChannel to return the shape of the watch
    setShapeMethodChannel()
  }

  // Set up the MethodChannel for Flutter to retrieve the watch face shape
  private fun setShapeMethodChannel() {
    MethodChannel(flutterView, shapeChannel).setMethodCallHandler { _, result ->
      setOnApplyWindowInsetsListener(flutterView, {_, insets: WindowInsetsCompat? ->
        if (insets?.isRound == true) {
          Log.d(tag, "round watch face")
          result.success(0)
        }
        else {
          Log.d(tag, "square watch face")
          result.success(1)
        }
        WindowInsetsCompat(insets)
      })
      requestApplyInsets(flutterView)
    }
  }

  override fun getAmbientCallback(): AmbientMode.AmbientCallback {
    return FlutterAmbientCallback(flutterView)
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