//
//  myPageViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2018/12/19.
//  Copyright © 2018 Nanato Mizutani. All rights reserved.
//

import UIKit
import Charts
import RealmSwift
import  SlideMenuControllerSwift
import  SideMenu

let recordInfoGraph = RecordInfo()

//TODO:データの受け渡し
//TODO:データに応じて値を変える
//日付と達成率のデータを取ってくる->配列にセットする->配列に沿って表示させる
//

class myPageViewController: UIViewController
{
    

    

    let data:[[Double]] = [[0,1,1,3,5,8,13],[10,14,30,44,52,11,22,44],[20,30,40,50,60,70,80,90,100,12,13,24,43,3,5,53,43,34,43,34,3,2,32,34,3,54,4,65,76,89,67,65,45,54,43,54,34,43,34,3,32,4,34,45,45,3,43,32,34,43,45,34,34,32]]
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordInfoGraph.readAll()
        
       
      
        
         backGroundColor()
        
        let rect = CGRect(x:0, y: 100, width: screenWidth, height: self.view.frame.height - 350)
        
        let chartView = LineChartView(frame: rect)
         chartView.backgroundColor = UIColor.white
        
        
        var entries = [[ChartDataEntry]]()
        var dataSets = [LineChartDataSet]()
        
        
        
        for i in 0 ..< data.count{
            //空の配列を追加する
            entries.append([ChartDataEntry]())
            for (j, d) in data[i].enumerated() {
                entries[i].append(ChartDataEntry(x: Double(j), y: Double(d) ))
            }
            let dataSet = LineChartDataSet(values: entries[i], label: "data\(i)")
            dataSets.append(dataSet)
            
        }
        
        //chartView.data = LineChartData(dataSet: dataSet)　→ LineChartData(dataSets: dataSets as! [IChartDataSet])
        chartView.data = LineChartData(dataSets: dataSets as! [IChartDataSet])
        
       
        self.view.addSubview(chartView)
        
    }
    
    
    
}


extension myPageViewController{
    
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
