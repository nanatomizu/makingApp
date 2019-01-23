//
//  RealmData.swift
//  makingApp
//
//  Created by 水谷七渡 on 2019/01/13.
//  Copyright © 2019 Nanato Mizutani. All rights reserved.
//

import Foundation
import RealmSwift

class GoalFirstInfo: Object {
    
    @objc dynamic var goal = String()
    @objc dynamic var monthlyGoal = String()
    @objc dynamic var dailyGoal = String()
    @objc dynamic var goalImageComment = String()
    //    @objc dynamic var recordComment = String()
    @objc dynamic var notificationWord = String()
    @objc dynamic var dueDay = String()
    @objc dynamic var todayTime = String()
    @objc dynamic var notificationTime = String()
    var goalList = [NSDictionary]()
    
    //データの書き込み処理
    func creat(goal:String,goalImageComment:String,dueday:String,monthlyGoal:String,dailyGoal:String
        ,notificationWord:String,todayTime:String,notificationTime:String){
        let realm = try! Realm()
        
        
        try! realm.write{
            
            //インスタンス化
            let goalFirstInfo = GoalFirstInfo()
            goalFirstInfo.goal = goal
            goalFirstInfo.monthlyGoal = monthlyGoal
            goalFirstInfo.dailyGoal = dailyGoal
            goalFirstInfo.goalImageComment = goalImageComment
            //        goalInfo.recordComment = recordComment
            goalFirstInfo.notificationWord = notificationWord
            goalFirstInfo.dueDay = dueDay
            goalFirstInfo.todayTime = todayTime
            goalFirstInfo.notificationTime = notificationTime
            realm.add(goalFirstInfo)
        }
    }
    //データ読み込み処理。データベースからデータを取ってくる処理
    func readAll(){
        self.goalList = []
        let realm = try! Realm()
        let goalInfo = realm.objects(GoalFirstInfo.self)
        for value in goalInfo {
            let goals = ["goal":value.goal,"dueDay":value.dueDay,"goalImageComment":value.goalImageComment,"monthlyGoal":value.monthlyGoal,"dailyGoal":value.dailyGoal,"todayTime":value.todayTime,"notificationWord":value.notificationWord,"notificationTime":value] as NSDictionary
            
            self.goalList.append(goals)
            
        }
    }
    func deleteAll(){
        let realm = try!Realm()
        try! realm.write(){
            realm.delete(realm.objects(GoalFirstInfo.self))
        }
    }
//    func deletePart(){
//        let realm = try! Realm()
//        try! realm.write() {
//            realm.delete(realm.objects(GoalFirstInfo.self).filter( ))
//        }
//    }
}

class RecordInfo:Object{
    @objc dynamic var recordGoal = String()
    @objc dynamic var recordComment = String()
    @objc dynamic var achieveRate = Int()
    @objc dynamic var dayRecord = String()
    //値と日付セットの配列で保存する
    var recordList = [NSDictionary]()
    

    func creat(recordGoal:String,recordComment:String,achieveRate:Int,dayRecord:String){
    let realm = try!Realm()
    
    try! realm.write {
        let recordInfo = RecordInfo()
        recordInfo.recordGoal = recordGoal
        recordInfo.recordComment = recordComment
        recordInfo.achieveRate = achieveRate
        recordInfo.dayRecord = dayRecord
        realm.add(recordInfo)
    }
}
func readAll(){
    recordList = []
    let realm = try! Realm()
    let recordInfo = realm.objects(RecordInfo.self)
    for value in recordInfo {
        let records = ["recordGoal":value.recordGoal,"recordComment":value.recordComment,"achieveRate":value.achieveRate, "dayRecord":value.dayRecord] as NSDictionary
        
        self.recordList.append(records)
    }
}

    func readGaph(goal:NSDictionary){
        recordList = []
        let realm = try!Realm()
        let Graph = realm.objects(RecordInfo.self).filter("recordGoal = '\(goal)'").sorted(byKeyPath:"dayRecord",ascending: false)
        var data = [[],[]]
        for graph in Graph {
            data[0].append(achieveRate)
                data[1].append(dayRecord)
            
            
            
        }
    }
    
    func readByDay(da:String){
          recordList = []
        let realm = try! Realm()
        var result = realm.objects(RecordInfo.self)
        result = result.filter("dayRecord = '\(da)'")

        for ev in result {
            let results = ["recordGoal": ev.recordGoal,"recordComment":ev.recordComment,"achieveRate":ev.achieveRate] as NSDictionary
            self.recordList.append(results)
        }

    }

    

    
    
    
    
    
    func deleteAll(){
        let realm = try!Realm()
        try! realm.write(){
            realm.delete(realm.objects(RecordInfo.self))
        }
    }
}

    //更新のための関数、日付と達成度の値を、上の配列の保存するように関数を書く
    //読み込み方は登録されてるデータの中から任意のデータを取り出す方法filter ー＞　値と日付データを取り出す処理








class FavoritesQuotation: Object {
    @objc dynamic var favorites = Bool()
    
    //データ書き込み処理
    func create(favorites:String){
        let realm = try! Realm()
        
        try! realm.write {
            let favoritesQuotation = FavoritesQuotation()
            favoritesQuotation.favorites = false
            
        }
    }
    
    //データ読み込み処理。
    func readAll(){
       let realm = try! Realm()
        let favoritesQuotation = realm.objects(FavoritesQuotation.self)
        
    }
////    お気に入り更新
//    func upDateFav(favorites:Bool){
//        let realm = try! Realm()
//        let favoritesQuotation =  realm.objects(FavoritesQuotation.self)
//        
//        try! realm.write {
//            favoritesQuotation.favorites = favorites
//        }
//    }
    
    
}

