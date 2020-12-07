//
//  ViewController.swift
//  AlertController
//
//  Created by Famil Mustafayev on 7.12.2020.
//  Copyright © 2020 Famil Mustafayev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var alert: UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

        }
        alert.addAction(cancel)
        
        present(alert, animated: true) {
            let size = CGSize(width: 40, height: 40)
            let point = CGPoint(x: self.alert.view.frame.width / 2 - size.width / 2, y: self.alert.view.frame.height / 2 - size.height / 2)
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(origin: point, size: size))
            activityIndicator.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            activityIndicator.startAnimating()
            
            let progressView = UIProgressView(frame: CGRect(x: 0, y: self.alert.view.frame.height - 44, width: self.alert.view.frame.width, height: 2))
            progressView.tintColor = .blue
            let x = 100
            for i in 0..<x{
                progressView.progress = Float(i)
                self.alert.message = "\(i)%"
            }
            
            self.alert.view.addSubview(activityIndicator)
            self.alert.view.addSubview(progressView)
        }
    }
    @IBAction func alertButton(_ sender: Any) {
        showAlert(title: "Download ...", message: "0%", style: .alert)
    }
}

