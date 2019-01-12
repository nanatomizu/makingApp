//
//  setGoalFirstViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2019/01/06.
//  Copyright © 2019 Nanato Mizutani. All rights reserved.
//

//TODO:完了押したらエラーを出すのを改善する

import UIKit
import RealmSwift

class setGoalFirstViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
     let realm = try! Realm()
    
    //変数を宣言する
    //今日の日付を代入
    let nowDate = NSDate()
    let dateFormat = DateFormatter()
    let inputDatePicker = UIDatePicker()
    
    let w = UIScreen.main.bounds.size.width
    let h = UIScreen.main.bounds.size.height

    
    
    @IBOutlet weak var goalTextField: UITextField!
    @IBOutlet weak var dateSelecter: UITextField!
    @IBOutlet weak var goalDetailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //日付フィールドの設定
        dateFormat.dateFormat = "yyyy年MM月dd日"
        dateSelecter.text = dateFormat.string(from: nowDate as Date)
        self.dateSelecter.delegate = self
       goalDetailTextView.delegate = self
        
        
        // DatePickerの設定(日付用)
        inputDatePicker.datePickerMode = UIDatePicker.Mode.date
        dateSelecter.inputView = inputDatePicker
        
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
        dateSelecter.inputAccessoryView = pickerToolBar
        
        //goalDetailTextViewの話
        // 枠のカラー
        goalDetailTextView.layer.borderColor = UIColor.gray.cgColor
        
        // 枠の幅
        goalDetailTextView.layer.borderWidth = 1.0
        
        // 枠を角丸にする場合
        goalDetailTextView.layer.cornerRadius = 10.0
        goalDetailTextView.layer.masksToBounds = true
        
        //////////UIToolBarの設定////////////////////
        //キードードを閉じるボタンを作るためにツールバーを生成
        let toolBar = UIToolbar()
        
        //toolBarのサイズを設定
        toolBar.frame = CGRect(x: 0, y: 0, width: 300, height: 30)
        
        //画面幅に合わせるように設定
        toolBar.sizeToFit()
        
        //Doneボタンを右に配置するためのスペース
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        //Doneボタン
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(setGoalFirstViewController.doneButton))
        
        //ツールバーにボタンを設定
        toolBar.items = [space,doneButton]
        
        
        
        
        
        //goalDetailTextViewにツールバーを設定
        goalDetailTextView.inputAccessoryView = toolBar
        
        //Viewに追加
        self.view.addSubview(goalDetailTextView)
    }
    
    
    //doneボタンを押した時の処理
   @objc func doneButton(){
        
        //キーボードを閉じる
        self.view.endEditing(true)
    }
      
    
   
    
    
    
    //完了を押すとピッカーの値を、テキストフィールドに挿入して、ピッカーを閉じる
   @objc func toolBarBtnPush(_ sender: UIBarButtonItem){
        
        let pickerDate = inputDatePicker.date
        dateSelecter.text = dateFormat.string(from: pickerDate)
        self.view.endEditing(true)
    
    //日付を出してます
    print(inputDatePicker.date)
   print(dateSelecter.text!)
    }
   
  
    
    @IBAction func clsGoal(_ sender: Any) {
    }
    
    @IBAction func btnNextPage(_ sender: Any) {
        //DB書き込み処理
        print("データ書き込み開始")
        
        
        
        try! realm.write {
            //ゴールの各内容が書き込まれる。
            let goalFirstInfo1 = GoalFirstInfo()
            goalFirstInfo1.goal = goalTextField.text!
            goalFirstInfo1.dueDay = dateSelecter.text!
            goalFirstInfo1.goalImageComment = goalDetailTextView.text!
            realm.add(goalFirstInfo1)
            print("データ書き込み中")
            print(goalFirstInfo1)
        }
        
        print("データ書き込み完了")
        
        
        
        
    }
    
}
    

