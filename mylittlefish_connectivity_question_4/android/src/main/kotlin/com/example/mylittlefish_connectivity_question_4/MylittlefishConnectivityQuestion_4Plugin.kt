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
    private val mainThreadHandler = Handler(Looper.getMainLooper())

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        
        mainThreadHandler.post {
            methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "mylittlefish_connectivity_question_4")
            eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "mylittlefish_connectivity_question_4/connectivity_status")
            
            methodChannel.setMethodCallHandler(this)
            eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                    eventSink = events
                    setupNetworkCallback()
                }

                override fun onCancel(arguments: Any?) {
                    removeNetworkCallback()
                    eventSink = null
                }
            })
        }
    }

    private fun setupNetworkCallback() {
        if (networkCallback != null) {
            return
        }

        networkCallback = object : ConnectivityManager.NetworkCallback() {
            override fun onAvailable(network: Network) {
                mainThreadHandler.post {
                    try {
                        eventSink?.success(true)
                    } catch (e: Exception) {
                        print("Error sending network available event: ${e.message}")
                    }
                }
            }

            override fun onLost(network: Network) {
                mainThreadHandler.post {
                    try {
                        eventSink?.success(false)
                    } catch (e: Exception) {
                        print("Error sending network lost event: ${e.message}")
                    }
                }
            }
        }

        val request = NetworkRequest.Builder()
            .addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
            .build()

        mainThreadHandler.post {
            try {
                connectivityManager.registerNetworkCallback(request, networkCallback!!)
            } catch (e: Exception) {
                print("Error registering network callback: ${e.message}")
            }
        }
    }

    private fun removeNetworkCallback() {
        networkCallback?.let { callback ->
            mainThreadHandler.post {
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
                mainThreadHandler.post {
                    try {
                        val network = connectivityManager.activeNetwork
                        val capabilities = connectivityManager.getNetworkCapabilities(network)
                        val hasInternet = capabilities?.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET) == true
                        result.success(hasInternet)
                    } catch (e: Exception) {
                        result.error("CONNECTIVITY_ERROR", "Error checking connectivity", e.message)
                    }
                }
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        mainThreadHandler.post {
            methodChannel.setMethodCallHandler(null)
            eventChannel.setStreamHandler(null)
        }
        removeNetworkCallback()
    }
}