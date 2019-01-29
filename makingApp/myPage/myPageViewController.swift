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
let goalInfoGraph  = GoalFirstInfo()

//TODO:データの受け渡し
//TODO:データに応じて値を変える
//日付と達成率のデータを取ってくる->配列にセットする->配列に沿って表示させる
//

class myPageViewController: UIViewController{
    
    //左が達成度の値、右が日付
    var myDictionary:[Double] = []
    
    var selectaIndex:String?
    
    @IBOutlet weak var myChartView: LineChartView!
    
    
    override func viewWillAppear(_ animated: Bool) {
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
     
        
     goalInfo.readAll()
  
        
        
//        for i in goalInfoGraph.goalList{
//            goaaaaaal = i["goal"] as! String
        recordInfoGraph.readGaph(goal:selectaIndex! )
       
            print("これはrecordInfoGraph.recordList",recordInfoGraph.recordList)
           let reRate = recordInfoGraph.recordList.map{ $0["achieveRate"] as! Double }
            print("reRate",reRate)

            let reDay = recordInfoGraph.recordList.map{ $0["dayRecord"] as! String}
            print("reDay",reDay)
        
        for i in 0...recordInfoGraph.recordList.count - 1 { myDictionary.append(reRate[i])
        
                setChart(y: myDictionary)
        }
           print("myDictionary",myDictionary)
        
      

    
    
         backGroundColor()
 
    }
    func setChart(y: [Double]) {
            // プロットデータ(y軸)を保持する配列
            var dataEntries = [ChartDataEntry]()
            
            for (i, val) in y.enumerated() {
                let dataEntry = ChartDataEntry(x: Double(i), y: Double(val)) // X軸データは、0,1,2,...
                dataEntries.append(dataEntry)
            }
            // グラフをUIViewにセット
            let chartDataSet = LineChartDataSet(values: dataEntries, label: "Units Sold")
            myChartView.data = LineChartData(dataSet: chartDataSet)
            
            // X軸のラベルを設定
            let xaxis = XAxis()
        xaxis.valueFormatter = lineChartFormatter()
            myChartView.xAxis.valueFormatter = xaxis.valueFormatter
            
            // x軸のラベルをボトムに表示
            myChartView.xAxis.labelPosition = .bottom
            // グラフの色
            chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
            // グラフの背景色
            myChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
            // グラフの棒をニョキッとアニメーションさせる
            myChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
//            // 横に赤いボーダーラインを描く
//            let ll = ChartLimitLine(limit: 10.0, label: "Target")
//            myChartView.rightAxis.addLimitLine(ll)
            // グラフのタイトル
            myChartView.chartDescription?.text = "Cool Graph!"
        }
    
    
    
    @IBAction func changeBtn(_ sender: UIButton) {
        
        
//        var  rect = CGRect(x:0, y: 100, width: screenWidth, height: self.view.frame.height - 350)
//        let chartView = LineChartView(frame: rect)
//        chartView.backgroundColor = UIColor.white
//        ////二つ目出してます
//        var goal2:String?
//        goal2 = goalInfoGraph.goalList[1]["goal"] as! String
//
//        print("goal2!\(goal2!)")
//
//        recordInfoGraph.recordList = []
//        recordInfoGraph.readGaph(goal: goal2!)
//
//
//        let testGoals2 = recordInfoGraph.recordList.map{ $0["recordGoal"] as! String}
//        print(testGoals2)
//        let  testDay2 = recordInfoGraph.recordList.map{ $0["dayRecord"] as! String}
//        print(testDay2)
//        let testRate2 = recordInfoGraph.recordList.map{ $0["achieveRate"] }
//        var entry = [ChartDataEntry]()
//
//        myDictionary = []
//        for i in 0...testGoals2.count - 1{
//
//            myDictionary.append(testRate2[i] as! Int)
//                       print("myDictionary\(myDictionary)")
//        }
//
//
//        for (i, d) in myDictionary.enumerated() {
//            entry.append(ChartDataEntry(x: Double(i) , y: Double(d)))
//        }
//
//        let dataSet = LineChartDataSet(values: entry, label: "\(goal2!)")
//
//        chartView.data = LineChartData(dataSet: dataSet)
//        chartView.notifyDataSetChanged()// let the chart know it's data changed
//
//        chartView.data?.notifyDataChanged()
//        view.addSubview(chartView)
//
//
//
   }
    

    }
 public class lineChartFormatter: NSObject, IAxisValueFormatter{
    
    // x軸のラベル
    
    var months: [String]! =
        recordInfoGraph.recordList.map{ $0["dayRecord"] as! String}
    
    // デリゲート。TableViewのcellForRowAtで、indexで渡されたセルをレンダリングするのに似てる。
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        // 0 -> Jan, 1 -> Feb...
        return months[Int(value)]
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
