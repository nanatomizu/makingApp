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


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    
    
    let realm = try! Realm()
    
    //    var homePageGoals:[String] = ["a","b","c","","" ]
    //
    //    var homePageDailyGoals = ["走る１０キロ","ロードバイク　120キロ","読書　10分"]
    //    var homePageDailyTime = ["10:00","12:00","19:00"]
    
    
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var dailyGoalLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    @IBOutlet weak var goalTableView: UITableView!
    @IBOutlet weak var dailyTableView: UITableView!
    @IBOutlet weak var timeTableView: UITableView!
    
    
    @IBOutlet weak var recordBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        goalLabel.backgroundColor = 
        //背景色
       backGroundColor()
        //データない時にcell間の線を消してます。
        goalTableView.tableFooterView = UIView()
          dailyTableView.tableFooterView = UIView()
          timeTableView.tableFooterView = UIView()
        //テーブルビュー の要素にタグ付け、判別しやすくするため
        goalTableView.tag = 1
        dailyTableView.tag = 2
        timeTableView.tag = 3
        
        goalTableView.delegate = self
        goalTableView.dataSource = self
        dailyTableView.delegate  = self
        dailyTableView.dataSource = self
        timeTableView.delegate = self
        timeTableView.dataSource = self
        
        //tableViewの角を丸くしてます
        goalTableView.layer.cornerRadius = 30.0
        goalTableView.layer.masksToBounds = true
        dailyTableView.layer.cornerRadius = 30.0
        dailyTableView.layer.masksToBounds = true
            timeTableView.layer.cornerRadius = 30.0
        timeTableView.layer.masksToBounds = true
        //ゴール情報の更新、インスタンス化
        //        let goalInfo = GoalInfo()
        goalInfo.readAll()
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
            cell.textLabel!.textAlignment = NSTextAlignment.center
        }else if tableView.tag == 2{
            cell.textLabel!.text = goalInfo.goalList[indexPath.row]["dailyGoal"] as! String
            cell.textLabel!.textAlignment = NSTextAlignment.center
        }else{
            cell.textLabel!.text = goalInfo.goalList[indexPath.row]["todayTime"] as! String
            cell.textLabel!.textAlignment = NSTextAlignment.center
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //セルの選択解除
        goalTableView.deselectRow(at: indexPath, animated: true)
            dailyTableView.deselectRow(at: indexPath, animated: true)
        timeTableView.deselectRow(at: indexPath, animated: true)
        
       
  
        
//        //ここに遷移処理を書く
        self.present(showGoalListViewController(), animated: true, completion: nil)
        
    }
    
    
    //Mark: セルの編集ができるようにする。
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
//        if(editingStyle == UITableViewCell.EditingStyle.delete) {
//            do{
//                let realm = try Realm()
//                try realm.write {
//                    realm.delete(goalInfo.goalList[indexPath.row])
//                }
//                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
//            }catch{
//            }
//            goalTableView.reloadData()
//            dailyTableView.reloadData()
//            timeTableView.reloadData()
//        }
    
        
        print("前ゴールリストの中身変化の確認:\(goalInfo.goalList)")
        goalInfo.goalList.remove(at: indexPath.row)
        goalTableView.deleteRows(at: [indexPath], with: .fade)
//        try! realm.write() {
//            realm.delete(realm.objects(GoalFirstInfo.self).filter("\(goalInfo.goalList[indexPath.row])"))
//
//        print("デリート後ゴールリストの中身変化の確認:\(goalInfo.goalList)")
//
//        }
        goalTableView.reloadData()
        dailyTableView.reloadData()
        timeTableView.reloadData()
//        TODO:realmDBでのデータを削除するコード入ります
    }
    

    
    
    @IBAction func goToRecord(_ sender: UIButton) {
        goRecord()
    }
    func goRecord(){
        //まずは、同じstororyboard内であることをここで定義します
        let storyboard: UIStoryboard = self.storyboard!
        //ここで移動先のstoryboardを選択
        let second = storyboard.instantiateViewController(withIdentifier: "record")
        //ここが実際に移動するコードとなります
        self.present(second, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    @IBAction func tapBtn(_ sender: Any) {
        goalInfo.deleteAll()
        
        
        goalInfo.readAll()
        self.goalTableView.reloadData()
        self.dailyTableView.reloadData()
        self.timeTableView.reloadData()
        
    }
}
extension ViewController{
    func backGroundColor() {
        //グラデーションをつける
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        //グラデーションさせるカラーの設定
        //今回は、徐々に色を濃くしていく
        let color1 = UIColor(red: 1.0 , green: 1.0, blue: 1.0, alpha: 1).cgColor     //白
        let color2 = UIColor(red: 256/256.0, green: 82/256.0, blue: 0/256.0, alpha: 1).cgColor   //水色
        
        //CAGradientLayerにグラデーションさせるカラーをセット
        gradientLayer.colors = [color1, color2]
        
        //グラデーションの開始地点・終了地点の設定
        //上が白で下が水色
        //    gradientLayer.startPoint = CGPoint.init(x: 0.5, y: 0)
        //    gradientLayer.endPoint = CGPoint.init(x: 0.5 , y:1 )
        //上が赤で下が白
        //        gradientLayer.endPoint = CGPoint.init(x: 0.5, y: 0)
        //        gradientLayer.startPoint = CGPoint.init(x: 0.5 , y:1 )
        
        //左が白で右が水色
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint.init(x: 1 , y:0.5)
        
        //左上が白で右下が水色
        //    gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        //    gradientLayer.endPoint = CGPoint.init(x: 1 , y:1)
        
        //ViewControllerのViewレイヤーにグラデーションレイヤーを挿入する
        self.view.layer.insertSublayer(gradientLayer,at:0)
    }
}

