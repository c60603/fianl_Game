//
//  AppDelegate.swift
//  fianl_Game
//
//  Created by User08 on 2021/4/14.
//

import UIKit
import Firebase
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
    
}
