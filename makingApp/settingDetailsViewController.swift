//
//  settingDetailsViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2018/12/19.
//  Copyright © 2018 Nanato Mizutani. All rights reserved.
//

import UIKit

class settingDetailsViewController: UIViewController {
    
//    TODO:settingList内の説明を配列組んで書く
    
     var settingList = ["このアプリについて","ライセンス","通知設定"]
    var detailsetting = ["このアプリは三日坊主に悩むあなた、目標に向かって頑張りたいあなたのためのアプリです。","seven.license","通知を受け取るor受け取らない"]
    
    @IBOutlet weak var settingDetailsTextView: UITextView!
    var selectedIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        //前の画面で選択された行番号を表示
        print("選択された行番号：\(selectedIndex)")
        
        settingDetailsTextView.text =
            detailsetting[selectedIndex]
        
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
