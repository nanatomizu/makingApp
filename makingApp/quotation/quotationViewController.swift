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



class quotationViewController: UIViewController {
 

     let realm = try! Realm()
    
    var quotations = ["壁というのはできる人にしかやってこない。超えられる可能性がある人にしかやってこない。だから、壁がある時はチャンスだと思っている。                                         - イチロー -","努力せずに何かできるようになる人のことを 「天才」というのなら、僕はそうじゃない。努力した結果、何かができるようになる人のことを「天才」というのなら、僕はそうだと思う。人が僕のことを、努力もせずに打てるんだと思うなら、それは間違いです。　　　　      　  　                      　　　　　　　　　　　　　　　　　　　　　　　　　                                イチロー  ","振り向くな、振り向くな、後ろには夢がない　　　　　　　　　　坂本龍馬","一番難しいのは行動しようと腹をくくること。あとはただ粘り強さの問題だ。   アメリア・イアハート"
    ]

    
    @IBOutlet weak var quoteTextView: UITextView!
    
  
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     showWords()
       
        backGroundColor()
        //textviewの背景透明にしてます
       quoteTextView.backgroundColor = UIColor.clear
    }
    
   
    
    
    @IBAction func tapBtnquote(_ sender: Any) {
       
      showWords()
    }
    
    func showWords(){
       // 占いの結果をランダムに選ぶための数字を作成
    let randomNumber = Int(arc4random()) %  quotations.count //.countはomikujiResultの要素数
         print(randomNumber)
        
        quoteTextView.text = quotations[randomNumber]
    }
    //お気に入りボタン
    @IBAction func favoriteBtn(_ sender: UIButton) {
       
        //DB書き込み処理
        print("データ書き込み開始")
        
        
        
        try! realm.write {
            
            //ゴールの各内容が書き込まれる。
            let favoritesQuotation = FavoritesQuotation()
          favoritesQuotation.favorites = quoteTextView.text
            
            realm.add(favoritesQuotation)
            print("データ書き込み中")
            print(favoritesQuotation)
        }
        
        print("データ書き込み完了")
        
}
    
    //共有ボタン
    @IBAction func shareSnsBtn(_ sender: UIButton) {
      shareSNS()
    }
    
    func shareSNS() {
        //シェアしたい情報が格納されている配列を用意する（Any型の配列）
        //as [Any]はAny型の配列としてダウンキャスト変換するという意味
        let shareInfo = [quoteTextView!.text] as! [Any]
        
        
        //アクティビティビュー（シェアするSNSを選べる）のインスタンスを作成
        let controller = UIActivityViewController(activityItems: shareInfo, applicationActivities: nil)
        
        //作成したアクティビティビューを表示
        //controllerは上のletで指定したもの
        present(controller, animated: true)
    }
    
    
    @IBAction func deleteQuote(_ sender: Any) {
        fav.deleteAll()
    }
    
   
}

extension quotationViewController{
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

