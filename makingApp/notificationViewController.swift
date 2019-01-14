//
//  notificationViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2019/01/06.
//  Copyright © 2019 Nanato Mizutani. All rights reserved.
//

import UIKit
import RealmSwift



class notificationViewController: UIViewController,UITextFieldDelegate{
    
    let realm = try! Realm()
    
    var goal:String!
    var dueDate:String!
    var goalDetail:String?
    var monthGoal:String!
    var dayGoal:String!
    var dayTime:String!
    
    
    
    //変数を宣言する
    //今日の日付を代入
//    let nowDate = NSDate()
    let dateFormat = DateFormatter()
    let inputDatePicker = UIDatePicker()
    
    let w = UIScreen.main.bounds.size.width
    let h = UIScreen.main.bounds.size.height
    
    
    @IBOutlet weak var notificationTimeTextField: UITextField!
    @IBOutlet weak var notificationWordtextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
      notificationWordtextField.text = ""
        notificationTimeTextField.text = ""
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //日付フィールドの設定
        dateFormat.dateFormat = "hh時mm分"
//        notificationTimeTextField.text = dateFormat.string(from: nowDate as Date)
       notificationTimeTextField.delegate = self
        dateFormat.dateStyle = .none
        dateFormat.timeStyle = .short
        dateFormat.locale = Locale(identifier: "ja_JP")
        print("ここから")
        print(goal!)
        print(goalDetail!)
        print(dueDate!)
        print(monthGoal!)
        print(dayGoal!)
        print(dayTime!)
        print("ここまでデータ送れてるか確認")
      
        
        
        // DatePickerの設定(日付用)
        inputDatePicker.datePickerMode = UIDatePicker.Mode.time
        notificationTimeTextField.inputView = inputDatePicker
        
        // キーボードに表示するツールバーの表示
        let pickerToolBar = UIToolbar()
        pickerToolBar.frame =  CGRect(x:0, y:h/6, width:w, height:40.0)
        pickerToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        pickerToolBar.barStyle = .blackTranslucent
        pickerToolBar.tintColor = UIColor.white
        pickerToolBar.backgroundColor = UIColor.black
        
        //ボタンの設定
        //右寄せのためのスペース設定
        let spaceBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,target: self,action: Selector(""))
        
        //完了ボタンを設定
        let toolBarBtn      = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(toolBarBtnPush(_:)))
        
        //ツールバーにボタンを表示
        pickerToolBar.items = [spaceBarBtn,toolBarBtn]
       notificationTimeTextField.inputAccessoryView = pickerToolBar
        
        
        
        // Do any additional setup after loading the view.
    }
    
    //完了を押すとピッカーの値を、テキストフィールドに挿入して、ピッカーを閉じる
    @objc func toolBarBtnPush(_ sender: UIBarButtonItem){
        
        let pickerDate = inputDatePicker.date
        notificationTimeTextField.text = dateFormat.string(from: pickerDate)
        self.view.endEditing(true)
        
        //日付を出してます
        print(dateFormat.dateFormat)
        
    }
    
    @IBAction func saveGoalNitification(_ sender: Any) {
        //DB書き込み処理
        print("データ書き込み開始")



        try! realm.write {
            //ゴールの各内容が書き込まれる。
            let goalFirstInfo1 = GoalFirstInfo()
            goalFirstInfo1.goal = goal!
            goalFirstInfo1.dueDay = dueDate!
            goalFirstInfo1.goalImageComment = goalDetail!
            goalFirstInfo1.monthlyGoal = monthGoal!
            goalFirstInfo1.dailyGoal = dayGoal!
            goalFirstInfo1.todayTime = dayTime!
            goalFirstInfo1.notificationWord = notificationWordtextField.text!
            goalFirstInfo1.notificationTime = notificationTimeTextField.text!
            
            realm.add(goalFirstInfo1)
            print("データ書き込み中")
            print(goalFirstInfo1)
        }

        print("データ書き込み完了")
        
        goHome()
        
        
        
   }
    func goHome(){
        //まずは、同じstororyboard内であることをここで定義します
                let storyboard: UIStoryboard = self.storyboard!
           //ここで移動先のstoryboardを選択
                let second = storyboard.instantiateViewController(withIdentifier: "Home")
                //ここが実際に移動するコードとなります
                self.present(second, animated: true, completion: nil)
        
        
            }
    
    
    
    @IBAction func endNotification(_ sender: Any) {
    }
    
    
}


