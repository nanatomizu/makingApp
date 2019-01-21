//
//  showResultViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2019/01/21.
//  Copyright © 2019 Nanato Mizutani. All rights reserved.
//

import UIKit

class showResultViewController: UIViewController {

    
let goalTextField:UITextField = UITextField()
    var goaaaaaaal:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        
        backGroundColor()
        goals()
        achieveRate()
        comment()
        backBtn()
        // Do any additional setup after loading the view.
    }
    

    

}




extension showResultViewController{
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
    func goals(){
        let goalLabel:UILabel = UILabel()
        goalLabel.text = "目標"
        goalLabel.frame.size = CGSize(width: 120, height: 20)
        goalLabel.center = CGPoint(x: screenWidth / 2, y: 190)
        goalLabel.textAlignment = .center
        goalLabel.textColor = .black
        goalLabel.backgroundColor = .white
        view.addSubview(goalLabel)
        
        let goalTextField:UITextField = UITextField()
        goalTextField.text = goaaaaaaal
        goalTextField.frame.size = CGSize(width: 280, height: 36)
        goalTextField.center = CGPoint(x: screenWidth / 2, y: 230 )
        goalTextField.textAlignment = .center
        goalTextField.textColor = .black
        goalTextField.backgroundColor = .white
        goalTextField.isEnabled = false
        view.addSubview(goalTextField)

    }
    func achieveRate(){
        let rateLabel:UILabel = UILabel()
        rateLabel.text = "達成率"
        rateLabel.frame.size = CGSize(width: 120, height: 20)
        rateLabel.center = CGPoint(x: screenWidth / 2, y: 290)
        rateLabel.textAlignment = .center
        rateLabel.textColor = .black
        rateLabel.backgroundColor = .white
        view.addSubview(rateLabel)
        
        let rateTextField:UITextField = UITextField()
        rateTextField.text = "aaaaaaaaaaaaaaaaa"
        rateTextField.frame.size = CGSize(width: 280, height: 36)
        rateTextField.center = CGPoint(x: screenWidth / 2, y: 330 )
        rateTextField.textAlignment = .center
        rateTextField.textColor = .black
        rateTextField.backgroundColor = .white
        rateTextField.isEnabled = false
        view.addSubview(rateTextField)
        
    }
    func comment(){
        let commentabel:UILabel = UILabel()
        commentabel.text = "コメント"
        commentabel.frame.size = CGSize(width: 120, height: 20)
        commentabel.center = CGPoint(x: screenWidth / 2, y: 382)
        commentabel.textAlignment = .center
        commentabel.textColor = .black
        commentabel.backgroundColor = .white
        view.addSubview(commentabel)
        
        let commentTextView:UITextView = UITextView()
        commentTextView.text = "aaaaaaaaaaaaaaaaa"
        commentTextView.frame.size = CGSize(width: 280, height: 100)
        commentTextView.center = CGPoint(x: screenWidth / 2, y: 460 )
        commentTextView.textAlignment = .center
        commentTextView.textColor = .black
        commentTextView.backgroundColor = .white
        commentTextView.isEditable = false
        view.addSubview(commentTextView)
        
    }
    func backBtn(){
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
}

