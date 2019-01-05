//
//  myPageViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2018/12/19.
//  Copyright © 2018 Nanato Mizutani. All rights reserved.
//

import UIKit
import Charts
//TODO:データの受け渡し
//TODO:データに応じて値を変える

let w = UIScreen.main.bounds.size.width
let h = UIScreen.main.bounds.size.height

class myPageViewController: UIViewController {
    
    

    
    @IBOutlet weak var monthlyView:PieChartView!
    @IBOutlet weak var weeklyView: PieChartView!
    @IBOutlet weak var dailyView: PieChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGraph()
        setupGrapha2()
        setupGraph3()
        //目標追加ボタン
        let addBtn = UIButton(frame: CGRect(x: w   - 70, y: h - 150 , width: 60, height: 60))
        addBtn.setTitle("+", for: UIControl.State())
        addBtn.setTitleColor(.white, for: UIControl.State())
        addBtn.backgroundColor = .orange
        addBtn.layer.cornerRadius = 30.0
        addBtn.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        view.addSubview(addBtn)

        
        
    }
    func setupGraph() {
        //一つ目グラフ
        monthlyView.usePercentValuesEnabled = true
        let values: [Double] = [23, 45, 10,66,78]
        let date : [Double] = [1,2,3,4,5]
        var entries: [ChartDataEntry] = Array()
        print(values.enumerated())
        for (i, value) in values.enumerated(){
            entries.append(ChartDataEntry(x: date[i], y: value, icon: UIImage(named: "icon", in: Bundle(for: self.classForCoder), compatibleWith: nil)))
            monthlyView.drawHoleEnabled = false
            print(value)
            print(date[i])
            
            let dataSet = PieChartDataSet(values: entries, label: "ラベル")
            
            dataSet.colors = ChartColorTemplates.vordiplom()
            
            
            let chartData = PieChartData(dataSet: dataSet)
            print("memo:ChartDate",chartData.dataSets)
             monthlyView.data = chartData
            
         
            
        }
    }
            //グラフ二つ目
        func setupGrapha2(){
            weeklyView.usePercentValuesEnabled = true
            let values: [Double] = [10, 50, 1, 1, 1]
            let date : [Double] = [1,2,3,4,5]
            var entries: [ChartDataEntry] = Array()
            for (i, value) in values.enumerated(){
                entries.append(ChartDataEntry(x: date[i], y: value, icon: UIImage(named: "icon", in: Bundle(for: self.classForCoder), compatibleWith: nil)))
                let dataSet = PieChartDataSet(values: entries, label: "ラベル")
                
                dataSet.colors = ChartColorTemplates.vordiplom()
                
                
                let chartData = PieChartData(dataSet: dataSet)
                print("memo:ChartDate",chartData.dataSets)
                weeklyView.data = chartData
               
            }
        }
                
                //グラフ三つ目
            func setupGraph3(){
                dailyView.usePercentValuesEnabled = true
                let values: [Double] = [0, 1, 80, 10, 10]
                let date : [Double] = [1,2,3,4,5]
                var entries: [ChartDataEntry] = Array()
                for (i, value) in values.enumerated(){
                    entries.append(ChartDataEntry(x: date[i], y: value, icon: UIImage(named: "icon", in: Bundle(for: self.classForCoder), compatibleWith: nil)))
                    print(value)
                    print(date[i])
                    let dataSet = PieChartDataSet(values: entries, label: "ラベル")
                    
                    dataSet.colors = ChartColorTemplates.vordiplom()
                    
                    
                    let chartData = PieChartData(dataSet: dataSet)
                    print("memo:ChartDate",chartData.dataSets)
                     dailyView.data = chartData
                    
            }
        }
    //画面遷移(目標登録ページ)
    @objc func onClick(_: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let SecondController = storyboard.instantiateViewController(withIdentifier: "Insert")
        present(SecondController, animated: true, completion: nil)
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
