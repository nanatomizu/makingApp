//
//  setGoalSecondViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2019/01/11.
//  Copyright © 2019 Nanato Mizutani. All rights reserved.
//

import UIKit
import RealmSwift

class setGoalSecondViewController: UIViewController,UITextFieldDelegate {
    
    
    var goal:String!
    var dueDate:String!
    var goalDetail:String!
    
    //変数を宣言する
    //今日の日付を代入
//        let nowDate = NSDate()
    let dateFormat = DateFormatter()
    let inputDatePicker = UIDatePicker()
    
    let w = UIScreen.main.bounds.size.width
    let h = UIScreen.main.bounds.size.height
    
    
    @IBOutlet weak var monthGoalLabel: UILabel!
    @IBOutlet weak var dayGoalLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var monthGoalTextView: UITextField!
    @IBOutlet weak var dayGoalTextView: UITextField!
    @IBOutlet weak var timeSelecterTextField: UITextField!
    
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        monthGoalTextView.text = ""
        dayGoalTextView.text = ""
        timeSelecterTextField.text = ""
            }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ラベル、テキストビューの配置、サイズ設定
        monthGoalLabel.frame.size = CGSize(width: 279, height: 19)
        monthGoalLabel.center = CGPoint(x: screenWidth / 2, y: 216)
        monthGoalTextView.frame.size = CGSize(width: 279, height: 36 )
        monthGoalTextView.center = CGPoint(x: screenWidth / 2, y: 264)
        dayGoalLabel.frame.size = CGSize(width: 279, height: 19)
        dayGoalLabel.center = CGPoint(x: screenWidth / 2, y: 319)
        dayGoalTextView.frame.size = CGSize(width: 279, height: 36)
        dayGoalTextView.center = CGPoint(x: screenWidth / 2, y: 372)
        timeLabel.frame.size = CGSize( width: 300, height: 19)
        timeLabel.center = CGPoint(x: screenWidth / 2 , y: 427)
        timeSelecterTextField.frame.size = CGSize( width: 279, height: 36)
        timeSelecterTextField.center = CGPoint(x: screenWidth / 2 , y: 480)
        backBtn.frame.size = CGSize(width: 36, height: 36)
        backBtn.center = CGPoint(x: screenWidth / 2 - 75, y: 670 )
        nextBtn.frame.size = CGSize(width: 36, height: 36)
        nextBtn.center = CGPoint(x: screenWidth / 2 + 75, y: 670 )

        
        //背景
        backGroundColor()
        //日付フィールドの設定
//        dateFormat.dateFormat = "hh時mm分"
//        timeSelecterTextField.text = dateFormat.string(from: nowDate as Date)
        timeSelecterTextField.delegate = self
        dateFormat.dateStyle = .none
        dateFormat.timeStyle = .short
        dateFormat.locale = Locale(identifier: "ja_JP")
        print(goal)
        print(dueDate)
        print(goalDetail)
        
        
        // DatePickerの設定(時間用)
      
        inputDatePicker.datePickerMode = UIDatePicker.Mode.time
        timeSelecterTextField.inputView = inputDatePicker
       
        
        
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
        timeSelecterTextField.inputAccessoryView = pickerToolBar
        
        
    }
    //完了を押すとピッカーの値を、テキストフィールドに挿入して、ピッカーを閉じる
    @objc func toolBarBtnPush(_ sender: UIBarButtonItem){
        
        let pickerDate = inputDatePicker.date
        timeSelecterTextField.text = dateFormat.string(from: pickerDate)
        self.view.endEditing(true)
        
        //日付を出してます
        print(dateFormat.dateFormat)
        print(timeSelecterTextField.text!)
        //指定したIDのSegueを初期化する。同時にパラメータを渡すことができる
        //        self.performSegue(withIdentifier: "nextNotification"
        //            , sender:nil)
    }
    
    @IBAction func btnNextPage(_ sender: Any) {
        if monthGoalTextView.text == "" && dayGoalTextView.text == "" &&
            timeSelecterTextField.text == ""{
            alert()
        }else if  monthGoalTextView.text == "" || dayGoalTextView.text == "" ||
            timeSelecterTextField.text == ""{
            alert()
            
        }else{
        self.performSegue(withIdentifier: "nextNotification"
                           , sender:nil)
        }
    }
//    func goToNextPage(){
//        //        指定したIDのSegueを初期化する。同時にパラメータを渡すことができる
////                self.performSegue(withIdentifier: "nextNotification"
////                    , sender:nil)
//        //        //まずは、同じstororyboard内であることをここで定義します
//        let storyboard: UIStoryboard = self.storyboard!
//        //        //ここで移動先のstoryboardを選択(今回の場合は先ほどsecondと名付けたのでそれを書きます)
//        let second = storyboard.instantiateViewController(withIdentifier: "Nitification")
//        //ここが実際に移動するコードとなります
//        self.present(second, animated: true, completion: nil)
    
        
    
    
    
    //Segueの初期化を通知するメソッドをオーバーライドする。senderにはperformSegue()で渡した値が入る。
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextNotification" {
            let nVC = segue.destination as! notificationViewController
            nVC.goal = goal
            nVC.dueDate = dueDate
            nVC.goalDetail = goalDetail
            nVC.monthGoal = monthGoalTextView.text
            nVC.dayGoal = dayGoalTextView.text
            nVC.dayTime = timeSelecterTextField.text
            print()
        }
    }
        func alert(){
            if monthGoalTextView.text == "" && dayGoalTextView.text == "" &&
            timeSelecterTextField.text == ""{
                let alert = UIAlertController(title:"記入漏れありますよ", message:"月と1日のゴール、時間を入力してください！" ,
                                              preferredStyle: .alert)
                //OKボタンをアラートオブジェクトに追加
                //
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                //handlerはOKボタンが押された時にしたい処理を書く
                //アラートを画面に表示する
                present(alert,animated: true)
                //presentで表示する
                
            }else if monthGoalTextView.text == "" {
                //アラートオブジェクトを作る
                let alert = UIAlertController(title:"記入漏れありますよ", message:"月のゴールを入力してください！" ,
                                              preferredStyle: .alert)
                //OKボタンをアラートオブジェクトに追加
                //
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                //handlerはOKボタンが押された時にしたい処理を書く
                //アラートを画面に表示する
                present(alert,animated: true)
                //presentで表示する
            }else if dayGoalTextView.text == ""{
                let alert = UIAlertController(title:"記入漏れありますよ", message:"1日の目標はなんですか！" ,
                                              preferredStyle: .alert)
                
                //OKボタンをアラートオブジェクトに追加
                //
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                //handlerはOKボタンが押された時にしたい処理を書く
                //アラートを画面に表示する
                present(alert,animated: true)
                //presentで表示する
                
                
            }else if timeSelecterTextField.text == ""{
                let alert = UIAlertController(title:"記入漏れありますよ", message:"何時にやりますか！" ,
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
    
   
    
    @IBAction func backPageBtn(_ sender: UIButton) {
          self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    @IBAction func endMonth(_ sender: Any) {
    }
    @IBAction func endDay(_ sender: Any) {
    }
    
}
extension setGoalSecondViewController{
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
