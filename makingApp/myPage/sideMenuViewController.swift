//
//  sideMenuViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2019/01/22.
//  Copyright © 2019 Nanato Mizutani. All rights reserved.
//

import UIKit
import SideMenu

class sideMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    let list = ["カレンダー","ゴールリスト"]
    
    @IBOutlet weak var listTableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        backGroundColor()
        SideMenuManager.defaultManager.menuPresentMode = .viewSlideInOut
        
        SideMenuManager.defaultManager.menuFadeStatusBar = false
        listTableView.delegate = self
        listTableView.dataSource = self
        //tableViewの背景色透明　cell間の線の削除
       listTableView.backgroundColor = UIColor.clear
        listTableView.tableFooterView = UIView()
        

        
        // Do any additional setup after loading the view.
    }
    

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
extension sideMenuViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell")
            ?? UITableViewCell(style: .default, reuseIdentifier: "mycell")
        cell.textLabel?.text = list[indexPath.row]
        cell.backgroundColor = UIColor.clear
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //セルの選択解除
       listTableView.deselectRow(at: indexPath, animated: true)
    }
}
