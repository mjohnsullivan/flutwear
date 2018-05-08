package com.mjohnsullivan.flutwear

import android.os.Bundle

import android.support.wear.ambient.AmbientMode
import com.mjohnsullivan.flutterwear.wear.FlutterAmbientCallback
import com.mjohnsullivan.flutterwear.wear.getChannel

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity(), AmbientMode.AmbientCallbackProvider {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    // Wire up the activity for ambient callbacks
    AmbientMode.attachAmbientSupport(this)
  }

  override fun getAmbientCallback(): AmbientMode.AmbientCallback {
    return FlutterAmbientCallback(getChannel(flutterView))
  }
}