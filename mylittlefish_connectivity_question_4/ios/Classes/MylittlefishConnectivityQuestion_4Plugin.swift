
import Flutter
import UIKit
import Network

public class MylittlefishConnectivityQuestion_4Plugin: NSObject, FlutterPlugin {
  private var eventSink: FlutterEventSink?
  private let monitor = NWPathMonitor()
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let methodChannel = FlutterMethodChannel(
      name: "mylittlefish_connectivity_question_4",
      binaryMessenger: registrar.messenger()
    )
    let eventChannel = FlutterEventChannel(
      name: "mylittlefish_connectivity_question_4/connectivity_status",
      binaryMessenger: registrar.messenger()
    )
    
    let instance = MylittlefishConnectivityQuestion_4Plugin()
    registrar.addMethodCallDelegate(instance, channel: methodChannel)
    eventChannel.setStreamHandler(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "hasConnectivity":
      result(monitor.currentPath.status != .unsatisfied)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

extension MylittlefishConnectivityQuestion_4Plugin: FlutterStreamHandler {
  public func onListen(withArguments arguments: Any?, eventSink: @escaping FlutterEventSink) -> FlutterError? {
    self.eventSink = eventSink
    
    monitor.pathUpdateHandler = { [weak self] path in
      self?.eventSink?(path.status != .unsatisfied)
    }
    
    monitor.start(queue: DispatchQueue.main)
    return nil
  }
  
  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    monitor.cancel()
    eventSink = nil
    return nil
  }
}