//
//  calenderViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2018/12/19.
//  Copyright © 2018 Nanato Mizutani. All rights reserved.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic
import RealmSwift

let recordInfo = RecordInfo()

var screenWidth = UIScreen.main.bounds.size.width
var screenHeight = UIScreen.main.bounds.size.height

class calenderViewController: UIViewController,FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance,UITableViewDelegate,UITableViewDataSource{
    
   
    let dayLabel:UILabel = UILabel()
    var sections = [String]() // セクション名を格納しておく
    
    @IBOutlet weak var calender: FSCalendar!
    
    var tableView :UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        //アニメーションを他のページから戻ってきてもできるようにしてます
        tableView.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordInfo.readAll()
        // デリゲートの設定
       calender.delegate = self
        calender.frame.size = CGSize(width: screenWidth
            , height:  screenHeight / 2 - 10 )
        calender.center = CGPoint(x: screenWidth / 2, y: 290 )
        
        
        backGroundColor()
    
        
        self.tableView = {
            let tableView = UITableView(frame: self.view.bounds, style: .plain)
          
            //tableViewサイズ
            tableView.frame.size = CGSize(width: 5 * screenWidth / 6
            , height:screenHeight / 4 )
            tableView.center = CGPoint(x: screenWidth / 2, y: 600 )
            
           
            
            tableView.delegate = self
            tableView.dataSource = self
            return tableView
            
        }()
        //tableViewスクロールさせない
        tableView.isScrollEnabled = false
        //tableViewの背景色透明　cell間の線の削除
        tableView.backgroundColor = UIColor.clear
//        tableView.layer.borderColor = UIColor.lightGray.cgColor
//        tableView.layer.borderWidth = 1
//        tableView.tableFooterView = UIView()
        
        
        //labelの配置
        let dayLabel:UILabel = UILabel()
        dayLabel.frame.size = CGSize(width: 72, height: 24)
        dayLabel.center = CGPoint(x: screenWidth / 2, y: 504)
        dayLabel.backgroundColor = .white
//        dayLabel.font = UIFont.systemFont(ofSize: 60.0)
        dayLabel.textColor = .black
        dayLabel.layer.borderColor = UIColor.blue.cgColor
      
    
//        view.addSubview(dayLabel)
        
        
    }
    
   
    
    
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年-MM月-dd日"
        return formatter
    }()
    
    // 祝日判定を行い結果を返すメソッド(True:祝日)
    func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)
        
        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    // date型 -> 年月日をIntで取得
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year,month,day)
    }
    
    //曜日判定(日曜日:1 〜 土曜日:7)
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }
    
    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //祝日判定をする（祝日は赤色で表示する）
        if self.judgeHoliday(date){
            return UIColor.red
        }
        
        //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {   //日曜日
            return UIColor.red
        }
        else if weekday == 7 {  //土曜日
            return UIColor.blue
        }
        
        return nil
        
    }
    
    //カレンダー処理(スケジュール表示処理)
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition)
    {
       
//        if recordInfo.recordGoal == ""{
//        //予定がある場合、スケジュールをDBから取得・表示する。
//        //無い場合、「スケジュールはありません」と表示
//        let goalLabel:UILabel = UILabel()
//        goalLabel.text = "A"
//        goalLabel.textColor = .lightGray
//        goalLabel.frame = CGRect(x: 20, y: 600, width: screenWidth / 2, height: 24)
//        view.addSubview(goalLabel)
//
//        let commenttextField:UITextField = UITextField()
//        commenttextField.text = "B"
//        commenttextField.textColor = .lightGray
//        goalLabel.frame = CGRect(x: 48, y: 648, width: screenWidth / 2, height: 36)
//        view.addSubview(commenttextField)
//
//        let rateLabel:UILabel = UILabel()
//        rateLabel.text = "C"
//        rateLabel.textColor = .lightGray
//        rateLabel.textColor = .lightGray
//        rateLabel.frame = CGRect(x: 48, y: 708, width: screenWidth / 2, height: 24)
//        view.addSubview(rateLabel)
        
        
//        }else{
        
////        view.addSubview(dayLabel)
//        view.addSubview(goalLabel)
//        view.addSubview(commentLabel)
//        view.addSubview(rateLabel)
//
        
        
        
        
        
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        let m = String(format: "%02d", month)
        let d = String(format: "%02d", day)
        
        
        //realmで登録しているキーと呼び出すときの型と書き方が一致していないとデータを取得できないよ
        let da = "\(year)年\(m)月\(d)日"
        
        dayLabel.text = "\(m)/\(d)"
//        print("ここから")
//        print(m)
//        print(d)
//        print( "\(year)年\(m)月\(d)日")
//        print("\(m)/\(d)")
//        print("ここまで日付確認")
        
        //クリックしたら、日付が表示される。
        //        view.addSubview(tableView)
        
        recordInfo.readByDay(da:da)
        print("recordInfo.recordList:::::::::\(recordInfo.recordList)")

        //tableVIewの表示の際にアニメーション追加してます
        tableView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn], animations: {
            self.tableView.alpha = 1.0
        }, completion: nil)
        
                view.addSubview(tableView)
        print("recordInfo.recordGoal:\(recordInfo.recordGoal)")
        tableView.reloadData()

          }
    
    



    @IBAction func btnDelete(_ sender: Any) {
        recordInfo.deleteAll()
    }
    
}

extension calenderViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordInfo.recordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.backgroundColor = UIColor.clear
      
        
        cell.textLabel?.text = recordInfo.recordList[indexPath.row]["recordGoal"] as! String
       print(recordInfo.recordList[indexPath.row]["recordGoal"] as! String)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //セルの選択解除
        tableView.deselectRow(at: indexPath, animated: true)
        //ここに遷移処理を書く
        let storyboard: UIStoryboard = self.storyboard!
        
        let detailInformation = storyboard.instantiateViewController(withIdentifier: "ShowResult") as! showResultViewController
        
        detailInformation.goaaaaaaal = recordInfo.recordList[indexPath.row]["recordGoal"] as! String
        detailInformation.raaaaaaate = recordInfo.recordList[indexPath.row]["achieveRate"] as! Int
        detailInformation.commmmment = recordInfo.recordList[indexPath.row]["recordComment"] as! String
        detailInformation.daaaaaaaay = dayLabel.text!
        
        
        
        self.present(detailInformation, animated: true, completion: nil)

        
        print("Selected! \(recordInfo.recordList[indexPath.row]["recordGoal"]!)")
        
    }
    // Section数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Sectioのタイトル
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
       
        return dayLabel.text
    }
//    TODO:セクションの色を変えよう
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:UIView = UIView()
//        let label:UILabel = UILabel()
         let label = UILabel(frame: CGRect(x:0, y:0, width: tableView.bounds.width, height: 30))
        headerView.backgroundColor = UIColor.white
      
        label.textColor = UIColor.lightGray
        label.text = dayLabel.text
        label.textAlignment = .center
        headerView.addSubview(label)
        return headerView
    }
   
    
//
    // Section Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // ヘッダーViewの高さを返す
        return 30
    }

    
   
}
extension calenderViewController{
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

    







//TODO:データの受け渡し
//TODO:データを表示する　どの日に何をしたのかを色でわかるように
//TODO:データの受け取り
//TODO:次の画面　MyPageへと飛べるようにページの紐付け
//TODO:日付をタップしたらTableViewが現れ目標をを表示し詳細を見れるようにする
