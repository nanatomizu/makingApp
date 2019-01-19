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
    
    

    
    @IBOutlet weak var goalLabel: UITextField!
    
    @IBOutlet weak var commentLabel: UITextField!
    
    @IBOutlet weak var rateLabel: UITextField!
    
    @IBOutlet weak var dayLabel: UITextField!
    
    @IBOutlet weak var calender: FSCalendar!
    
    var tableView :UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordInfo.readAll()
        // デリゲートの設定
       calender.delegate = self
        
    
        
        self.tableView = {
            let tableView = UITableView(frame: self.view.bounds, style: .plain)
          
            //tableViewサイズ
            tableView.frame.size = CGSize(width: 5 * screenWidth / 6
            , height:screenHeight / 2 )
            tableView.center = CGPoint(x: screenWidth / 2, y: 720 )
            
            tableView.delegate = self
            tableView.dataSource = self
            return tableView
            
        }()
        dayLabel.frame.size = CGSize(width: 72, height: 24)
        dayLabel.center = CGPoint(x: screenWidth / 2, y: 504)
        dayLabel.backgroundColor = .clear
        dayLabel.font = UIFont.systemFont(ofSize: 60.0)
        dayLabel.layer.borderColor = UIColor.gray.cgColor

        
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
        
        
        //予定がある場合、スケジュールをDBから取得・表示する。
        //無い場合、「スケジュールはありません」と表示
        
        goalLabel.text = "スケジュールはありません"
        goalLabel.textColor = .lightGray
        
        commentLabel.text = "スケジュールはありません"
        commentLabel.textColor = .lightGray
        
        rateLabel.text = "スケジュールはありません"
        rateLabel.textColor = .lightGray
        
        
        
        
        view.addSubview(dayLabel)
        view.addSubview(goalLabel)
        view.addSubview(commentLabel)
        view.addSubview(rateLabel)
        
        
        
        
        
        
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        let m = String(format: "%02d", month)
        let d = String(format: "%02d", day)
        
        //realmで登録しているキーと呼び出すときの型と書き方が一致していないとデータを取得できないよ
        let da = "\(year)年\(m)月\(d)日"
        
        print("ここから")
        print(m)
        print(d)
        print( "\(year)年\(m)月\(d)日")
        print("\(m)/\(d)")
        print("ここまで日付確認")
        
        //クリックしたら、日付が表示される。
        //        view.addSubview(tableView)
        dayLabel.text = "\(m)/\(d)"
        //        tableView.addSubview(dayLabel)
        
        //スケジュール取得
//        recordInfo.readByDay()
        recordInfo.recordList = []
        let realm = try! Realm()
        var result = realm.objects(RecordInfo.self)
        result = result.filter("dayRecord = '\(da)'")
        print(result)
        for ev in result {
                        let results = ["recordGoal": recordInfo.recordGoal,"recordComment":recordInfo.recordComment,"achieveRate":recordInfo.achieveRate] as NSDictionary
                        recordInfo.recordList.append(results)

                        print("これは")
                        print(recordInfo)
                        print(recordInfo.recordList)
                        print(results)
                        print(ev)
            print(ev.recordGoal)
                        print("これ")


                view.addSubview(tableView)
//                goalLabel.text = ev.recordGoal
        goalLabel.text = ev.recordGoal
        //                commentLabel.text = ev.recordComment
//                rateLabel.text = "\(String(ev.achieveRate))%"
                dayLabel.textColor = .black
                goalLabel.textColor = .black
                rateLabel.textColor = .black
                                 view.addSubview(dayLabel)
                //                view.addSubview(goalLabel)
                //                view.addSubview(rateLabel)
                //                view.addSubview(commentLabel)
           }
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
        
        cell.textLabel?.text = recordInfo.recordList[indexPath.row]["recordGoal"] as! String
       print(recordInfo.recordList[indexPath.row]["recordGoal"] as! String)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected! \(recordInfo.recordList[indexPath.row]["recordGoal"]!)")
        
    }
   
}
//TODO:データの受け渡し
//TODO:データを表示する　どの日に何をしたのかを色でわかるように
//TODO:データの受け取り
//TODO:次の画面　MyPageへと飛べるようにページの紐付け
//TODO:日付をタップしたらTableViewが現れ目標をを表示し詳細を見れるようにする
