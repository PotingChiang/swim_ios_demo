//
//  ViewController.swift
//  PresentFlutterModuleB
//
//  Created by red on 2024/5/2.
//

import UIKit
import Flutter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Make a button to call the showFlutter function when pressed.
        let button1 = UIButton(type:UIButton.ButtonType.custom)
        button1.addTarget(self, action: #selector(toFlow1), for: .touchUpInside)
        button1.setTitle("Show flow 1", for: UIControl.State.normal)
        button1.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
        button1.backgroundColor = UIColor.blue
        
        let button2 = UIButton(type:UIButton.ButtonType.custom)
        button2.addTarget(self, action: #selector(toFlow2), for: .touchUpInside)
        button2.setTitle("Show flow 2", for: UIControl.State.normal)
        button2.frame = CGRect(x: 80.0, y: 410.0, width: 160.0, height: 40.0)
        button2.backgroundColor = UIColor.blue
        self.view.addSubview(button1)
        self.view.addSubview(button2)
    }
    
    @objc func toFlow1() {
      let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
      flutterEngine.viewController = nil
      let flutterViewController =
          FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
      flutterEngine.navigationChannel.invokeMethod("pushRoute", arguments: "/detail")
        
      let channel = FlutterMethodChannel(name: "com.swimple.channel", binaryMessenger: flutterViewController.binaryMessenger)
      channel.setMethodCallHandler { (call: FlutterMethodCall, result: FlutterResult) -> Void in
          if call.method == "closePage" {
              flutterViewController.dismiss(animated: true, completion: nil)
          }
      }
        
      flutterViewController.modalPresentationStyle = .fullScreen
        
      present(flutterViewController, animated: true, completion: nil)

    }
    
    @objc func toFlow2() {
      let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
      flutterEngine.viewController = nil
      let flutterViewController =
          FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
      flutterEngine.navigationChannel.invokeMethod("pushRoute", arguments: "/listing_first_step")
        
      let channel = FlutterMethodChannel(name: "com.swimple.channel", binaryMessenger: flutterViewController.binaryMessenger)
      channel.setMethodCallHandler { (call: FlutterMethodCall, result: FlutterResult) -> Void in
          if call.method == "closePage" {
              flutterViewController.dismiss(animated: true, completion: nil)
          }
      }
        
      flutterViewController.modalPresentationStyle = .fullScreen
        
      present(flutterViewController, animated: true, completion: nil)

    }


}
