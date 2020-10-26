//
//  folderCreateViewController.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/12.
//

import UIKit
import GRDB

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
    //新規作成したフォルダのIDを送信する値の変数の作成
    var sendId:Int64? = 0
    
    //入力時の処理
    
    @IBAction func mem1(_ sender: Any) {
        if let text = member1.text, !text.isEmpty {
           count += 1
        } else {
            count -= 1
        }
        countMember.text = "人数：\(count)人"
        
    }
    
    @IBAction func mem2(_ sender: Any) {
        if let text = member2.text, !text.isEmpty {
           count += 1
        } else {
            count -= 1
        }
        countMember.text = "人数：\(count)人"
    }
   
    @IBAction func mem3(_ sender: Any) {
        if let text = member3.text, !text.isEmpty {
           count += 1
        } else {
            count -= 1
        }
        countMember.text = "人数：\(count)人"
    }
    
    @IBAction func mem4(_ sender: Any) {
        if let text = member4.text, !text.isEmpty {
           count += 1
        } else {
            count -= 1
        }
        countMember.text = "人数：\(count)人"
    }
    
    @IBAction func mem5(_ sender: Any) {
        if let text = member5.text, !text.isEmpty {
           count += 1
        } else {
            count -= 1
        }
        countMember.text = "人数：\(count)人"
    }
    
    @IBAction func mem6(_ sender: Any) {
        if let text = member6.text, !text.isEmpty {
           count += 1
        } else {
            count -= 1
        }
        countMember.text = "人数：\(count)人"
    }
    
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            //OSの変更
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            }
            dateTravel.inputView = datePicker
            
            //UserDefaultのインスタンス生成
            //let setting = UserDefaults.standard
            //UserDefaultに初期値を設定
            //setting.register(defaults: [settingKey:0])
            //キーボード処理を終了するための処理
            travelTitle.delegate = self
            member1.delegate = self
            member2.delegate = self
            member3.delegate = self
            member4.delegate = self
            member5.delegate = self
            member6.delegate = self
            
            //displayUpdate()
        }
        
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
     
            //label.text = textField.text
            // キーボードを閉じる
            textField.resignFirstResponder()
            //キーボード処理終了時に、カウントを行う
            //displayUpdate()
     
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

   
    //金額入力ボタン押下後
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
        
        if  dateTravelDate.isEmpty {
            let alert = UIAlertController(title: "エラー",
                                          message: "日付を選択してください",
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else if travelNameString.isEmpty {
            let alert = UIAlertController(title: "エラー",
                                          message: "タイトルを入力してください",
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else if travelMember1String.isEmpty {
            let alert = UIAlertController(title: "エラー",
                                          message: "メンバー名を入力してください",
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        
        } else {
            //データベース接続
            //let helper = DatabaseHelper()
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
                
                var entity: Folderinfo?
                
                let result2 = helper.inDatabase { (db) in
                    //登録した情報を取得
                    entity = try Folderinfo.filter(Folderinfo.Columns.title == travelNameString).fetchOne(db)
                }
                //新規登録出来たか判定
                if (!result2) {
                    print("失敗")
                } else {
                    print(entity?.folderid! as Any)
                    print(entity?.title as Any)
                    sendId = entity?.folderid
                    //取得した数字格納ずみを判定
                    print(sendId!)
                    //Segueの実行
                    performSegue(withIdentifier: "moneyView", sender: nil)
                    
                  
                    /*storyboardのインスタンス取得
                    let storyboard: UIStoryboard = self.storyboard!
                    //遷移先のインスタンスを取得
                    let nextView = storyboard.instantiateViewController(withIdentifier: "moneyView") as! MoneyInsertViewController
                    //値の設定
                    nextView.receiveId = sendId!
                    //画面遷移
                    self.present(nextView, animated: true, completion: nil)*/
                    
                }
            }
        
        }
}
    //Segue実行前の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Segueの識別子確認
        if segue.identifier == "moneyView" {
            //遷移先のViewControllerの取得
            let nc = segue.destination as! UINavigationController
            let nextView = nc.topViewController as! MoneyInsertViewController
            
            
            //値の設定
            nextView.receiveId = sendId!
        }
    }
   //作成完了ボタン押下時の処理
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
        
        //未入力チェック
        if  dateTravelDate.isEmpty {
            let alert = UIAlertController(title: "エラー",
                                          message: "日付を選択してください",
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else if travelNameString.isEmpty {
            let alert = UIAlertController(title: "エラー",
                                          message: "タイトルを入力してください",
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else if travelMember1String.isEmpty {
            let alert = UIAlertController(title: "エラー",
                                          message: "メンバー名を入力してください",
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        
        } else {
    
            //データベース接続
            let helper = DatabaseHelper()
            let result = helper.inDatabase{(db) in
            let folder = Folderinfo(title: travelNameString, date: dateTravelDate, member1: travelMember1String, member2:travelMember2String,member3: travelMember3String,member4: travelMember4String,member5: travelMember5String,member6: travelMember6String)
                //登録処理
                try folder.insert(db)
            }
            //確認のための記述
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
}
