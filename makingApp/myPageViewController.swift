//
//  myPageViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2018/12/19.
//  Copyright © 2018 Nanato Mizutani. All rights reserved.
//

import UIKit
import Charts

class myPageViewController: UIViewController {
    
    @IBOutlet weak var monthlyView:PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGraph()
    }
    func setupGraph() {
        monthlyView.usePercentValuesEnabled = true
        
        let values: [Double] = [0, 1, 1, 1, 1]
        let date : [Double] = [1,2,3,4,5]
        var entries: [ChartDataEntry] = Array()
        for (i, value) in values.enumerated(){
            entries.append(ChartDataEntry(x: date[i], y: value, icon: UIImage(named: "icon", in: Bundle(for: self.classForCoder), compatibleWith: nil)))
        }
        
        let dataSet = PieChartDataSet(values: entries, label: "ラベル")
        
        dataSet.colors = ChartColorTemplates.vordiplom()
        
        let chartData = PieChartData(dataSet: dataSet)
        
        monthlyView.data = chartData
    }
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


