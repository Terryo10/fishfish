package com.example.mylittlefish_connectivity_question_4

import android.content.Context
import android.net.ConnectivityManager
import android.os.Handler
import android.os.Looper
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result

class MylittlefishConnectivityQuestion_4Plugin: FlutterPlugin, MethodChannel.MethodCallHandler {
  private lateinit var methodChannel: MethodChannel
  private lateinit var eventChannel: EventChannel
  private lateinit var context: Context
  private var eventSink: EventChannel.EventSink? = null
  private lateinit var connectivityManager: ConnectivityManager

  override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    context = binding.applicationContext
    methodChannel = MethodChannel(binding.binaryMessenger, "mylittlefish_connectivity_question_4")
    methodChannel.setMethodCallHandler(this)
    
    eventChannel = EventChannel(binding.binaryMessenger, "mylittlefish_connectivity_question_4/connectivity_status")
    eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
      override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
        eventSink = events
        startListeningNetworkState()
      }

      override fun onCancel(arguments: Any?) {
        eventSink = null
      }
    })
    
    connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
  }

  private fun startListeningNetworkState() {
    val networkCallback = object : ConnectivityManager.NetworkCallback() {
        override fun onAvailable(network: Network) {
            Handler(Looper.getMainLooper()).post {
                eventSink?.success(true)
            }
        }

        override fun onLost(network: Network) {
            Handler(Looper.getMainLooper()).post {
                eventSink?.success(false)
            }
        }
    }

    val networkRequest = NetworkRequest.Builder()
        .addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
        .build()

    connectivityManager.registerNetworkCallback(networkRequest, networkCallback)
}


  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "hasConnectivity" -> {
        val network = connectivityManager.activeNetwork
        val capabilities = connectivityManager.getNetworkCapabilities(network)
        result.success(capabilities?.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET) == true)
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    methodChannel.setMethodCallHandler(null)
    eventChannel.setStreamHandler(null)
  }
}
