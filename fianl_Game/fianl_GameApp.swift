//
//  fianl_GameApp.swift
//  fianl_Game
//
//  Created by User08 on 2021/4/14.
//

import SwiftUI
import Firebase

@main
struct fianl_GameApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            PageController()
        }
    }
}
