package com.example.mylittlefish_connectivity_question_4

import android.app.Activity
import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result

class MylittlefishConnectivityQuestion_4Plugin: FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {
  private lateinit var methodChannel: MethodChannel
  private lateinit var eventChannel: EventChannel
  private var activity: Activity? = null
  private var eventSink: EventChannel.EventSink? = null
  private lateinit var connectivityManager: ConnectivityManager
  private var networkCallback: ConnectivityManager.NetworkCallback? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "mylittlefish_connectivity_question_4")
    methodChannel.setMethodCallHandler(this)
    
    eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "mylittlefish_connectivity_question_4/connectivity_status")
    eventChannel.setStreamHandler(ConnectivityStreamHandler())
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    connectivityManager = activity?.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "hasConnectivity" -> {
        activity?.runOnUiThread {
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
    methodChannel.setMethodCallHandler(null)
    eventChannel.setStreamHandler(null)
  }

  private inner class ConnectivityStreamHandler : EventChannel.StreamHandler {
    override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
      eventSink = events
      registerNetworkCallback()
    }

    override fun onCancel(arguments: Any?) {
      unregisterNetworkCallback()
      eventSink = null
    }
  }

  private fun registerNetworkCallback() {
    if (networkCallback != null) return

    networkCallback = object : ConnectivityManager.NetworkCallback() {
      override fun onAvailable(network: Network) {
        activity?.runOnUiThread {
          eventSink?.success(true)
        }
      }

      override fun onLost(network: Network) {
        activity?.runOnUiThread {
          eventSink?.success(false)
        }
      }
    }

    val networkRequest = NetworkRequest.Builder()
      .addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
      .build()

    try {
      connectivityManager.registerNetworkCallback(networkRequest, networkCallback!!)
    } catch (e: Exception) {
      // Handle registration error
    }
  }

  private fun unregisterNetworkCallback() {
    try {
      networkCallback?.let { callback ->
        connectivityManager.unregisterNetworkCallback(callback)
        networkCallback = null
      }
    } catch (e: Exception) {
      // Handle unregistration error
    }
  }
}