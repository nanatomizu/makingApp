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

//TODO:データの受け渡し
//TODO:データに応じて値を変える

class myPageViewController: UIViewController
{
    

    
    
    
    let data:[[Double]] = [[0,1,1,2,3,5,8,13],[10,14,30,44,52,11,22,44]]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(x:10, y: 50, width: 350, height: self.view.frame.height - 70)
        
        let chartView = LineChartView(frame: rect)
        
        var entries = [[ChartDataEntry]]()
        var dataSets = [LineChartDataSet]()
        
        for i in 0 ..< data.count{
            //空の配列を追加する
            entries.append([ChartDataEntry]())
            for (j, d) in data[i].enumerated() {
                entries[i].append(ChartDataEntry(x: Double(j), y: d ))
            }
            let dataSet = LineChartDataSet(values: entries[i], label: "data\(i)")
            dataSets.append(dataSet)
        }
        
        //chartView.data = LineChartData(dataSet: dataSet)　→ LineChartData(dataSets: dataSets as! [IChartDataSet])
        chartView.data = LineChartData(dataSets: dataSets as! [IChartDataSet])
        
        self.view.addSubview(chartView)
        
    }
    
    
}
