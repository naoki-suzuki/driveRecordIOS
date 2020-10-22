//
//  folderCreateViewController.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/12.
//

import UIKit

class FolderCreateViewController : UIViewController, UITextFieldDelegate {
    //日付のTextField
    @IBOutlet weak var dateTravel: UITextField!
    //タイトル名のTextField
    @IBOutlet weak var travelTitle: UITextField!
    //メンバー名のTextField

    @IBOutlet weak var member1: UITextField!
    @IBOutlet weak var member2: UITextField!
    @IBOutlet weak var member3: UITextField!
    @IBOutlet weak var member4: UITextField!
    @IBOutlet weak var member5: UITextField!
    @IBOutlet weak var member6: UITextField!
    //現在の人数の表示
    @IBOutlet weak var countMember: UILabel!
    //メンバー数をカウントする変数の作成
    var count = 0
    //設定値を扱うキーを設定
    let settingKey = "member_value"
    //メンバーを格納する配列
    var memberArray = [String]()
    
    

        override func viewDidLoad() {
            super.viewDidLoad()
            //OSの変更
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            }
            dateTravel.inputView = datePicker
            
            //UserDefaultのインスタンス生成
            let setting = UserDefaults.standard
            //UserDefaultに初期値を設定
            setting.register(defaults: [settingKey:0])
            //キーボード処理を終了するための処理
            travelTitle.delegate = self
            member1.delegate = self
            member2.delegate = self
            member3.delegate = self
            member4.delegate = self
            member5.delegate = self
            member6.delegate = self
            
            displayUpdate()
        }
    
    //画面の更新をするメソッド（戻り値：currentCount:現在の人数）
    func displayUpdate()  {
        //現在の人数を生成
        var currentCount = 0
        //各TexeFieldが空か判定
        if member1 == nil {
            currentCount += 1
        }
        if member2 == nil {
            currentCount += 1
        }
        if member3 == nil {
            currentCount += 1
        }
        if member4 == nil {
            currentCount += 1
        }
        if member5 == nil {
            currentCount += 1
        }
        if member6 == nil {
            currentCount += 1
        }
        //現在の人数をラベルに表示
        countMember.text = "人数：\(currentCount)人"
        //return currentCount
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
     
            //label.text = textField.text
            // キーボードを閉じる
            textField.resignFirstResponder()
     
            return true
        }
     
    
    let datePicker: UIDatePicker = {
            
                let dp = UIDatePicker()
                dp.datePickerMode = UIDatePicker.Mode.date
                dp.timeZone = NSTimeZone.local
                dp.locale = Locale.current
                dp.addTarget(self, action: #selector(dateChange), for: .valueChanged)
                return dp
            }()
        @objc func dateChange(){
            
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd"
                dateTravel.text = "\(formatter.string(from: datePicker.date))"
            }

   

    @IBAction func Insert(_ sender: UIButton) {
        //各TextFieldから値を取得
        let dateTravelDate: String! = dateTravel.text
        let travelNameString:String! = travelTitle.text
        let travelMember1String:String! = member1.text
        let travelMember2String:String! = member2.text
        let travelMember3String:String! = member3.text
        let travelMember4String:String! = member4.text
        let travelMember5String:String! = member5.text
        let travelMember6String:String! = member6.text
        
    
        
    
    //データベース接続
        let helper = DatabaseHelper()
        let result = helper.inDatabase{(db) in
            let folder = Folderinfo(title: travelNameString, date: dateTravelDate, member1: travelMember1String, member2:travelMember2String,member3: travelMember3String,member4: travelMember4String,member5: travelMember5String,member6: travelMember6String)
            //登録処理
            try folder.insert(db)
        }
        if (!result) {
            print("失敗")
        } else {
            print("成功")
            print(dateTravelDate!)
            print(travelNameString!)
            print(travelMember1String!)
            print(result)
        }
}
   
    @IBAction func InsertHome(_ sender: UIButton) {
        //各TextFieldから値を取得
        let dateTravelDate: String! = dateTravel.text
        let travelNameString:String! = travelTitle.text
        let travelMember1String:String! = member1.text
        let travelMember2String:String! = member2.text
        let travelMember3String:String! = member3.text
        let travelMember4String:String! = member4.text
        let travelMember5String:String! = member5.text
        let travelMember6String:String! = member6.text
        
    
    //データベース接続
        let helper = DatabaseHelper()
        let result = helper.inDatabase{(db) in
            let folder = Folderinfo(title: travelNameString, date: dateTravelDate, member1: travelMember1String, member2:travelMember2String,member3: travelMember3String,member4: travelMember4String,member5: travelMember5String,member6: travelMember6String)
            try folder.insert(db)
        }
        if (!result) {
            print("失敗")
        } else {
            print("成功")
            print(dateTravelDate!)
            print(travelNameString!)
            print(travelMember1String!)
            print(travelMember6String!)
        }
        
    }
    
}
