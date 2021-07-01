//
//  UIviewController+Extension.swift
//  fianl_Game
//
//  Created by 陳奇松 on 2021/6/18.
//

import Foundation
import UIKit

extension UIViewController {
    static func getLastPresentedViewController() -> UIViewController? {
        let window = UIApplication.shared.windows.first {
            $0.isKeyWindow
        }
        var presentedViewController = window?.rootViewController
        while presentedViewController?.presentedViewController != nil {
            presentedViewController = presentedViewController?.presentedViewController
        }
        return presentedViewController
    }
}
