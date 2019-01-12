//
//  notificationViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2019/01/06.
//  Copyright © 2019 Nanato Mizutani. All rights reserved.
//

import UIKit

class notificationViewController: UIViewController,UITextFieldDelegate{
    
    //変数を宣言する
    //今日の日付を代入
//    let nowDate = NSDate()
    let dateFormat = DateFormatter()
    let inputDatePicker = UIDatePicker()
    
    let w = UIScreen.main.bounds.size.width
    let h = UIScreen.main.bounds.size.height
    
    
    @IBOutlet weak var notificationTimeTextField: UITextField!
    @IBOutlet weak var notificationWordtextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //日付フィールドの設定
//        dateFormat.dateFormat = "yyyy年MM月dd日"
//        notificationTimeTextField.text = dateFormat.string(from: nowDate as Date)
       notificationTimeTextField.delegate = self
        dateFormat.dateStyle = .none
        dateFormat.timeStyle = .short
        dateFormat.locale = Locale(identifier: "ja_JP")
        
      
        
        
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
    
    @IBAction func endNotification(_ sender: Any) {
    }
    
    
}

