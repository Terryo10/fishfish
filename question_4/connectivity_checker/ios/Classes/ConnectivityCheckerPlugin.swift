import Flutter
import Network

public class ConnectivityCheckerPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    private var eventSink: FlutterEventSink?
    private let monitor = NWPathMonitor()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = ConnectivityCheckerPlugin()

        let methodChannel = FlutterMethodChannel(name: "connectivity_checker", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: methodChannel)

        let eventChannel = FlutterEventChannel(name: "connectivity_checker/events", binaryMessenger: registrar.messenger())
        eventChannel.setStreamHandler(instance)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "checkConnectivity":
            result(isConnected())
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        startMonitoring()
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        monitor.cancel()
        return nil
    }

    private func isConnected() -> Bool {
        return monitor.currentPath.status == .satisfied
    }

    private func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            self.eventSink?(path.status == .satisfied)
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}