//
//  notificationViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2019/01/06.
//  Copyright © 2019 Nanato Mizutani. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications


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
    let nowDate = NSDate()
    let dateFormat = DateFormatter()
    let inputDatePicker = UIDatePicker()
    
    let w = UIScreen.main.bounds.size.width
    let h = UIScreen.main.bounds.size.height
   
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    
    
    @IBOutlet weak var notificationTimeTextField: UITextField!
    @IBOutlet weak var notificationWordtextField: UITextField!
    
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        notificationWordtextField.text = ""
        notificationTimeTextField.text = ""
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        backGroundColor()
        //ラベルとテキストフィールドとボタンの設定
        timeLabel.frame.size = CGSize(width: 279, height: 19)
        timeLabel.center = CGPoint(x: screenWidth / 2, y: 216)
        notificationTimeTextField.frame.size = CGSize(width: 279, height: 36 )
        notificationTimeTextField.center = CGPoint(x: screenWidth / 2, y: 264)
        wordLabel.frame.size = CGSize( width: 300, height: 19)
        wordLabel.center = CGPoint(x: screenWidth / 2 , y: 400)
        notificationWordtextField.frame.size = CGSize( width: 279, height: 36)
        notificationWordtextField.center = CGPoint(x: screenWidth / 2 , y: 448)
        backBtn.frame.size = CGSize(width: 36, height: 36)
        backBtn.center = CGPoint(x: screenWidth / 2 - 75, y: 670 )
        saveBtn.frame.size = CGSize(width: 36, height: 36)
        saveBtn.center = CGPoint(x: screenWidth / 2 + 75, y: 670 )
        
        //日付フィールドの設定
        dateFormat.dateFormat = "hh時mm分"
//        notificationTimeTextField.text = dateFormat.string(from: nowDate as Date)
       notificationTimeTextField.delegate = self
        dateFormat.dateStyle = .none
        dateFormat.timeStyle = .short
        dateFormat.locale = Locale(identifier: "ja_JP")
        
        print("ここから")
        print(goal)
        print(goalDetail)
        print(dueDate)
        print(monthGoal)
        print(dayGoal)
        print(dayTime)
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
        print("pickerDate", pickerDate)
        
    }
    
    @IBAction func saveGoalNitification(_ sender: Any) {
        if notificationWordtextField.text == "" && notificationTimeTextField.text == "" {
            alert()
        }else if  notificationWordtextField.text == "" || notificationTimeTextField.text == ""{
            alert()
            
        }else{
            
       
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
            goalFirstInfo1.notificationTime = inputDatePicker.date
            
            realm.add(goalFirstInfo1)
            print("データ書き込み中")
            print(goalFirstInfo1)
        }

            
        print("データ書き込み完了")
            
            
            
        goHome()
        
        
        
   }
    }
    
    @IBAction func backPageBtn(_ sender: UIButton) {
       self.dismiss(animated: true, completion: nil)
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
    func alert(){
    
        if notificationWordtextField.text == "" && notificationTimeTextField.text == ""{
            let alert = UIAlertController(title:"記入漏れありますよ", message:"通知の時間と文を入力してください！" ,
                                          preferredStyle: .alert)
            //OKボタンをアラートオブジェクトに追加
            //
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            //handlerはOKボタンが押された時にしたい処理を書く
            //アラートを画面に表示する
            present(alert,animated: true)
            //presentで表示する
            
        }else if notificationTimeTextField.text == "" {
            //アラートオブジェクトを作る
            let alert = UIAlertController(title:"記入漏れありますよ", message:"通知時間を決めてください！" ,
                                          preferredStyle: .alert)
            //OKボタンをアラートオブジェクトに追加
            //
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            //handlerはOKボタンが押された時にしたい処理を書く
            //アラートを画面に表示する
            present(alert,animated: true)
            //presentで表示する
        }else if notificationWordtextField.text == ""{
            let alert = UIAlertController(title:"記入漏れありますよ", message:"やる気の出るメッセージを設定してください！" ,
                                          preferredStyle: .alert)
            
            //OKボタンをアラートオブジェクトに追加
            //
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            //handlerはOKボタンが押された時にしたい処理を書く
            //アラートを画面に表示する
            present(alert,animated: true)
            //presentで表示する
            
            
        }
        
        }
        
    }
    
    

extension notificationViewController{
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
