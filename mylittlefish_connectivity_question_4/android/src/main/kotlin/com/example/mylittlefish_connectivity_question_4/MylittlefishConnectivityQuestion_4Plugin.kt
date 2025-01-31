package com.example.mylittlefish_connectivity_question_4

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.os.Handler
import android.os.Looper
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
  private var networkCallback: ConnectivityManager.NetworkCallback? = null
  private val mainHandler = Handler(Looper.getMainLooper())

  override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    context = binding.applicationContext
    connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

    mainHandler.post {
      methodChannel = MethodChannel(binding.binaryMessenger, "mylittlefish_connectivity_question_4")
      methodChannel.setMethodCallHandler(this)
      
      eventChannel = EventChannel(binding.binaryMessenger, "mylittlefish_connectivity_question_4/connectivity_status")
      eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
        override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
          eventSink = events
          startListeningNetworkState()
        }

        override fun onCancel(arguments: Any?) {
          stopListeningNetworkState()
          eventSink = null
        }
      })
    }
  }

  private fun startListeningNetworkState() {
    if (networkCallback != null) return

    networkCallback = object : ConnectivityManager.NetworkCallback() {
      override fun onAvailable(network: Network) {
        mainHandler.post {
          eventSink?.success(true)
        }
      }

      override fun onLost(network: Network) {
        mainHandler.post {
          eventSink?.success(false)
        }
      }
    }

    val networkRequest = NetworkRequest.Builder()
      .addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
      .build()

    mainHandler.post {
      try {
        connectivityManager.registerNetworkCallback(networkRequest, networkCallback!!)
      } catch (e: Exception) {

        print("Error registering network callback: ${e.message}")
      }
    }
  }

  private fun stopListeningNetworkState() {
    networkCallback?.let { callback ->
      mainHandler.post {
        try {
          connectivityManager.unregisterNetworkCallback(callback)
        } catch (e: Exception) {
         
          print("Error unregistering network callback: ${e.message}")
        }
      }
      networkCallback = null
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "hasConnectivity" -> {
        mainHandler.post {
          try {
            val network = connectivityManager.activeNetwork
            val capabilities = connectivityManager.getNetworkCapabilities(network)
            result.success(capabilities?.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET) == true)
          } catch (e: Exception) {
            result.error("CONNECTIVITY_ERROR", "Error checking connectivity", e.message)
          }
        }
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    mainHandler.post {
      methodChannel.setMethodCallHandler(null)
      eventChannel.setStreamHandler(null)
    }
    stopListeningNetworkState()
  }
}