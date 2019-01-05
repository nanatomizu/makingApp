//
//  RealmData.swift
//  makingApp
//
//  Created by 水谷七渡 on 2018/12/30.
//  Copyright © 2018 Nanato Mizutani. All rights reserved.
//

import Foundation
import RealmSwift

 class GoalInfo: Object {
    
    @objc dynamic var goal = String()
    @objc dynamic var monthlyGoal = String()
    @objc dynamic var dailyGoal = String()
    @objc dynamic var dueDay = Int()
    @objc dynamic var todayTime = Int()
    var goalList = [NSDictionary]()

 //データの書き込み処理
func creat(goal:String,monthlyGoal:String,dailyGoal:String){
    let realm = try! Realm()
    
   
    try! realm.write{
   
        //インスタンス化
        let goalInfo = GoalInfo()
        goalInfo.goal = goal
        goalInfo.monthlyGoal = monthlyGoal
        goalInfo.dailyGoal = dailyGoal
        goalInfo.dueDay = dueDay
        goalInfo.todayTime = todayTime
        realm.add(goalInfo)
    }
}
//データ読み込み処理。データベースからデータを取ってくる処理
func readAll(){
    self.goalList = []
    let realm = try! Realm()
    let goalInfo = realm.objects(GoalInfo.self)
    for value in goalInfo {
        let goals = ["goal":value.goal,"monthlyGoal":value.monthlyGoal,"dailyGoal":value.dailyGoal,"dueDay":value.dueDay,"todayTime":value.todayTime] as NSDictionary
        
        self.goalList.append(goals)
        
    }
}
    func deleteAll(){
        let realm = try!Realm()
        try! realm.write(){
            realm.delete(realm.objects(GoalInfo.self).filter(<#T##predicate: NSPredicate##NSPredicate#>))
        }
    }
}
