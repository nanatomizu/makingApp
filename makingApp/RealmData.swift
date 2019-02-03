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
    @objc dynamic var notificationTime = Date()
    var goalList = [NSDictionary]()
    
    //データの書き込み処理
    func creat(goal:String,goalImageComment:String,dueday:String,monthlyGoal:String,dailyGoal:String
        ,notificationWord:String,todayTime:String,notificationTime:Date){
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
            let goals = ["goal":value.goal,"dueDay":value.dueDay,"goalImageComment":value.goalImageComment,"monthlyGoal":value.monthlyGoal,"dailyGoal":value.dailyGoal,"todayTime":value.todayTime,"notificationWord":value.notificationWord,"notificationTime":value.notificationTime] as NSDictionary
            
            self.goalList.append(goals)
            
        }
    }
    func readByGoal(goal:String){
        goalList = []
        let realm = try!Realm()
        var result = realm.objects(GoalFirstInfo.self)
        result = result.filter("goal like '\(goal)'")
        for value in result  {
            let records = ["goal": value.goal,"dueDay":value.dueDay,"goalImageComment":value.goalImageComment,"monthlyGoal":value.monthlyGoal,"dailyGoal":value.dailyGoal,"todayTime":value.todayTime,"notificationWord":value.notificationWord,"notificationTime":value.notificationTime] as NSDictionary
            
            self.goalList.append(records)
        }
    }
    func deleteAll(){
        let realm = try!Realm()
        try! realm.write(){
            realm.delete(realm.objects(GoalFirstInfo.self))
        }
    }
    func deleteCell(goalFor:String){
        let realm = try!Realm()
        try! realm.write(){
            var result = realm.objects(GoalFirstInfo.self)
            result =  result.filter("goal like '\(goalFor)'")
            realm.delete(result)
        }
    }
  
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

    func readGaph(goal:String){
        recordList = []
        let realm = try!Realm()
        var result = realm.objects(RecordInfo.self)
          result = result.filter("recordGoal like '\(goal)'")
            .sorted(byKeyPath:"dayRecord",ascending: true)
        
        for value in result  {
            let records = ["recordGoal": value.recordGoal,"recordComment":value.recordComment,"achieveRate":value.achieveRate, "dayRecord":value.dayRecord] as NSDictionary
            
            self.recordList.append(records)
        }
    }
    func readGoal(goal:String){
        recordList = []
        let realm = try!Realm()
        var result = realm.objects(RecordInfo.self)
        result = result.filter("recordGoal like '\(goal)'")
        
        for value in result  {
            let records = ["recordGoal": value.recordGoal,"recordComment":value.recordComment,"achieveRate":value.achieveRate, "dayRecord":value.dayRecord] as NSDictionary
            
            self.recordList.append(records)
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
    func readByDayGoal(day:String,Goal:String){
        recordList = []
        let realm = try! Realm()
        var result = realm.objects(RecordInfo.self)
        result = result.filter("(dayRecord = '\(day)') && (recordGoal like '\(Goal)') ")
        
        for ev in result {
            let results = ["recordGoal": ev.recordGoal,"recordComment":ev.recordComment,"achieveRate":ev.achieveRate,"dayRecord":ev.dayRecord] as NSDictionary
            self.recordList.append(results)
        }
        
      
    

    

    
    
    
    }
    
    func deleteAll(){
        let realm = try!Realm()
        try! realm.write(){
            realm.delete(realm.objects(RecordInfo.self))
        }
    }
    
    func deleteRecord(goalFor:String){
        let realm = try!Realm()
        try! realm.write(){
            var result = realm.objects(RecordInfo.self)
            result =  result.filter("recordGoal like '\(goalFor)'")
            realm.delete(result)
        }
    }
}

    //更新のための関数、日付と達成度の値を、上の配列の保存するように関数を書く
    //読み込み方は登録されてるデータの中から任意のデータを取り出す方法filter ー＞　値と日付データを取り出す処理




class FavoritesQuotation: Object {
//    お気に入りかどうかの情報と名言をセットで保存する
    @objc dynamic var favorites = false
    @objc dynamic var quotes  = String()
    var favRealmList = [NSDictionary]()
    
    
    func creat(favorites:Bool,quotes:String){
        let realm = try!Realm()
        
        try! realm.write {
        let favoritesQuotation = FavoritesQuotation()
            favoritesQuotation.favorites = favorites
            favoritesQuotation.quotes = quotes
            realm.add(favoritesQuotation)
        }
    
    }
    //データ読み込み処理。
    func readAll(){
        favRealmList = []
       let realm = try! Realm()
        let favoritesQuotation = realm.objects(FavoritesQuotation.self)
        for value in favoritesQuotation {
            let favs = ["favorites":value.favorites,"quotes":value.quotes] as NSDictionary
                    self.favRealmList.append(favs)
                }
            }
    func readByquote(saying:String,bool:Bool){
        favRealmList = []
        let realm = try! Realm()
        var result = realm.objects(FavoritesQuotation.self)
        result = result.filter("quotes like '\(saying)' && favorites = \(bool) ")
        
        for value in result {
            let results = ["quotes": value.quotes,"favorites":value.favorites] as NSDictionary
            self.favRealmList.append(results)
        }
    }

            
        
    
    func deleteAll(){
        let realm = try!Realm()
        try! realm.write(){
            realm.delete(realm.objects(FavoritesQuotation.self))
        }
    }

////// //    お気に入り更新
//func upDateFav(quottttte:String){
//        let realm = try! Realm()
//var result =  realm.objects(FavoritesQuotation.self)
//   result =  result.filter("(quotes like '\(quottttte)')")
//
//        try! realm.write {
//            result[0].favorites = false
//        }
//    }


}

