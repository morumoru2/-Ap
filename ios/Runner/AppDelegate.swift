import Flutter
import UIKit
import BackgroundTasks

class ICloudBridge: NSObject, FlutterPlugin {
  private static let channelName = "com.oshimemo.oshi_memo/icloud"
  private static let containerId = "iCloud.com.oshimemo.oshiMemo"

  static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: channelName,
      binaryMessenger: registrar.messenger()
    )
    let instance = ICloudBridge()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "isICloudAvailable":
      result(FileManager.default.ubiquityIdentityToken != nil)
    case "getICloudDocumentsPath":
      result(ICloudBridge.iCloudDocumentsPath())
    case "pushDatabase":
      guard let args = call.arguments as? [String: Any],
            let localPath = args["localPath"] as? String,
            let fileName = args["fileName"] as? String else {
        result(false)
        return
      }
      result(ICloudBridge.pushDatabase(localPath: localPath, fileName: fileName))
    case "pullDatabaseIfNewer":
      guard let args = call.arguments as? [String: Any],
            let localPath = args["localPath"] as? String,
            let fileName = args["fileName"] as? String else {
        result(false)
        return
      }
      result(ICloudBridge.pullDatabaseIfNewer(localPath: localPath, fileName: fileName))
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private static func iCloudDocumentsURL() -> URL? {
    guard let container = FileManager.default.url(forUbiquityContainerIdentifier: containerId) else {
      return nil
    }
    let documents = container.appendingPathComponent("Documents")
    if !FileManager.default.fileExists(atPath: documents.path) {
      try? FileManager.default.createDirectory(at: documents, withIntermediateDirectories: true)
    }
    return documents
  }

  private static func iCloudDocumentsPath() -> String? {
    iCloudDocumentsURL()?.path
  }

  private static func pushDatabase(localPath: String, fileName: String) -> Bool {
    guard let icloudDir = iCloudDocumentsURL() else { return false }
    let source = URL(fileURLWithPath: localPath)
    let dest = icloudDir.appendingPathComponent(fileName)
    do {
      if FileManager.default.fileExists(atPath: dest.path) {
        try FileManager.default.removeItem(at: dest)
      }
      if FileManager.default.fileExists(atPath: source.path) {
        try FileManager.default.copyItem(at: source, to: dest)
      }
      return true
    } catch {
      return false
    }
  }

  private static func pullDatabaseIfNewer(localPath: String, fileName: String) -> Bool {
    guard let icloudDir = iCloudDocumentsURL() else { return false }
    let source = icloudDir.appendingPathComponent(fileName)
    let dest = URL(fileURLWithPath: localPath)

    guard FileManager.default.fileExists(atPath: source.path) else { return false }

    if FileManager.default.fileExists(atPath: dest.path) {
      guard let srcDate = try? FileManager.default.attributesOfItem(atPath: source.path)[.modificationDate] as? Date,
            let dstDate = try? FileManager.default.attributesOfItem(atPath: dest.path)[.modificationDate] as? Date else {
        return false
      }
      if srcDate <= dstDate { return false }
    }

    do {
      if FileManager.default.fileExists(atPath: dest.path) {
        try FileManager.default.removeItem(at: dest)
      }
      try FileManager.default.copyItem(at: source, to: dest)
      return true
    } catch {
      return false
    }
  }
}

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if #available(iOS 13.0, *) {
      BGTaskScheduler.shared.register(
        forTaskWithIdentifier: "com.oshimemo.rss.sync",
        using: nil
      ) { task in
        task.setTaskCompleted(success: true)
      }
      scheduleBackgroundSync()
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    ICloudBridge.register(
      with: engineBridge.pluginRegistry.registrar(forPlugin: "ICloudBridge")!
    )
  }

  @available(iOS 13.0, *)
  private func scheduleBackgroundSync() {
    let request = BGAppRefreshTaskRequest(identifier: "com.oshimemo.rss.sync")
    request.earliestBeginDate = Date(timeIntervalSinceNow: 6 * 60 * 60)
    try? BGTaskScheduler.shared.submit(request)
  }
}
