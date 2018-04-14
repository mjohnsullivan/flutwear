package com.mjohnsullivan.flutwear

import android.os.Bundle
import android.support.wear.ambient.AmbientModeSupport
import android.view.WindowManager

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity: FlutterActivity(), AmbientModeSupport.AmbientCallbackProvider {

  private var mAmbientController: AmbientModeSupport.AmbientController? = null

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)

    // Keep the app running
    // TODO: remove when ambient works
    window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)

    GeneratedPluginRegistrant.registerWith(this)

    mAmbientController = AmbientModeSupport.
  }

  override fun getAmbientCallback(): AmbientModeSupport.AmbientCallback {
    return MyAmbientCallback()
  }
}


private class MyAmbientCallback: AmbientModeSupport.AmbientCallback() {

  override fun onEnterAmbient(ambientDetails: Bundle) {
    // Implement
  }

  override fun onExitAmbient() {
    // Implement
  }

  override fun onUpdateAmbient() {
    // Implement
  }

}