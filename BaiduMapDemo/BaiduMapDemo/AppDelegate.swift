//
//  AppDelegate.swift
//  BaiduMapDemo
//
//  Created by 王云 on 2018/2/5.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import MapKit

let BMK_AK = "bLjwhZ5pkP5IptzRPZ4DdaX3sH6TqBGA"
var mapManager: BMKMapManager?

//账户信息
let userName = "wyt"
let password = "123456"
let user_tikeyt = ""

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, BMKGeneralDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        NetWorkTool.login()
        
        
        mapManager = BMKMapManager()
        let ret = mapManager?.start(BMK_AK, generalDelegate: self)
        if ret == false {
            print("manager start failed")
        }
        return true
    }
    
    func login() {
        
    }

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
    
    func onGetNetworkState(_ iError: Int32) {
        if 0 == iError {
            print("联网成功")
        }else {
            print("联网失败")
        }
    }
   
    func onGetPermissionState(_ iError: Int32) {
        if 0 == iError {
            print("授权成功")
        }else {
            print("授权失败")
        }
    }

}


