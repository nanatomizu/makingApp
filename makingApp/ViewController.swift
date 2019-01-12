//
//  ViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2018/12/18.
//  Copyright © 2018 Nanato Mizutani. All rights reserved.
//

//TODO:TabBarで書くページへの繋げ方
import UIKit
import RealmSwift

let goalInfo = GoalFirstInfo()
let dayTimeInfo = DayMonthTimeInfo()


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    

    
    let realm = try! Realm()
    
//    var homePageGoals:[String] = ["a","b","c","","" ]
//     
//    var homePageDailyGoals = ["走る１０キロ","ロードバイク　120キロ","読書　10分"]
//    var homePageDailyTime = ["10:00","12:00","19:00"]
    
    @IBOutlet weak var goalTableView: UITableView!
    @IBOutlet weak var dailyTableView: UITableView!
    @IBOutlet weak var timeTableView: UITableView!
    
   
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        

        //テーブルビュー の要素にタグ付け、判別しやすくするため
        goalTableView.tag = 1
        dailyTableView.tag = 2
        timeTableView.tag = 3
    
        
    
    //ゴール情報の更新、インスタンス化
//        let goalInfo = GoalInfo()
        goalInfo.readAll()
        dayTimeInfo.readAll()
        print(goalInfo.goalList)
//        print("0つ目を出したよ\(goalInfo.goalList[0])")
//        print("0つ目のgoalを出したよ\(goalInfo.goalList[0]["goal"])")
      
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if文で表す　funcの中へすじ上記の変数が全て送られてくるためにTagで区別
//        セルの数指定
//        if tableView.tag == 1{
            return goalInfo.goalList.count
//        }else if tableView.tag == 2{
//            return goalInfo.goalList.count
//        }else{
//            return goalInfo.goalList.count
//        }
      
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell = UITableViewCell(style: .default, reuseIdentifier: "mycell")
       
    
//        ラベルに３つ変数の中身を表示
        if tableView.tag == 1{
            cell.textLabel!.text = goalInfo.goalList[indexPath.row]["goal"] as! String
        }else if tableView.tag == 2{
//            cell.textLabel!.text = dayTimeInfo.goalListMonthdayTime[indexPath.row][" goalImageComment"] as! String
        }else{
            cell.textLabel!.text = dayTimeInfo.goalListMonthdayTime[indexPath.row]["todayTime"] as! String
        
        }
         return cell
    }
    


   

    
    
       
  
    @IBAction func tapBtn(_ sender: Any) {
       goalInfo.deleteAll()
    }
}
