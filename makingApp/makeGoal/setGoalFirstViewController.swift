//
//  setGoalFirstViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2019/01/06.
//  Copyright © 2019 Nanato Mizutani. All rights reserved.
//



import UIKit
import RealmSwift

let numberGoals = GoalFirstInfo()

class setGoalFirstViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
 
    
    
    //変数を宣言する
    //今日の日付を代入
    let nowDate = NSDate()
    let dateFormat = DateFormatter()
    let inputDatePicker = UIDatePicker()
    
    let w = UIScreen.main.bounds.size.width
    let h = UIScreen.main.bounds.size.height
    
    //スクロールビューのデータを入れるための変数
    var scrollView:UIScrollView!
    
    //スクリーンのサイズを入れる変数を宣言
    var screenWidth:CGFloat!
    var screenHeight:CGFloat!
    
    
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var goalLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var goalTextField:UITextField!
    @IBOutlet weak var dateSelecter: UITextField!
    @IBOutlet weak var goalDetailTextView: UITextView!
    
    @IBOutlet weak var goNextBtn: UIButton!
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalTextField.tag = 1
        dateSelecter.tag = 2
        goalDetailTextView.tag = 1
        
        goalTextField.delegate = self
        dateSelecter.delegate = self
        goalDetailTextView.delegate = self
        
        //goalDetailTextViewの話
        // 枠のカラー
        goalDetailTextView.layer.borderColor = UIColor.gray.cgColor
        
        // 枠の幅
        goalDetailTextView.layer.borderWidth = 1.0
        
        // 枠を角丸にする場合
        goalDetailTextView.layer.cornerRadius = 10.0
        goalDetailTextView.layer.masksToBounds = true
        
     ////DataPicker周りのこと
        //日付フィールドの設定
        dateFormat.dateFormat = "yyyy年MM月dd日"
        dateSelecter.text = dateFormat.string(from: nowDate as Date)
        self.dateSelecter.delegate = self
        goalDetailTextView.delegate = self
        
        
        // DatePickerの設定(日付用)
        inputDatePicker.datePickerMode = UIDatePicker.Mode.date
        dateSelecter.inputView = inputDatePicker
        
        // キーボードに表示するツールバーの表示
        let pickerToolBar = UIToolbar()
        pickerToolBar.frame =  CGRect(x:0, y:h/6, width:w, height:40.0)
        pickerToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        pickerToolBar.barStyle = .blackTranslucent
        pickerToolBar.tintColor = UIColor.white
        pickerToolBar.backgroundColor = UIColor.black
        
        //ボタンの設定
        //右寄せのためのスペース設定
        let spaceBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,target: self,action: Selector(""))
        
        //完了ボタンを設定
        let toolBarBtn      = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(toolBarBtnPush(_:)))
        
        //ツールバーにボタンを表示
        pickerToolBar.items = [spaceBarBtn,toolBarBtn]
        dateSelecter.inputAccessoryView = pickerToolBar
        
      
        //////////UIToolBarの設定////////////////////
        //キードードを閉じるボタンを作るためにツールバーを生成
        let toolBar = UIToolbar()
       
        //toolBarのサイズを設定
        toolBar.frame = CGRect(x: 0, y: 0, width: 300, height: 30)
        
        //画面幅に合わせるように設定
        toolBar.sizeToFit()
        
        //Doneボタンを右に配置するためのスペース
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
       
        //完了ボタン
        let doneButton      = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(setGoalFirstViewController.doneButton))
        //        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(setGoalFirstViewController.doneButton))
        
        //ツールバーにボタンを設定
        toolBar.items = [space,doneButton]
        
        
        
        
        
        //goalDetailTextViewにツールバーを設定
        goalDetailTextView.inputAccessoryView = toolBar
        //goalTextFieldに
//        goalTextField.inputAccessoryView = toolBar
        
        
    
        
//
        
       /////////キーボードにtextViewが隠れないようにするための処理///////////
        // UIScrollViewインスタンス生成
        scrollView = UIScrollView()
        
        //スクリーンのサイズ取得
        screenWidth = UIScreen.main.bounds.size.width
        screenHeight = UIScreen.main.bounds.size.height
        
        // UIScrollViewのサイズと位置を設定
        scrollView.frame = CGRect(x:0,y:0,width: screenWidth, height: screenHeight)
        
        //スクロールビューにtextFieldを追加する処理
        goalDetailTextView.backgroundColor = .white
        goalDetailTextView.frame = CGRect(x: 20, y: screenHeight - 100, width: screenWidth - 40, height: 40)
//        scrollView.addSubview(goalDetailTextView)
//
//
        
        
        // UIScrollViewのコンテンツのサイズを指定
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight  )
//        view.backgroundColor = UIColor(hex: "FF7257")
        
        ///goalLabel///
        goalLabel.frame.size = CGSize(width: 279, height:19 )
        goalLabel.center = CGPoint(x: screenWidth / 2, y: 216)
        ///goaltextField///
        goalTextField.frame.size = CGSize(width: 279, height: 36 )
        goalTextField.center = CGPoint(x: screenWidth / 2, y: 264)
        
        ///timeLabel///
        timeLabel.frame.size = CGSize(width: 279, height: 19)
        timeLabel.center = CGPoint(x: screenWidth / 2, y: 312)
       
        ///dataSelecter///
        dateSelecter.frame.size = CGSize(width: 243, height: 36)
        dateSelecter.center = CGPoint(x: screenWidth / 2, y: 372)
        
        ///detailLabel///
        detailLabel.frame.size = CGSize( width: 300, height: 19)
        detailLabel.center = CGPoint(x: screenWidth / 2 , y: 444)
        
       ////goalDetailTextView///
       // ラベルのサイズ
        goalDetailTextView.frame.size = CGSize(width: 264, height: 150)
         // ラベルのセンターの位置をスクリーン中央に設定
        goalDetailTextView.center = CGPoint(x: screenWidth / 2, y: 560)
       ///gonextbtn///
        goNextBtn.frame.size = CGSize(width: 36, height: 36)
        goNextBtn.center = CGPoint(x: screenWidth / 2, y: 670 )
        // ビューに追加

        scrollView.addSubview(goalTextField)
        scrollView.addSubview(dateSelecter)
        scrollView.addSubview(goNextBtn)
        scrollView.addSubview(goalLabel)
        scrollView.addSubview(timeLabel)
        scrollView.addSubview(detailLabel)
    scrollView.addSubview(goalDetailTextView)
     self.view.addSubview(scrollView)
        backGroundColor()
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
//        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillShow(notification:)),name:UIResponder.keyboardWillShowNotification,object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillHide(notification:)),name:UIResponder.keyboardWillHideNotification,object: nil)
        
        goalTextField.text = ""
        goalDetailTextView.text = ""
        
        numberGoals.readAll()
        if numberGoals.goalList.count ==  4 {
            limitedSetGoal()
        }else{
            
        }
        
    }
    //画面が消える時に呼ばれる
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,name:UIResponder.keyboardWillShowNotification,object: nil)
        NotificationCenter.default.removeObserver(self,name:UIResponder.keyboardWillHideNotification,object: nil)
        scrollView.setContentOffset(scrollView.contentOffset, animated: false)
    }

    
    
    //doneボタンを押した時の処理
    @objc func doneButton(){
        
        //キーボードを閉じる
        self.view.endEditing(true)
    }
    
    //完了を押すとピッカーの値を、テキストフィールドに挿入して、ピッカーを閉じる
    @objc func toolBarBtnPush(_ sender: UIBarButtonItem){
        
        let pickerDate = inputDatePicker.date
        dateSelecter.text = dateFormat.string(from: pickerDate)
        self.view.endEditing(true)
        
        //日付を出してます
        print(inputDatePicker.date)
        print(dateSelecter.text!)
        //    self.performSegue(withIdentifier: "mySegue", sender:nil)
    }
   
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
         NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillShow(notification:)),name:UIResponder.keyboardWillShowNotification,object: nil)
        return true
    }
    func textFieldDidEndEditing(_ textField:UITextField){
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillHide(notification:)),name:UIResponder.keyboardWillHideNotification,object: nil)
       
        
    }
    
    
    @IBAction func clsGoal(_ sender: Any) {
    }
    
    
    @IBAction func nextPageBtn(_ sender: UIButton) {
        if goalTextField.text == "" && goalDetailTextView.text == ""{
           alertGoal()
        }else if  goalTextField.text == "" || goalDetailTextView.text == ""{
            alertGoal()
        
        }else{
            self.performSegue(withIdentifier: "mySegue", sender:nil)
        
    }
    //        //DB書き込み
    //        print("データ書き込み開始")
    //
    //
    //
    //        try! realm.write {
    //            //ゴールの各内容が書き込まれる。
    //            let goalFirstInfo1 = GoalFirstInfo()
    //            goalFirstInfo1.goal = goalTextField.text!
    //            goalFirstInfo1.dueDay = dateSelecter.text!
    //            goalFirstInfo1.goalImageComment = goalDetailTextView.text!
    //            realm.add(goalFirstInfo1)
    //            print("データ書き込み中")
    //            print(goalFirstInfo1)
    //        }
    //
    //        print("データ書き込み完了")
    
    
    
    
    
    //Segueの初期化を通知するメソッドをオーバーライドする。senderにはperformSegue()で渡した値が入る。
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mySegue" {
            let nVC = segue.destination as! setGoalSecondViewController
            nVC.goal = goalTextField.text
            nVC.dueDate = dateSelecter.text
            nVC.goalDetail = goalDetailTextView.text
        }
    }
    func limitedSetGoal(){
       
            let alert = UIAlertController(title:"", message:"目標を設定できるのは４つまでです" ,
                                          preferredStyle: .alert)
            //OKボタンをアラートオブジェクトに追加
            //
            
        alert.addAction(UIAlertAction(title: "OK", style:.default, handler: {action in self.goMypage()} ))
    
            //handlerはOKボタンが押された時にしたい処理を書く
            //アラートを画面に表示する
            present(alert,animated: true)
            //presentで表示する
    }
func goMypage(){
    //まずは、同じstororyboard内であることをここで定義します
    let storyboard: UIStoryboard = self.storyboard!
    //ここで移動先のstoryboardを選択
    let second = storyboard.instantiateViewController(withIdentifier: "Home")
    //ここが実際に移動するコードとなります
    self.present(second, animated: true, completion: nil)
}
    
    func alertGoal(){
        if goalTextField.text == "" && goalDetailTextView.text == ""{
            let alert = UIAlertController(title:"記入漏れありますよ", message:"ゴールと将来のイメージを入力してください！" ,
                                          preferredStyle: .alert)
            //OKボタンをアラートオブジェクトに追加
            //
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            //handlerはOKボタンが押された時にしたい処理を書く
            //アラートを画面に表示する
            present(alert,animated: true)
            //presentで表示する
            
        }else if goalTextField.text == "" {
        //アラートオブジェクトを作る
        let alert = UIAlertController(title:"記入漏れありますよ", message:"ゴールを入力してください！" ,
                                      preferredStyle: .alert)
            //OKボタンをアラートオブジェクトに追加
            //
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            //handlerはOKボタンが押された時にしたい処理を書く
            //アラートを画面に表示する
            present(alert,animated: true)
            //presentで表示する
        }else if goalDetailTextView.text == ""{
            let alert = UIAlertController(title:"記入漏れありますよ", message:"将来のイメージはなんですか！" ,
                                          preferredStyle: .alert)
        
        //OKボタンをアラートオブジェクトに追加
        //
        
       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //handlerはOKボタンが押された時にしたい処理を書く
        //アラートを画面に表示する
        present(alert,animated: true)
        //presentで表示する
        
        
    }
    
 }
    
}

//キーボード関連の関数をまとめる。
extension setGoalFirstViewController{
    
    //キーボードが表示された時に呼ばれる
    @objc func keyboardWillShow(notification: NSNotification) {
        
        let insertHeight:CGFloat = 250
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + insertHeight)
        let offset = CGPoint(x: 0, y: insertHeight)
        scrollView.setContentOffset(offset, animated: true)
        print("スクリーンのサイズをキーボードの高さ分伸ばし伸ばした分動かす。")
    }
    //キーボードが閉じる時に呼ばれる
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight)
//        scrollView.setContentOffset(scrollView.contentOffset, animated: false)
        print("元の大きさへ")
}
    



}

extension setGoalFirstViewController{
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
