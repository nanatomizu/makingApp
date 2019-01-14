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
    //    let nowDate = NSDate()
    let dateFormat = DateFormatter()
    let inputDatePicker = UIDatePicker()
    
    let w = UIScreen.main.bounds.size.width
    let h = UIScreen.main.bounds.size.height

    
    @IBOutlet weak var monthGoalTextView: UITextField!
    @IBOutlet weak var dayGoalTextView: UITextField!
    @IBOutlet weak var timeSelecterTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
       monthGoalTextView.text = ""
        dayGoalTextView.text = ""
        timeSelecterTextField.text = ""
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //日付フィールドの設定
                dateFormat.dateFormat = "hh時mm分"
        //        notificationTimeTextField.text = dateFormat.string(from: nowDate as Date)
       timeSelecterTextField.delegate = self
        dateFormat.dateStyle = .none
        dateFormat.timeStyle = .short
        dateFormat.locale = Locale(identifier: "ja_JP")
        print(goal)
        print(dueDate)
        print(goalDetail)
        
        
        // DatePickerの設定(日付用)
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
//        goToNextPage()
        
        }
    func goToNextPage(){
//        指定したIDのSegueを初期化する。同時にパラメータを渡すことができる
//        self.performSegue(withIdentifier: "nextNotification"
//            , sender:nil)
        //        //まずは、同じstororyboard内であることをここで定義します
                let storyboard: UIStoryboard = self.storyboard!
        //        //ここで移動先のstoryboardを選択(今回の場合は先ほどsecondと名付けたのでそれを書きます)
                let second = storyboard.instantiateViewController(withIdentifier: "Nitification")
                //ここが実際に移動するコードとなります
                self.present(second, animated: true, completion: nil)
        
        
    }
    
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
        }
    }
   
    

   
        
        
        
    
    
    @IBAction func endMonth(_ sender: Any) {
    }
    @IBAction func endDay(_ sender: Any) {
    }
    
}
