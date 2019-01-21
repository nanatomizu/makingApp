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
        goalTextField.text = "テキスト"
        goalTextField.backgroundColor = UIColor.white
        goalTextField.textColor = UIColor.lightGray
        self.view.addSubview(goalTextField)
        
        let monthGoalLabel:UILabel = UILabel()
        monthGoalLabel.frame.size = CGSize(width: 279, height: 18)
        monthGoalLabel.center = CGPoint(x: screenWidth / 2, y: 242 )
        monthGoalLabel.textAlignment = .center
        monthGoalLabel.text = "1日の目標"
        monthGoalLabel.textColor = UIColor.black
        self.view.addSubview(monthGoalLabel)
        
        let monthGoalTextField:UITextField = UITextField()
        monthGoalTextField.frame.size = CGSize(width: 279, height: 24)
        monthGoalTextField.center = CGPoint(x: screenWidth / 2, y: 286 )
        monthGoalTextField.textAlignment = .center
            monthGoalTextField.isEnabled = false
        monthGoalTextField.text = "テキスト"
        monthGoalTextField.backgroundColor = UIColor.white
        monthGoalTextField.textColor = UIColor.lightGray
        self.view.addSubview(monthGoalTextField)
        
        let dayGoalLabel:UILabel = UILabel()
        dayGoalLabel.frame.size = CGSize(width: 279, height: 18)
        dayGoalLabel.center = CGPoint(x: screenWidth / 2, y: 329 )
        dayGoalLabel.textAlignment = .center
        dayGoalLabel.text = "時間"
        dayGoalLabel.textColor = UIColor.black
        self.view.addSubview(dayGoalLabel)
        
        let dayGoalTextView:UITextField = UITextField()
        dayGoalTextView.frame.size = CGSize(width: 279, height: 24)
        dayGoalTextView.center = CGPoint(x: screenWidth / 2, y: 379 )
        dayGoalTextView.textAlignment = .center
        dayGoalTextView.isEnabled = false
        dayGoalTextView.text = "テキスト"
        dayGoalTextView.backgroundColor = UIColor.white
        dayGoalTextView.textColor = UIColor.lightGray
        self.view.addSubview(dayGoalTextView)
        
        let timeLabel:UILabel = UILabel()
        dayGoalLabel.frame.size = CGSize(width: 279, height: 24)
        dayGoalLabel.center = CGPoint(x: screenWidth / 2, y: 329 )
        dayGoalLabel.textAlignment = .center
        dayGoalLabel.text = "1日の目標"
        dayGoalLabel.textColor = UIColor.black
        self.view.addSubview(dayGoalLabel)
        
        
        
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
