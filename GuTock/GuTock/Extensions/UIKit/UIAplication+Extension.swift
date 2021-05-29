//
//  UIAplication+Extension.swift
//  GuTock
//
//  Created by Владимир Гуль on 29.05.2021.
//

import UIKit

extension UIApplication {
    
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigation = base as? UINavigationController {
            return getTopViewController(base: navigation.visibleViewController)
        } else if let tabController = base as? UITabBarController, let selected = tabController.selectedViewController {
            return getTopViewController(base: selected)
        } else if let  presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
}
