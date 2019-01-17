//
//  recordPageViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2018/12/20.
//  Copyright © 2018 Nanato Mizutani. All rights reserved.
//

import UIKit
import RealmSwift

let recordToday = GoalFirstInfo()
//TODO:データを飛ばす方法
class recordPageViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
      let realm = try! Realm()
    
//    var goals = ["１００キロ走る","フルマラソン完走","美味しいものをたべる"]
    var rate = [0,10,20,30,40,50,60,70,80,90,100]
    
    var goalIndex = -1
    var rateIndex = -1
    
    
    @IBOutlet weak var goalPickerView: UIPickerView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var ratePickerView: UIPickerView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        goalPickerView.delegate = self
        goalPickerView.dataSource = self
        ratePickerView.delegate = self
        ratePickerView.dataSource = self
          goalPickerView.tag = 1
        ratePickerView.tag = 2
        recordToday.readAll()
        
        //commentTextViewの話
        // 枠のカラー
        commentTextView.layer.borderColor = UIColor.gray.cgColor
        
        // 枠の幅
       commentTextView.layer.borderWidth = 1.0
        
        // 枠を角丸にする場合
        commentTextView.layer.cornerRadius = 10.0
            commentTextView.layer.masksToBounds = true
        
        //////////UIToolBarの設定////////////////////
        //キードードを閉じるボタンを作るためにツールバーを生成
        let toolBar = UIToolbar()
        
        //toolBarのサイズを設定
        toolBar.frame = CGRect(x: 0, y: 0, width: 300, height: 30)
        
        //画面幅に合わせるように設定
        toolBar.sizeToFit()
        
        //Doneボタンを右に配置するためのスペース
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        //完了ボタン
        let doneButton      = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(recordPageViewController.doneButton))
        //        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(setGoalFirstViewController.doneButton))
        
        //ツールバーにボタンを設定
        toolBar.items = [space,doneButton]
        
        
        
        
        
        //goalDetailTextViewにツールバーを設定
       commentTextView.inputAccessoryView = toolBar
        
        //Viewに追加
        self.view.addSubview(commentTextView)

    }
    
    //doneボタンを押した時の処理
    @objc func doneButton(){
        
        //キーボードを閉じる
        self.view.endEditing(true)
    }
    
    
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if pickerView.tag == 1{
                return recordToday.goalList.count
            }else{
            return rate.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print("選択されたのは\(row)行目で\(teaList[row])です。 ")
        if pickerView.tag == 1{
             print("選択されたのは\(row)行目で\(recordToday.goalList[row])です。 ")
        }else{
            print("選択されたのは\(row)行目で\(rate[row])です。 ")
        }
        
       
        print("選択されたのは\(row)行目で\([row])です。 ")
      
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //行番号を飛ばすのに苦労しました。
        if pickerView.tag == 1{
          print("goal[row]:番号\(row)")
           
             goalIndex = row
            print("DB番号：\(recordToday.goalList[row])")

            return (recordToday.goalList[row]["goal"] as! String)

        }else{
            print("rate[row]:番号\(row)")
            rateIndex = row
            print("rateIndex:\(rate)")
          
            return  "\(String(rate[row]))%"
        

 
        }
      

        

    
    }
   
    
    @IBAction func saveRecordBtn(_ sender: UIButton) {
        //アラートオブジェクトを作る
        let alert = UIAlertController(title:"保存しますか？", message: commentTextView.text,
    preferredStyle: .alert)
        //preferredStyle他のバージョン
        
        //OKボタンをアラートオブジェクトに追加
        //
        
        alert.addAction(UIAlertAction(title: "NG", style: .cancel, handler:  nil))
//        dismiss(animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in self.saveRe()}))
        //handlerはOKボタンが押された時にしたい処理を書く
        //アラートを画面に表示する
        present(alert,animated: true)
        //presentで表示する
        
        
    }
    
    func saveRe(){
        //DB書き込み処理
        print("データの書き込み開始")
        try! realm.write {
             let recordInfo1 = RecordInfo()
            recordInfo1.recordGoal = recordToday.goalList[goalIndex]["goal"] as! String
            recordInfo1.recordComment = commentTextView.text
            recordInfo1.achieveRate = rate[rateIndex]
           print("データ書き込み中")
            print(recordInfo1)
        }
     print("データ書き込み完了")
        //まずは、同じstororyboard内であることをここで定義します
        let storyboard: UIStoryboard = self.storyboard!
        //ここで移動先のstoryboardを選択
        let second = storyboard.instantiateViewController(withIdentifier: "Home")
        //ここが実際に移動するコードとなります
        self.present(second, animated: true, completion: nil)
        
        
        
    }
//        func goMypage(){
//            //まずは、同じstororyboard内であることをここで定義します
//            let storyboard: UIStoryboard = self.storyboard!
//            //ここで移動先のstoryboardを選択
//            let second = storyboard.instantiateViewController(withIdentifier: "myPage")
//            //ここが実際に移動するコードとなります
//            self.present(second, animated: true, completion: nil)
//
//
//        }
//
//
    

}

