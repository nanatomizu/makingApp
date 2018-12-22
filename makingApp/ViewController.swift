//
//  ViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2018/12/18.
//  Copyright © 2018 Nanato Mizutani. All rights reserved.
//

//TODO:TabBarで書くページへの繋げ方
import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var homePageGoals = ["サブスリー達成","アイアンマンレース完走","読書"]
    var homePageDailyGoals = ["走る　１０キロ","ロードバイク　120キロ","読書　10分"]
    var homePageDailyTime = ["10:00","12:00","19:00"]
    
    @IBOutlet weak var goalTableView: UITableView!
    @IBOutlet weak var dailyTableView: UITableView!
    @IBOutlet weak var timeTableView: UITableView!
    
   
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        //テーブルビュー の要素にタグ付け、判別しやすくするため
        goalTableView.tag = 1
        dailyTableView.tag = 2
        timeTableView.tag = 3
        
     
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if文で表す　funcの中へすじ上記の変数が全て送られてくるためにTagで区別
        if tableView.tag == 1{
            return homePageGoals.count
        }else if tableView.tag == 2{
            return homePageDailyGoals.count
        }else{
            return homePageDailyTime.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "mycell")
        
//        ラベルに３つ変数の中身を表示
        if tableView.tag == 1{
            cell.textLabel!.text = homePageGoals[indexPath.row]
        }else if tableView.tag == 2{
        cell.textLabel!.text = homePageDailyGoals[indexPath.row]
        }else{
        cell.textLabel!.text = homePageDailyTime[indexPath.row]
        }
        return cell
        
    }
  
    
}
    
    

