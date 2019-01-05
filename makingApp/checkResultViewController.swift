//
//  checkResultViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2018/12/22.
//  Copyright © 2018 Nanato Mizutani. All rights reserved.
//

import UIKit
import RealmSwift

let checkRecord = GoalInfo()
//TODO:もう一枚ページを作って確認するのか、アクションで確認するのかを考える
//TODO:先ずはデータの送信
class checkResultViewController: UIViewController {
    
//    var goals = ["１００キロ走る","フルマラソン完走","美味しいものをたべる"]
    var rate = ["0%","10%","20%","30%","40%","50%","60%","70%","80%","90%","100%"]
    
    var comment = ""
    var goalIndex = -1
    var rateIndex = -1
   
    @IBOutlet weak var checkResultGoalLabel: UILabel!
    @IBOutlet weak var checkResultCommentTextView: UITextView!
    @IBOutlet weak var checkResultRateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(comment)
        checkResultCommentTextView.text = comment
        checkRecord.readAll()

        // Do any additional setup after loading the view.
    }
    //送られてきたデータを表示する
     override func viewWillAppear(_ animated: Bool) {
        //前の画面で選択された行番号を表示
        print("選択された行番号：\(goalIndex)")
        print("選択された行番号：\(rateIndex)")
        
//        print(checkRecord.goalList[goalIndex]["goal"] as! String)
       //ゴールとrateを表示
        checkResultGoalLabel.text = checkRecord.goalList[goalIndex]["goal"] as! String
        checkResultRateLabel.text = rate[rateIndex]

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

        
//        checkResultGoalLabel.text = goals[goalIndex]
//
//      checkResultCommentTextView.text =
//        checkResultRateLabel.text = rate[selectIndex]

}
}
