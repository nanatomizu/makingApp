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
    
    //達成度の値
    var myDictionary:[Double] = []
    
    var selectaIndex:Int?
    
    var dataDay:[String] = []
    
    
    @IBOutlet weak var myChartView: LineChartView!
    
    
    override func viewWillAppear(_ animated: Bool) {
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     goalInfo.readAll()
        recordInfoGraph.readGaph(goal:goalInfo.goalList[selectaIndex!]["goal"] as! String )
        print("selectaIndex",selectaIndex!)
      
//        recordInfoGraph.readGaph(goal:goalInfo.goalList[selectaIndex!]["goal"] as! String )
       
            print("これはrecordInfoGraph.recordList",recordInfoGraph.recordList)
           let reRate = recordInfoGraph.recordList.map{ $0["achieveRate"] as! Double }
            print("reRate",reRate)

            let reDay = recordInfoGraph.recordList.map{ $0["dayRecord"] as! String}
            print("reDay",reDay)
        
        for i in 0...recordInfoGraph.recordList.count - 1 {
            myDictionary.append(reRate[i])
        
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
            let chartDataSet = LineChartDataSet(values: dataEntries, label: "\(goalInfo.goalList[selectaIndex!]["goal"]!)")
            myChartView.data = LineChartData(dataSet: chartDataSet)
        
        //y軸
         let yaxis = YAxis()
        
            // X軸のラベルを設定
        recordInfoGraph.readGaph(goal: goalInfo.goalList[selectaIndex!]["goal"] as! String )
//        var moji = "赤い花"
//        if let range = moji.range(of: "赤い") {
//            moji.replaceSubrange(range, with: "青い")
//            print(moji)     // 青い花
//        }
        for i in recordInfoGraph.recordList{
            
            dataDay.append(i["dayRecord"] as! String)
        }
        let xaxis = myChartView.xAxis
        xaxis.valueFormatter = IndexAxisValueFormatter(values:dataDay)
            myChartView.xAxis.valueFormatter = xaxis.valueFormatter
//        xaxis.axisMinimum = -0.5 // axisMinimumで設定するとspaceがきかないようなので0.5でスペースをあけてみる
//        xaxis.axisMaximum = 2.5
        xaxis.labelCount = Int(1)
            // x軸のラベルをボトムに表示
            myChartView.xAxis.labelPosition = .bottom
            // グラフの背景色
            myChartView.backgroundColor  = UIColor.init(red: 134, green: 231, blue: 255, alpha: 0)
        
            // グラフの棒をニョキッとアニメーションさせる
            myChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        // グラフのタイトル
//            myChartView.chartDescription?.text = "\(goalInfo.goalList[selectaIndex!]["goal"]!)"
        ////グラフのUI設定
        //グラフのグラデーション有効化
        let gradientColors = [#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1).cgColor, #colorLiteral(red: 1, green: 0, blue: 0.09427946061, alpha: 1).withAlphaComponent(0.3).cgColor] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [0.7, 0.4] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
         chartDataSet.mode = .cubicBezier //曲線にする
         chartDataSet.drawFilledEnabled = true //グラフ下の部分塗りつぶし
        chartDataSet.lineWidth = 3.0 //線の太さ
        chartDataSet.colors = [#colorLiteral(red: 1, green: 0, blue: 0.09427946061, alpha: 1)] //Drawing graph
        
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient

        }
    
//    func aaaa()->[String]{
//        var months: [String]! = []
//        recordInfoGraph.readGaph(goal:goalInfo.goalList[selectaIndex!]["goal"] as! String  )
//        print("recordInfoGraph.recordList",recordInfoGraph.recordList,"何が入っているのかな")
//        for i in recordInfoGraph.recordList{
//
//            LineChartData(months).append(i["dayRecord"] as! String)
//        }
//
//        return LineChartData(months)
//
//    }
    
    
    
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


// public class lineChartFormatter: NSObject, IAxisValueFormatter{
//
//  // x軸のラベル
//  var months: [String?] = ["あ","い","う","え","お","か","き","く","け",]
//
//
//    // デリゲート。TableViewのcellForRowAtで、indexで渡さseれたセルをレンダリングするのに似てる。
//    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        // 0 -> Jan, 1 -> Feb...
//
//        return months[Int(value)]!
//
//    }
//}



    
   
//func aaaa(goal:String)->[String]{
//    var months: [String]! = []
//    recordInfoGraph.readAll()
//    for i in recordInfoGraph.recordList{
//        months.append(i["todaydayRecord"] as! String)
//    }
//    return months
//}




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
