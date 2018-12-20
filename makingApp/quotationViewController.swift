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

class quotationViewController: UIViewController {

//    var Quotations =
    
    @IBOutlet weak var quoteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapBtnquote(_ sender: Any) {
        quoteTextView.text = "私の辞書に不可能という文字はない"
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
