# iOS APP import Flutter module 參考 [官方說明](https://docs.flutter.dev/add-to-app/ios/project-setup)

## 引入 flutter frameworks（選用官方的 b 方法）
- 首先透過指令產生 flutter frameworks
```
flutter build ios-framework
```
- 將 `frameworks` 資料夾移入 iOS 專案根目錄，更名為 `flutter_framework`
- Embed 所有 Frameworks
    - 到 `Build Settings > Build Phases > Link Binary With Libraries`
    - 把 `flutter_framework` 的 `Debug` 內的所有資料夾（frameworks）拉進來

![image](https://github.com/s00001sam/Test-Flutter-Module-IOS/assets/61711644/a19b8614-fe13-4502-b0bc-dcadd55b0a20)

- `Search Path` 的 `Framework Search Paths` 指到對應環境路徑
    - debug 放入 `flutter_framework` 的 `Debug` 路徑
    - release 放入 `flutter_framework` 的 `Release` 路徑

![image](https://github.com/s00001sam/Test-Flutter-Module-IOS/assets/61711644/e7d53cb1-37ff-4259-b8fa-f7484e03a471)

## 開啟 FlutterViewController

- 調整 AppDelegate
```
lazy var flutterEngine = FlutterEngine(name: "my flutter engine")

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
   // Runs the default Dart entrypoint with a default Flutter route.
   flutterEngine.run();
   // Connects plugins with iOS platform code to this app.
   GeneratedPluginRegistrant.register(with: self.flutterEngine);
   return true;
}
```

- 透過以下程式開啟 flutter present model
```
let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
// 全螢幕
flutterViewController.modalPresentationStyle = .fullScreen

// 清空之前的 viewController
flutterEngine.viewController = nil
// 設定初始化頁面的 Router
flutterEngine.navigationChannel.invokeMethod("pushRoute", arguments: "/detail")
// 設定 MethodChannel，實作 closePage     
let channel = FlutterMethodChannel(name: "com.swimple.channel", binaryMessenger: flutterViewController.binaryMessenger)
channel.setMethodCallHandler { (call: FlutterMethodCall, result: FlutterResult) -> Void in
   if call.method == "closePage" {
         flutterViewController.dismiss(animated: true, completion: nil)
   }
}

// 透過 Present Model 呈現  
present(flutterViewController, animated: true, completion: nil)
```
## 額外補充：
- 因為專案有用到 `image_picker` 和 `file_picker`，所以需要在專案的 `Info.plist` 補上以下三個權限說明
```
<key>NSCameraUsageDescription</key>
<string>Allow access to camera</string>
<key>NSMicrophoneUsageDescription</key>
<string>Allow access to microphone for video recording</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Allow access to photo library</string>
```

- [Youtube Embed flutter into native iOS app](https://www.youtube.com/watch?v=lUtlMV0NJw4)
