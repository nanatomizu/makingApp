//
//  favoriteQuotationViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2018/12/23.
//  Copyright © 2018 Nanato Mizutani. All rights reserved.
//

import UIKit
import RealmSwift

let fav = FavoritesQuotation()

class favoriteQuotationViewController: UIViewController {
    var favList:[FavoritesQuotation] = []
    
    
    

    
    @IBOutlet weak var favoriteQuotationTableView: UITableView!
    
    override func  viewWillAppear(_ animated: Bool) {
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteQuotationTableView.delegate = self
        favoriteQuotationTableView.dataSource = self
         
        
   
        // TODO: todo一覧を取得する
        do{
            let realm = try Realm()
            //Todoに保存されているものを全て取得
            let results = realm.objects(FavoritesQuotation.self)
            //todoListに格納
            favList = []
            favList = Array(results)
            
            print("読み込んだよ", results)
        }catch{
            print("失敗したよ")
        }
        
        favoriteQuotationTableView.reloadData()
    }

    


}
extension favoriteQuotationViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return favList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "mycell")
      
        //ラベルの中身を表示
        cell.textLabel!.text =  favList[indexPath.row].favorites
       
        return cell
    }
    
    
}
