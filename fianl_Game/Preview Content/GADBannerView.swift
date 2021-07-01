//
//  GADBannerView.swift
//  fianl_Game
//
//  Created by 陳奇松 on 2021/6/18.
//

import SwiftUI
import GoogleMobileAds

struct ADBannerView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> GADBannerView {
        let bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-6023305273644504~3258563782"
        bannerView.rootViewController =
            UIViewController.getLastPresentedViewController()
        let request = GADRequest()
        bannerView.load(request)
        return bannerView
    }
    
    func updateUIView(_ uiView: GADBannerView, context: Context) {
    }
    
    typealias UIViewType = GADBannerView
}
