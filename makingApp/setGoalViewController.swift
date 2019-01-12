//
//  setGoalViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2018/12/20.
//  Copyright © 2018 Nanato Mizutani. All rights reserved.
//

import UIKit
import RealmSwift
//TODO:タグ付け
//TODO:テキストに入力されたデータを飛ばす
//TODO:save押した後にMypageへとばすコード遷移の




class setGoalViewController: UIViewController {
    
     let realm = try! Realm()

    @IBOutlet weak var GoalTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var dailyTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
     
    }
    
    @IBAction func tapBtnSave(_ sender: Any) {
        //アラートオブジェクトを作る
        let alert = UIAlertController(title: "", message: "保存しますか？", preferredStyle: .alert)
        //OKボタンをアラートオブジェクトに追加
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in self.Home()}))
        //アラートを画面に表示する
        present(alert,animated: true)
        //presentで表示する
    }
 
//    func myMessage(){ //myMessageは関数
//        print("OK押されました")
////    }
      func  Home(){
        //まずは、同じstororyboard内であることをここで定義します
        let storyboard: UIStoryboard = self.storyboard!
        //ここで移動先のstoryboardを選択(今回の場合は先ほどsecondと名付けたのでそれを書きます)
        let second = storyboard.instantiateViewController(withIdentifier: "Home")
        //ここが実際に移動するコードとなります
        self.present(second, animated: true, completion: nil)
//
//        //DB書き込み処理
//            print("データ書き込み開始")
//
//
//
//            try! realm.write {
//                //ゴールの各内容が書き込まれる。
//                let GoalInfo1 = goalInfo()
//                GoalInfo1.goal = GoalTextField.text!
//                GoalInfo1.monthlyGoal = monthTextField.text!
//                GoalInfo1.dailyGoal = dailyTextField.text!
//                realm.add(GoalInfo1)
//                print("データ書き込み中")
//                print(GoalInfo1)
//            }
//
//            print("データ書き込み完了")
//
//
//
//
//
//        }
//
//
//    @IBAction func endGoal(_ sender: Any) {
//
//    }
//
//    @IBAction func endmonth(_ sender: Any) {
//    }
//
//    @IBAction func enddaily(_ sender: Any) {
//    }
//
//    }
//
//
//
}
}
