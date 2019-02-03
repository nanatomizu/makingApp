//
//  goalsViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2019/01/28.
//  Copyright © 2019 Nanato Mizutani. All rights reserved.
//

import UIKit
import RealmSwift

//TODO:countで値の数をとってgoalList > recordList goalListのみ削除

class goalsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var selectIndex = -1
    
    @IBOutlet weak var goalsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalInfo.readAll()
        goalsTableView.delegate = self
        goalsTableView.dataSource = self
        goalsTableView.reloadData()
        
    }
    
       
    

 

}

//テーブルビュー関連
extension goalsViewController{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
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
        print(selectIndex)
        
        recordInfo.readGaph(goal:goalInfo.goalList[selectIndex]["goal"] as! String )
        if recordInfo.recordList == [] {
            alerthome()
        }else{
        //ここに遷移処理を書く
        let storyboard: UIStoryboard = self.storyboard!
        
        let detailInformation = storyboard.instantiateViewController(withIdentifier: "myPage") as! myPageViewController
        detailInformation.selectaIndex = selectIndex
            
        self.present(detailInformation, animated: true, completion: nil)
            
        }
        
    }
   
    //Mark: セルの編集ができるようにする。
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        //TODO:if文が組めないゴールだけしか記録されていないときはどう書けばいいのか。
        goalInfo.readByGoal(goal:goalInfo.goalList[indexPath.row]["goal"] as! String )
        print("goalInfo.goalList",goalInfo.goalList)
        print("indexPath.row",indexPath.row)
            recordInfo.readGoal(goal:goalInfo.goalList[0]["goal"] as! String )
        print("indexPath.row",indexPath.row)
        print("recordInfo.recordList",recordInfo.recordList)
        if recordInfo.recordList == []
    {
        
//セルがスライドで消された時とDBからそれを消す処理
        goalInfo.deleteCell(goalFor: goalInfo.goalList[0]["goal"] as! String )
//        recordInfo.deleteRecord(goalFor:recordInfo.recordList[indexPath.row]["recordGoal"] as! String )
//        self.goalsTableView.reloadData()

        
        }else{
            goalInfo.deleteCell(goalFor: goalInfo.goalList[0]["goal"] as! String )
 recordInfo.deleteRecord(goalFor:recordInfo.recordList[0]["recordGoal"] as! String )
            print("goalInfo.goalList",goalInfo.goalList)
            print("recordInfo.recordList",recordInfo.recordList)

        }

        
//        goalInfo.goalList.remove(at: indexPath.row)
       
      
        goalInfo.readAll()
        [self.goalsTableView.reloadData];
        print("row",indexPath.row)
        goalsTableView.deleteRows(at: [indexPath], with: .fade)
       print("indexPath.row" ,indexPath.row)
       
////        goalInfo.deleteCell(goalFor: goalInfo.goalList[indexPath.row] )
//        recordInfo.deleteRecord(goalFor:recordInfo.recordList[indexPath.row] )
//        print("recordInfo.recordList[indexPath.row]",recordInfo.recordList[indexPath.row])
    }
    func alerthome(){
        
        let alert = UIAlertController(title:"", message:"先に記録をつけてください" ,
                                      preferredStyle: .alert)
        //OKボタンをアラートオブジェクトに追加
        //
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in self.goHomePage() }))
        //handlerはOKボタンが押された時にしたい処理を書く
        //アラートを画面に表示する
        present(alert,animated: true)
        //presentで表示する
    }
    func goHomePage(){
        //まずは、同じstororyboard内であることをここで定義します
        let storyboard: UIStoryboard = self.storyboard!
        //ここで移動先のstoryboardを選択
        let second = storyboard.instantiateViewController(withIdentifier: "Home")
        //ここが実際に移動するコードとなります
        self.present(second, animated: true, completion: nil)
    }

 
}



