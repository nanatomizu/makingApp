//
//  recordPageViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2018/12/20.
//  Copyright © 2018 Nanato Mizutani. All rights reserved.
//

import UIKit

//TODO:データを飛ばす方法
class recordPageViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    var goals = ["１００キロ走る","フルマラソン完走","美味しいものをたべる"]
    var rate = ["0%","10%","20%","30%","40%","50%","60%","70%","80%","90%","100%"]
    
    @IBOutlet weak var goalPickerView: UIPickerView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var ratePickerView: UIPickerView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        goalPickerView.delegate = self
     
        ratePickerView.delegate = self
          goalPickerView.tag = 1
        ratePickerView.tag = 2
        

    }
    
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if pickerView.tag == 1{
                return goals.count
            }else{
            return rate.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
            print(goals[row])
            return goals[row]
        }else{
            print(rate[row])
            return rate[row]
    }
    
    


}
}
