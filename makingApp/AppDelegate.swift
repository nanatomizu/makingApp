//
//  AppDelegate.swift
//  makingApp
//
//  Created by 水谷七渡 on 2018/12/18.
//  Copyright © 2018 Nanato Mizutani. All rights reserved.
//

import UIKit
import UserNotifications
import RealmSwift

let goalNotification = GoalFirstInfo()



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //ユーザー通知のため
    let center = UNUserNotificationCenter.current()
    
        //アプリが起動された時に発動するメソッド
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

            center.requestAuthorization(options: [.alert,.sound,.badge]){
                                   (granted, _)in
                if granted {
                    self.center.delegate = self as! UNUserNotificationCenterDelegate
                }
            }
//                    //アプリ起動時のユーザーに対して通知の許可を求める文
//                    application.registerUserNotificationSettings(UIUserNotificationSettings(types: [UIUserNotificationType.sound,UIUserNotificationType.alert,UIUserNotificationType.badge], categories: nil))
            
//            center.delegate = self
            
            
         
            print("アプリ起動したよ")
            return true
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
        }

    //アプリがバックグラウンド
    func applicationDidEnterBackground(_ application: UIApplication) {
         goalNotification.readAll()

            //通知を送る日時の設定
            var dateComponents = DateComponents()
            dateComponents.hour = 9 //9時とdataComponentsの中に入っている状態
            print(dateComponents)
            
            //trueは設定した時間がくるたびに通知　falseは一回のみ
            let calenderTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            //通知の内容について
            let content = UNMutableNotificationContent()
            content.title = "克己録"
            content.subtitle =  "ああああ"
            content.body = ""
            //画像について
            if let path = Bundle.main.path(forResource: "１１１１", ofType: "png"){
                content.attachments = [try! UNNotificationAttachment(identifier: "ID", url: URL(fileURLWithPath: path), options: nil)]
            }
            
            let calenderRequest = UNNotificationRequest(identifier: "alert", content: content, trigger: calenderTrigger)
            
            center.add(calenderRequest, withCompletionHandler: nil)
            
        }

    
    func applicationWillEnterForeground(_ application: UIApplication) {
        }

    func applicationDidBecomeActive(_ application: UIApplication) {
        }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }

  
}

extension AppDelegate:UNUserNotificationCenterDelegate{
    //通知がタップされ、アプリが開いた時に呼ばれる関数
    func userNotificationCenter(_ center:UNUserNotificationCenter, didReceive
        response:UNNotificationResponse,withCompletionHandler
        complentionHandler:() -> Void){
        print("通知経由でアプリが起動しました")
    }
}
