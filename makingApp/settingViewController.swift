//
//  settingViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2018/12/19.
//  Copyright © 2018 Nanato Mizutani. All rights reserved.
//

import UIKit

class settingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var settingList = ["このアプリについて","ライセンス","通知設定"]
    var selectedIndex = -1
   
    

    
    @IBOutlet weak var settingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "mycell")
        
        //右側に矢印マークのアクセサリー
        cell.accessoryType = .disclosureIndicator
        //ラベルにSettingListの中身を表示
        cell.textLabel!.text =  settingList[indexPath.row]
        
        return cell
    }

    //選択された時に発動するメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(settingList[indexPath.row])を選択")
        //今選択された行番号を格納
        selectedIndex = indexPath.row
        //セグエの名前を指定して、移動
        performSegue(withIdentifier:"showSettingDetails", sender: nil)
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let scVC = segue.destination as! settingDetailsViewController
        scVC.selectedIndex = selectedIndex
    }
    
    
}


