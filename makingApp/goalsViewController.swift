//
//  goalsViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2019/01/28.
//  Copyright © 2019 Nanato Mizutani. All rights reserved.
//

import UIKit
import RealmSwift



class goalsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var selectIndex = -1
    
    @IBOutlet weak var goalsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalInfo.readAll()
        recordInfo.readAll()
        goalsTableView.delegate = self
        goalsTableView.dataSource = self
        
        
    }
    
       
    

 

}

//テーブルビュー関連
extension goalsViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalInfo.goalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = UITableViewCell(style: .default, reuseIdentifier: "mycell")
        
        cell.textLabel!.text = goalInfo.goalList[indexPath.row]["goal"] as! String
        
        
        return cell
    }
    //選択された時に発動するメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //セルの選択解除
       goalsTableView.deselectRow(at: indexPath, animated: true)
        print("\(goalInfo.goalList[indexPath.row])を選択")
        //今選択された行番号を格納
        selectIndex = indexPath.row
        //ここに遷移処理を書く
        let storyboard: UIStoryboard = self.storyboard!
        
        let detailInformation = storyboard.instantiateViewController(withIdentifier: "myPage") as! myPageViewController
        
        detailInformation.selectaIndex = goalInfo.goalList[indexPath.row]["goal"] as! String
        
        self.present(detailInformation, animated: true, completion: nil)
        
        
    }
   
    //Mark: セルの編集ができるようにする。
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        goalInfo.deleteCell(goalFor: goalInfo.goalList[indexPath.row]["goal"] as! String )
        recordInfo.deleteRecord(goalFor:recordInfo.recordList[indexPath.row]["recordGoal"] as! String )
        
        print("goalInfo.goalList[indexPath.row][goal]",goalInfo.goalList[indexPath.row]["goal"]!)
        print("recordInfo.recordList[indexPath.row][recordGoal]",recordInfo.recordList[indexPath.row]["recordGoal"]!)

        goalInfo.goalList.remove(at: indexPath.row)
       
        
        print("row",indexPath.row)
        goalsTableView.deleteRows(at: [indexPath], with: .fade)
       print("indexPath.row" ,indexPath.row)
        
////        goalInfo.deleteCell(goalFor: goalInfo.goalList[indexPath.row] )
//        recordInfo.deleteRecord(goalFor:recordInfo.recordList[indexPath.row] )
//        print("recordInfo.recordList[indexPath.row]",recordInfo.recordList[indexPath.row])
    }
 
}



