//
//  AppDelegate.swift
//  AlertController
//
//  Created by Famil Mustafayev on 7.12.2020.
//  Copyright © 2020 Famil Mustafayev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var bgSessionCompletionHandler: (() -> ())?
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        bgSessionCompletionHandler = completionHandler
    }
}

