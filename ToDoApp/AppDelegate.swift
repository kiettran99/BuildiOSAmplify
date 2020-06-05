//
//  AppDelegate.swift
//  ToDoApp
//
//  Created by MSI on 6/5/20.
//  Copyright © 2020 MSI. All rights reserved.
//

import UIKit
import Amplify
import AmplifyPlugins

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
        do {
           try Amplify.add(plugin:dataStorePlugin)
           try Amplify.configure()
            Amplify.Logging.logLevel = .info
           print("Initialized Amplify");
        } catch {
           print("Could not initialize Amplify: \(error)")
        }
        return true
    }

}

