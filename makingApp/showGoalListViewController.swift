//
//  showGoalListViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2019/01/19.
//  Copyright © 2019 Nanato Mizutani. All rights reserved.
//

import UIKit
import RealmSwift

let goalSet = GoalFirstInfo()

class showGoalListViewController: UIViewController {
    
    var gooooooooal:String = ""
    var mooonthgoal:String = ""
    var duuuuuueday:String = ""
    var daaaaaygoal:String = ""
    var cooooooment:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalSet.readAll()
        //背景
        backGroundColor()
        
        //labelとtextFieldの配置
        let goalLabel:UILabel = UILabel()
        goalLabel.frame.size = CGSize(width: 279, height: 18)
        goalLabel.center = CGPoint(x: screenWidth / 2, y: 144)
        goalLabel.textAlignment = .center
        goalLabel.text = "目標"
        goalLabel.textColor = UIColor.black
        self.view.addSubview(goalLabel)
        
        let goalTextField:UITextField = UITextField()
        goalTextField.frame.size = CGSize(width: 279, height: 24)
        goalTextField.center = CGPoint(x: screenWidth / 2, y: 192 )
        goalTextField.textAlignment = .center
//        goalTextField.backgroundColor =
        goalTextField.isEnabled = false
        goalTextField.text = gooooooooal
        goalTextField.backgroundColor = UIColor.white
        goalTextField.textColor = UIColor.black
        self.view.addSubview(goalTextField)
        
        let monthGoalLabel:UILabel = UILabel()
        monthGoalLabel.frame.size = CGSize(width: 279, height: 18)
        monthGoalLabel.center = CGPoint(x: screenWidth / 2, y: 242 )
        monthGoalLabel.textAlignment = .center
        monthGoalLabel.text = "月の目標"
        monthGoalLabel.textColor = UIColor.black
        self.view.addSubview(monthGoalLabel)
        
        let monthGoalTextField:UITextField = UITextField()
        monthGoalTextField.frame.size = CGSize(width: 279, height: 24)
        monthGoalTextField.center = CGPoint(x: screenWidth / 2, y: 286 )
        monthGoalTextField.textAlignment = .center
            monthGoalTextField.isEnabled = false
        monthGoalTextField.text = mooonthgoal
        monthGoalTextField.backgroundColor = UIColor.white
        monthGoalTextField.textColor = UIColor.black
        self.view.addSubview(monthGoalTextField)
        
        let dueDayLabel:UILabel = UILabel()
        dueDayLabel.frame.size = CGSize(width: 279, height: 18)
        dueDayLabel.center = CGPoint(x: screenWidth / 2, y: 329 )
        dueDayLabel.textAlignment = .center
        dueDayLabel.text = "期限"
        dueDayLabel.textColor = UIColor.black
        self.view.addSubview(dueDayLabel)
        
        let dueDayTextField:UITextField = UITextField()
            dueDayTextField.frame.size = CGSize(width: 279, height: 24)
        dueDayTextField.center = CGPoint(x: screenWidth / 2, y: 379 )
        dueDayTextField.textAlignment = .center
        dueDayTextField.isEnabled = false
        dueDayTextField.text = duuuuuueday
        dueDayTextField.backgroundColor = UIColor.white
        dueDayTextField.textColor = UIColor.black
        self.view.addSubview(dueDayTextField)
        
        let timeLabel:UILabel = UILabel()
        timeLabel.frame.size = CGSize(width: 279, height: 24)
        timeLabel.center = CGPoint(x: screenWidth / 2, y: 423 )
        timeLabel.textAlignment = .center
        timeLabel.text = "1日の目標"
        timeLabel.backgroundColor = .clear
        timeLabel.textColor = UIColor.black
        self.view.addSubview(timeLabel)
        
        let timeTextField:UITextField = UITextField()
        timeTextField.frame.size = CGSize(width: 279, height: 24)
        timeTextField.center = CGPoint(x: screenWidth / 2, y: 466 )
        timeTextField.textAlignment = .center
        timeTextField.isEnabled = false
        timeTextField.text = daaaaaygoal
        timeTextField.backgroundColor = UIColor.white
        timeTextField.textColor = UIColor.black
        self.view.addSubview(timeTextField)
        
        let commentLabel:UILabel = UILabel()
        commentLabel.frame.size = CGSize(width: 279, height: 25)
        commentLabel.center = CGPoint(x: screenWidth / 2, y: 515 )
        commentLabel.textAlignment = .center
        commentLabel.text = "コメント"
        commentLabel.backgroundColor = .clear
        commentLabel.textColor = UIColor.black
        self.view.addSubview(commentLabel)
        
        
        let commentTextView:UITextView = UITextView()
        commentTextView.frame.size = CGSize(width: 279, height: 75)
        commentTextView.center = CGPoint(x: screenWidth / 2, y:570  )
        commentTextView.textAlignment = .center
        commentTextView.isEditable = false
        commentTextView.text = cooooooment
        commentTextView.backgroundColor = UIColor.white
        commentTextView.textColor = UIColor.black
        self.view.addSubview(commentTextView)
        
        
        
        
        
        
        let backButton:UIButton = UIButton()
        backButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        backButton.setTitle("back", for: .normal)
        backButton.setTitleColor(UIColor.blue, for: .normal)
        backButton.layer.position = CGPoint(x: self.view.frame.width/2, y: 670)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.view.addSubview(backButton)
      
    }
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension showGoalListViewController{
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
