//
//  AdsData.swift
//  fianl_Game
//
//  Created by 陳奇松 on 2021/6/18.
//

import Foundation
import GoogleMobileAds
import UIKit

class AppDelegateFirebase: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}

class RewardedAdController: NSObject{
     private var ad: GADRewardedAd?
    
    func loadAd(){
        let request = GADRequest()
        
        GADRewardedAd.load(withAdUnitID: "ca-app-pub-6023305273644504~3258563782", request: request) {ad, error in
            
            if let error = error {
                print(error)
                return
            }
            ad?.fullScreenContentDelegate = self
            self.ad = ad
        }
    }
    
    func showAd(){
        if let ad = ad,
           let controller = UIViewController.getLastPresentedViewController() {
            
            ad.present(fromRootViewController: controller) {
            }
            
        }
    }
}

extension RewardedAdController: GADFullScreenContentDelegate {
    
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print(#function)
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print(#function)
    }
    
    func ad(_ ad: GADFullScreenPresentingAd,
            didFailToPresentFullScreenContentWithError error: Error) {
        print(#function, error)
        
    }
    
}
