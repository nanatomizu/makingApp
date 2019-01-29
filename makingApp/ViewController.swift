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
let recordInfos = RecordInfo()

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    
    
  
    let date = Date()
   
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
        
//        
//        
//       print(goalInfo.goalList[0]["goal"] as! String)
//    print(goalInfo.goalList[0]["notificationWord"] as! String)
//        
        
     
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        print(df.string(from: date))
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
        recordInfos.readAll()
        
       
        
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
        //ここに遷移処理を書く
        let storyboard: UIStoryboard = self.storyboard!
        
        let detailInformation = storyboard.instantiateViewController(withIdentifier: "showGoalList") as! showGoalListViewController
        
        detailInformation.gooooooooal = goalInfo.goalList[indexPath.row]["goal"] as! String
        detailInformation.mooonthgoal = goalInfo.goalList[indexPath.row]["monthlyGoal"] as! String
        detailInformation.cooooooment = goalInfo.goalList[indexPath.row]["goalImageComment"] as! String
        detailInformation.daaaaaygoal = goalInfo.goalList[indexPath.row]["dailyGoal"] as! String
        detailInformation.duuuuuueday = goalInfo.goalList[indexPath.row]["dueDay"] as! String
        
//
//
        
        self.present(detailInformation, animated: true, completion: nil)
    }
    
    
//    //Mark: セルの編集ができるようにする。
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if(editingStyle == UITableViewCell.EditingStyle.delete) {
//            do{
//
//                let realm = try Realm()
//                try realm.write {
//                    realm.delete(goalInfo[indexPath.row])
//                    realm.delete(recordInfo[indexPath.row])
//                }
//                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
//            }catch{
//            }
//            tableView.reloadData()
//
//
//        goalTableView.reloadData()
//        dailyTableView.reloadData()
//        timeTableView.reloadData()
//
////        TODO:realmDBでのデータを削除するコード入ります
//    }
//    }

    
    
    @IBAction func goToRecord(_ sender: UIButton) {
        
        
        //もしデータがなかれば登録ページに行くコード
        if goalInfo.goalList == [] as! [NSDictionary]{
             alertGoal()
         //もし先に記録されたデータがあればその内容を呼び表示する
        }else{
            recordInfos.readByDay(da:"\(date)")
    print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\(recordInfos.recordList)")
         if  recordInfos.recordList  != [] {
            
            
        }
    }
    }
    func goooRecord(){
        
        //まずは、同じstororyboard内であることをここで定義します
        let storyboard: UIStoryboard = self.storyboard!
        //ここで移動先のstoryboardを選択
        let second = storyboard.instantiateViewController(withIdentifier: "record")
        //ここが実際に移動するコードとなります
        self.present(second, animated: true, completion: nil)
        
    }
    
        func alertGoal(){
            
                let alert = UIAlertController(title:"", message:"先に目標を設定してください" ,
                                              preferredStyle: .alert)
                //OKボタンをアラートオブジェクトに追加
                //
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in self.goSetGoal()}))
                //handlerはOKボタンが押された時にしたい処理を書く
                //アラートを画面に表示する
                present(alert,animated: true)
                //presentで表示する
        }
    func goSetGoal(){
        //まずは、同じstororyboard内であることをここで定義します
        let storyboard: UIStoryboard = self.storyboard!
        //ここで移動先のstoryboardを選択
        let second = storyboard.instantiateViewController(withIdentifier: "setGoal")
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

