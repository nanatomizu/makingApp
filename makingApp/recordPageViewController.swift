//
//  recordPageViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2018/12/20.
//  Copyright © 2018 Nanato Mizutani. All rights reserved.
//

import UIKit
import RealmSwift

let recordToday = GoalInfo()
//TODO:データを飛ばす方法
class recordPageViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
//    var goals = ["１００キロ走る","フルマラソン完走","美味しいものをたべる"]
    var rate = ["0%","10%","20%","30%","40%","50%","60%","70%","80%","90%","100%"]
    
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

            return recordToday.goalList[row]["goal"] as! String

        }else{
            print("rate[row]:番号\(row)")
            rateIndex = row
            print("rateIndex:\(rate)")
          
            return rate[row]
        

 
        }
        //意味不明なとこ
//        performSegue(withIdentifier:"scRecordResult", sender: nil)
//
//    }


        

        //今選択された行番号を格納
//        goalIndex = indexPath.row
//        rateIndex = indexPath.row
        //セグエの名前を指定して、移動

//    performSegue(withIdentifier:"scRecordResult", sender: nil)
//        print(indexPath.row)

    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let crVC = segue.destination as! checkResultViewController
        crVC.goalIndex = goalIndex
        crVC.rateIndex = rateIndex
        print("送る時のgoalIndex:\(goalIndex)")
        print("送る時のrateIndex:\(rateIndex)")
        print("送る時のgoalIndex:\(recordToday.goalList[goalIndex])")
        if segue.identifier == "scRecordResult"{
            let checkResultViewController:checkResultViewController = segue.destination as! checkResultViewController
            checkResultViewController.comment = self.commentTextView.text

        }
            
       
    }

    

}
