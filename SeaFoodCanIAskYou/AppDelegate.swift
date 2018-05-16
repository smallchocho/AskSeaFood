//
//  AppDelegate.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2016/10/15.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
import CoreLocation
import RealmSwift
import UserNotifications
let uiRealm = try! Realm()
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //修改NavigationBar的返回鍵的字體顏色
        UINavigationBar.appearance().tintColor = UIColor.black
        configurePushNotification(with: application)
        return true
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
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.reduce("",{$0 + String(format:"%02X",$1)})
        print("DEVICE TOKEN = \(tokenString)")
    }
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print("收到訊息了")
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //設定推播內容
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.title = "測試"
            content.subtitle = ""
            content.body = "測試"
            content.sound = UNNotificationSound.default()
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.5, repeats: false)
            let requestIdString = String(123)
            let request = UNNotificationRequest(identifier: requestIdString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        completionHandler(UIBackgroundFetchResult.newData)
    }
    //依照裝置的版本做PushNotification設定
    func configurePushNotification(with application: UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
    }
}
// Receive displayed notifications for iOS 10 devices.
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    //只有當App在前臺時接受到notification，此方法才會被調用，
    //由completionHandler的參數決定此時要顯示什麼樣的notification，
    //如果此方法未被使用，則不會顯示notification
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([.alert,.badge,.sound])
    }
    //當使用者對notification打開、刪除、執行動作任一時，調用此方法
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }
}
