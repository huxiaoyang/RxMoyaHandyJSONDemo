//
//  UIViewControllerUtilities.swift
//  Customer
//
//  Created by ucredit-XiaoYang on 2017/4/18.
//  Copyright © 2017年 XiaoYang. All rights reserved.
//

import Foundation
import PKHUD
import Whisper
import PopupDialog


extension UIViewController {
    
    // MARK: AlertView
    // 实例方法
    func showAlertView(title: String, message: String, action: PopupDialogButton.PopupDialogButtonAction?) {
        
        let popup = PopupDialog.init(title: title, message: message)
        
        popup.transitionStyle = .zoomIn
        popup.buttonAlignment = .horizontal
        
        let cancel = CancelButton.init(title: "取消") {
            print("You canceled the car dialog.")
        }
        
        let confirm = DefaultButton.init(title: "确定", action: action)
        
        popup.addButtons([cancel, confirm])
        
        self.present(popup, animated: true, completion: nil)
    }
    
    // 类方法
    class func showAlertView(title: String, message: String, action: PopupDialogButton.PopupDialogButtonAction?) {
        
        let popup = PopupDialog.init(title: title, message: message)
        
        popup.transitionStyle = .zoomIn
        popup.buttonAlignment = .horizontal
        
        let cancel = CancelButton.init(title: "取消") {
            print("You canceled the car dialog.")
        }
        
        let confirm = DefaultButton.init(title: "确定", action: action)
        
        popup.addButtons([cancel, confirm])
        
        windowController().present(popup, animated: true, completion: nil)
    }
    
    class func showConfrimAlertView(title: String, message: String, action: PopupDialogButton.PopupDialogButtonAction?) {
        let popup = PopupDialog.init(title: title, message: message)
        
        popup.transitionStyle = .zoomIn
        popup.buttonAlignment = .horizontal
        
        let confirm = DefaultButton.init(title: "我知道了", action: action)
        
        popup.addButton(confirm)
        
        windowController().present(popup, animated: true, completion: nil)
    }
    
    
// MARK: ---------------------------------------------------------------------------------------
    
    
    // MARK: HUD
    // 实例方法
    func showHUD() {
        HUD.show(.systemActivity)
    }
    
    func hideHUD() {
        HUD.hide(animated: true)
    }
    
    // 类方法
    class func showHUD() {
        HUD.show(.systemActivity)
    }
    
    class func hideHUD() {
        HUD.hide(animated: true)
    }
    
    
// MARK: ---------------------------------------------------------------------------------------
    
    
    // MARK: Toast
    // 实例方法
    func showStatus(title: String) {
        let message = Message(title: title, backgroundColor: .red)
        Whisper.show(whisper: message, to: navigationController!, action: .show)
    }
    
    func showNotification(title: String, message: String, image: UIImage = UIImage(named: "品牌")!) {
        let announcement = Announcement(title: title, subtitle: message, image: image)
        Whisper.show(shout: announcement, to: navigationController!, completion:nil)
    }
    
    // 类方法
    class func showStatus(title: String) {
        let message = Message(title: title, backgroundColor: .red)
        let VC = windowController()
        guard let nav = VC.navigationController else {
            return
        }
        Whisper.show(whisper: message, to: nav, action: .show)
    }
    
    class func showNotification(title: String, message: String, image: UIImage = UIImage(named: "品牌")!) {
        let announcement = Announcement(title: title, subtitle: message, image: image)
        let VC = windowController()
        guard let nav = VC.navigationController else {
            return
        }
        Whisper.show(shout: announcement, to: nav, completion:nil)
    }
    
    
// MARK: ---------------------------------------------------------------------------------------

    
    // MARK: 获取当前window上controller
    private class func getTopWindowController(_ controller: UIViewController) -> UIViewController {

        if let VC = controller.presentedViewController {
            return getTopWindowController(VC)
        }
        else if controller.isKind(of: UISplitViewController.self) {
            let VC = controller as! UISplitViewController
            if VC.viewControllers.count > 0 {
                return getTopWindowController(VC.viewControllers.last!)
            }
            return VC
        }
        else if controller.isKind(of: UINavigationController.self) {
            let VC = controller as! UINavigationController
            if VC.viewControllers.count > 0 {
                return getTopWindowController(VC.topViewController!)
            }
            return VC
        }
        else if controller.isKind(of: UITabBarController.self) {
            let VC = controller as! UITabBarController
            guard let controllers = VC.viewControllers, controllers.count > 0 else {
                return VC
            }
            return getTopWindowController(VC.selectedViewController!)
            
        }
        else {
            return controller
        }
        
    }
    
    class func windowController() -> UIViewController {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return getTopWindowController(appDelegate.window!.rootViewController!)
    }
    
    
}


