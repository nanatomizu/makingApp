//
//  quotationViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2018/12/19.
//  Copyright © 2018 Nanato Mizutani. All rights reserved.
//

//TODO:名言を配列に追加すること
//TODO:配列内のデータをランダムに表示をさせる方法をググる
//TODO:お気に入りボタンを作る
//TODO:お気に入りした名言のデータをお気に入りリストへと飛ばすコードを書く
//TODO:オートレイアウトを設定しなすべき

import UIKit
import RealmSwift

//let quote = Meigen()

class quotationViewController: UIViewController {
 
    let realm = try! Realm()
    
//    var quotations = ["壁というのはできる人にしかやってこない。超えられる可能性がある人にしかやってこない。だから、壁がある時はチャンスだと思っている。                                         - イチロー -","努力せずに何かできるようになる人のことを 「天才」というのなら、僕はそうじゃない。努力した結果、何かができるようになる人のことを「天才」というのなら、僕はそうだと思う。人が僕のことを、努力もせずに打てるんだと思うなら、それは間違いです。　　　　      　  　                      　　　　　　　　　　　　　　　　　　　　　　　　　                                イチロー  "
//    ]
//
    
    @IBOutlet weak var quoteTextView: UITextView!
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//      quote.readAll()
      
    }
    
   
    
    
    @IBAction func tapBtnquote(_ sender: Any) {
       
      showWords()
    }
    
    func showWords(){
        //占いの結果をランダムに選ぶための数字を作成
//    let randomNumber = Int(arc4random()) %  quote.meigens.count //.countはomikujiResultの要素数
//         print(randomNumber)
        
//        quoteTextView.text = quote.meigens[randomNumber]
    }
    
    @IBAction func favoriteBtn(_ sender: UIButton) {
       
//        //DB書き込み処理
//        print("データ書き込み開始")
//
//        try! realm.write {
//            let favoritesQuotation1 = FavoritesQuotation()
//            favoritesQuotation1.favorites =
//                quotations[randomNumber]
//
//            realm.add(favoritesQuotation1)
//            print("データ書き込み中")
//            print(favoritesQuotation1)
//
//        }
//
//        print("データ書き込み中")
//    }
    
   

}
}
