//
//  ViewController.swift
//  AlertController
//
//  Created by Famil Mustafayev on 7.12.2020.
//  Copyright © 2020 Famil Mustafayev. All rights reserved.
//

import UIKit
import UserNotifications

@available(iOS 11.0, *)
class ViewController: UIViewController {

    private var alert: UIAlertController!
    private let dataProvider = DataProvider()
    private var filePath: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        registerForNotifications()
        
        dataProvider.fileLocation = { (location) in
            // Save your file somewhere, or use it...
            self.filePath = location.absoluteString
            self.alert?.dismiss(animated: false)
            self.postNotification()
            
            print("Download finished: \(location.absoluteString)")
        }
    }


    private func showAlert(title: String, message: String, style: UIAlertController.Style){
        alert = UIAlertController(title: title, message: message, preferredStyle: style)
        alert.view.alpha = 0.5
        let height = NSLayoutConstraint(item: alert.view,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 0,
                                        constant: 170)
        alert.view.addConstraint(height)
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive) {(action) in
            self.dataProvider.stopDownload()
        }
        alert.addAction(cancel)
        
        present(alert, animated: true) {
            let size = CGSize(width: 40, height: 40)
            let point = CGPoint(x: self.alert.view.frame.width / 2 - size.width / 2, y: self.alert.view.frame.height / 2 - size.height / 2)
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(origin: point, size: size))
            activityIndicator.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            activityIndicator.startAnimating()
            
            let progressView = UIProgressView(frame: CGRect(x: 0,
                                                            y: self.alert.view.frame.height - 44,
                                                            width: self.alert.view.frame.width,
                                                            height: 2))
            progressView.tintColor = .blue
            self.dataProvider.onProgress = { (progres) in
                progressView.progress = Float(progres)
                self.alert.message = String(Int(progres * 100)) + "%"
                
                if progressView.progress == 1 {
                    self.alert.dismiss(animated: false)
                }
            }
            self.alert.view.addSubview(progressView)
            self.alert.view.addSubview(activityIndicator)
        }
    }
    @IBAction func DownloadButton(_ sender: Any) {
        showAlert(title: "Download ...", message: "0 %", style: .alert)
        //print("\(String(describing: self.dataProvider.startDownload()))")
    }
}

@available(iOS 11.0, *)
extension ViewController {
    
    private func registerForNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (_, _) in }
    }
    
    private func postNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Download complete!"
        content.body = "Your background transfer has completed. File path: \(filePath ?? "")"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        let request = UNNotificationRequest(identifier: "TransferComplete", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
