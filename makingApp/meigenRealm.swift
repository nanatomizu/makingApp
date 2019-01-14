//
//  meigenRealm.swift
//  makingApp
//
//  Created by 水谷七渡 on 2019/01/14.
//  Copyright © 2019 Nanato Mizutani. All rights reserved.
//
//
//import Foundation
//import RealmSwift
//
//class Meigen:Object{
//    @objc dynamic var meigens = String()
//    var meigenList = [NSDictionary]()
//   
//    //データ書き込み処理
//func creat(meigens:String){
////    インスタンス化
//    let realm = try! Realm()
//    
//    try! realm.write{
//        let meigen = Meigen()
//        meigen.meigens = [meigens]
//    }
//}
//    //データ読み込み処理
//    func readAll(){
//        let realm = try! Realm()
//        let meigen = realm.objects(Meigen.self)
//    }
//}
