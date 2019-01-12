//
//  homeViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2019/01/12.
//  Copyright © 2019 Nanato Mizutani. All rights reserved.
//

import UIKit
import RealmSwift

let a = GoalFirstInfo()
let b = DayMonthTimeInfo()



class homeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    

    @IBOutlet weak var showTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        a.readAll()
        b.readAll()
        showTableView.delegate = self
        showTableView.dataSource = self
        

        // Do any additional setup after loading the view.
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

extension homeViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return a.goalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //セルを取得
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        // セルに表示する値を設定する
        cell.textLabel?.text = a.goalList[indexPath.row]["goal"] as! String
        cell.detailTextLabel?.text = b.goalListMonthdayTime[indexPath.row]["dailyGoal"] as! String
        
        return cell
    }
    
   
}
