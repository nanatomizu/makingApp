//
//  RealmData.swift
//  makingApp
//
//  Created by 水谷七渡 on 2018/12/30.
//  Copyright © 2018 Nanato Mizutani. All rights reserved.
//

import Foundation
import RealmSwift

 class GoalFirstInfo: Object {
    
    @objc dynamic var goal = String()
//    @objc dynamic var monthlyGoal = String()
//    @objc dynamic var dailyGoal = String()
    @objc dynamic var goalImageComment = String()
//    @objc dynamic var recordComment = String()
//    @objc dynamic var notificationWord = String()
    @objc dynamic var dueDay = String()
//    @objc dynamic var todayTime = Int()
//    @objc dynamic var notificationTime = Int()
    var goalList = [NSDictionary]()

 //データの書き込み処理
    func creat(goal:String,goalImageComment:String,dueday:Int/*monthlyGoal:String,dailyGoal:String
        ,recordComment:String,notificationWord:String,dueday:Int,todayTime:Int,notificationTime:Int*/){
    let realm = try! Realm()
    
   
    try! realm.write{
   
        //インスタンス化
        let goalFirstInfo = GoalFirstInfo()
        goalFirstInfo.goal = goal
//        goalInfo.monthlyGoal = monthlyGoal
//        goalInfo.dailyGoal = dailyGoal
        goalFirstInfo.goalImageComment = goalImageComment
//        goalInfo.recordComment = recordComment
//        goalInfo.notificationWord = notificationWord
        goalFirstInfo.dueDay = dueDay
//        goalInfo.todayTime = todayTime
//        goalInfo.notificationTime = notificationTime
        realm.add(goalFirstInfo)
    }
}
//データ読み込み処理。データベースからデータを取ってくる処理
func readAll(){
    self.goalList = []
    let realm = try! Realm()
    let goalInfo = realm.objects(GoalFirstInfo.self)
    for value in goalInfo {
        let goals = ["goal":value.goal,"dueDay":value.dueDay,"goalImageComment":value.goalImageComment/*"monthlyGoal":value.monthlyGoal,"dailyGoal":value.dailyGoal,,"todayTime":value.todayTime*/] as NSDictionary
        
        self.goalList.append(goals)
        
    }
}
    func deleteAll(){
        let realm = try!Realm()
        try! realm.write(){
            realm.delete(realm.objects(GoalFirstInfo.self))
        }
    }
}

class DayMonthTimeInfo:Object {
    @objc dynamic var monthlyGoal = String()
    @objc dynamic var dailyGoal = String()
     @objc dynamic var todayTime = String()
    var goalListMonthdayTime = [NSDictionary]()
    
    //データ書き込み処理
    func creat(monthlyGoal:String,dailyGoal:String,todayTime:String
        ){
        let realm = try! Realm()
        try! realm.write{
            
            //インスタンス化
            let dayMonthTimeInfo1 = DayMonthTimeInfo()
       dayMonthTimeInfo1.monthlyGoal = monthlyGoal
            dayMonthTimeInfo1.dailyGoal = dailyGoal
            dayMonthTimeInfo1.todayTime = todayTime
             realm.add(dayMonthTimeInfo1)
            
        }
    }
    func readAll(){
        self.goalListMonthdayTime = []
        let realm = try! Realm()
        let goalInfo = realm.objects(DayMonthTimeInfo.self)
        for value in goalInfo {
            let goals = ["monthlyGoal":value.monthlyGoal,"dailyGoal":value.dailyGoal,"todayTime":value.todayTime/*"monthlyGoal":value.monthlyGoal,"dailyGoal":value.dailyGoal,,"todayTime":value.todayTime*/] as NSDictionary
            
            self.goalListMonthdayTime.append(goals)
            
        }
    }
    
    
}
