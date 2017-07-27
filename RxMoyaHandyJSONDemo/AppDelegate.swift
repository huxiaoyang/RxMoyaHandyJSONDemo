//
//  AppDelegate.swift
//  RxMoyaHandyJSONDemo
//
//  Created by ucredit-XiaoYang on 2017/7/27.
//  Copyright © 2017年 XiaoYang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
            
        
        let nav = UINavigationController.init(rootViewController: ViewController())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
            
        
        return true
    }

    


}

