//
//  AppDelegate.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/9/21.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UITabBar.appearance().tintColor = UIColor.orange
        
        let userDefault = UserDefaults.standard
        
        if userDefault.bool(forKey: "everLaunched") == false {
            // 第一次启动
            userDefault.set(true, forKey: "everLaunched")
            userDefault.set(true, forKey: "firstLaunch")
        }else{
            userDefault.set(false, forKey: "firstLaunch")
        }
        userDefault.synchronize()
        return true
    }
    
//    // MARK: 获取首页 子标题
//    func getHomeSubTitle(){
//        let homeSubTitleUrl = HOST_URL.appending(HOME_GET_SUBTITLE_LIST)
//        MQNetworkingTool.sendRequest(url: homeSubTitleUrl, succeed: { (responseObject, isBadNet) in
//            //            MQLog("responseObject=\(responseObject),isBadNet=\(isBadNet)")
//            guard let resultDict = responseObject as? [String:NSObject] else  {return}
//            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else {return}
//            let userDefault = UserDefaults.standard
//            for dict in dataArray {
//                let subTitleModel = MQHomeSubTitleModel(dict: dict)
//                userDefault.set(subTitleModel.identification, forKey: subTitleModel.title)
//            }
//            
//            userDefault.set(true, forKey: "firstLaunch")
//            print("path = \(NSHomeDirectory())")
//            userDefault.synchronize()
//            
//        }) { (error, isBadNet) in
//            MQLog("error=\(error),isBadNet=\(isBadNet)")
//        }
//    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

