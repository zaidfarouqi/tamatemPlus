//
//  UIApplication.swift
//  TamatemPlus
//
//  Created by zaid farouqi on 13/06/2023.
//

import Foundation
import UIKit
import Foundation
extension UIApplication {
    // MARK: function that gets the top view controller
    class func topViewController(controller: UIViewController? = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive || $0.activationState == .foregroundInactive })
        .compactMap({$0 as? UIWindowScene})
        .first?.windows
        .filter({$0.isKeyWindow}).first?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    
}
