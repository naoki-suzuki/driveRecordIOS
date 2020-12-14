//
//  folderCreateViewController.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/12.
//  Update by 大越悠司　on 2020/11/4
//

import UIKit
import GRDB

class FolderCreateViewController : UIViewController, UITextFieldDelegate {
    
    //日付のTextField
    @IBOutlet private weak var dateTravel: UITextField!
    //タイトル名のTextField
    @IBOutlet private weak var travelTitle: UITextField!
    //メンバー名のTextField
    @IBOutlet private weak var member1: UITextField!
    @IBOutlet private weak var member2: UITextField!
    @IBOutlet private weak var member3: UITextField!
    @IBOutlet private weak var member4: UITextField!
    @IBOutlet private weak var member5: UITextField!
    @IBOutlet private weak var member6: UITextField!
    
    // 現在の人数の表示
    @IBOutlet private weak var countMember: UILabel!
    // メンバー数をカウントする変数の作成
    private var count = 0
    // 新規作成したフォルダのIDを送信する値の変数の作成
    private var sendId:Int64? = 0
    // 遷移先のStoryboardIdを格納する変数
    private let segName = "moneyView"
    
    // 人数をカウントするメソッド
    func memberCount(member1:UITextField,member2:UITextField,member3:UITextField,member4:UITextField,member5:UITextField,member6:UITextField ) {
        let s : [UITextField] = [ member1,member2,member3,member4,member5,member6]
        var count = 0
        for i in s {
            if let member = i.text, !member.isEmpty {
                count += 1
            }
        }
        countMember.text = "人数：\(count)人"
    }
    // 文字数をカウントするメソッド
    func letterCount(nameString:UITextField) -> Bool {
        let name = nameString.text!
        // 入力された文字が10字以上か判定し、trueの場合アラート表示
        if name.count > 10 {
            let alert = UIAlertController(title: "エラー",
                                          message: "10文字以内で入力してください",
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
            return false
        }
        return true
    }
    //入力時の処理
    @IBAction func checkTitle(_ sender: Any) {
        // if文を満たすと、入力された中身が削除される
        if !letterCount(nameString: travelTitle) {
            travelTitle.text = ""
        }
    }
    
    // 入力文字数と人数カウントの処理
    @IBAction func mem1(_ sender: Any) {
        // 入力文字数チェック
        if !letterCount(nameString: member1) {
            member1.text = ""
        }
        memberCount(member1: member1, member2: member2, member3: member3, member4: member4, member5: member5, member6: member6)
        
    }
    
    // 入力文字数と人数カウントの処理
    @IBAction func mem2(_ sender: Any) {
        // 入力文字数チェック
        if !letterCount(nameString: member2) {
            member2.text = ""
        }
        memberCount(member1: member1, member2: member2, member3: member3, member4: member4, member5: member5, member6: member6)
    }
    
    // 入力文字数と人数カウントの処理
    @IBAction func mem3(_ sender: Any) {
        // 入力文字数チェック
        if !letterCount(nameString: member3) {
            member3.text = ""
        }
        memberCount(member1: member1, member2: member2, member3: member3, member4: member4, member5: member5, member6: member6)
    }
    
    // 入力文字数と人数カウントの処理
    @IBAction func mem4(_ sender: Any) {
        // 入力文字数チェック
        if !letterCount(nameString: member4) {
            member4.text = ""
        }
        memberCount(member1: member1, member2: member2, member3: member3, member4: member4, member5: member5, member6: member6)
    }
    
    // 入力文字数と人数カウントの処理
    @IBAction func mem5(_ sender: Any) {
        // 入力文字数チェック
        if !letterCount(nameString: member5) {
            member5.text = ""
        }
        memberCount(member1: member1, member2: member2, member3: member3, member4: member4, member5: member5, member6: member6)
    }
    
    // 入力文字数と人数カウントの処理
    @IBAction func mem6(_ sender: Any) {
        // 入力文字数チェック
        if !letterCount(nameString: member6) {
            member6.text = ""
        }
        memberCount(member1: member1, member2: member2, member3: member3, member4: member4, member5: member5, member6: member6)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Tabバーの色の指定
        UINavigationBar.appearance().barTintColor = UIColor.systemTeal
        //OSの変更
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        dateTravel.inputView = datePicker
        
        // ツールバー生成 サイズはsizeToFitメソッドで自動で調整される。
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

        //サイズの自動調整。敢えて手動で実装したい場合はCGRectに記述してsizeToFitは呼び出さない。
        toolBar.sizeToFit()

        // 左側のBarButtonItemはflexibleSpace。これがないと右に寄らない。
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        // Doneボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(commitButtonTapped))
        // BarButtonItemの配置
        toolBar.items = [spacer, commitButton]
        // textViewのキーボードにツールバーを設定
        dateTravel.inputAccessoryView = toolBar
        travelTitle.returnKeyType = UIReturnKeyType.done
        member1.returnKeyType = UIReturnKeyType.done
        member2.returnKeyType = UIReturnKeyType.done
        member3.returnKeyType = UIReturnKeyType.done
        member4.returnKeyType = UIReturnKeyType.done
        member5.returnKeyType = UIReturnKeyType.done
        member6.returnKeyType = UIReturnKeyType.done
        
        //キーボード処理を終了するための処理
        travelTitle.delegate = self
        member1.delegate = self
        member2.delegate = self
        member3.delegate = self
        member4.delegate = self
        member5.delegate = self
        member6.delegate = self
        
    }
    // 完了ボタン押下後の処理
    @objc func commitButtonTapped() {
        self.view.endEditing(true)
    }
    
    // キーボードを閉じる処理
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
    
    // 日付の表示方法の変換
    @objc func dateChange(){
        
        let formatter = DateFormatter()
        // 年月日を表示する様に設定
        formatter.dateFormat = "YYYY/MM/dd"
        dateTravel.text = "\(formatter.string(from: datePicker.date))"
    }
    
    // 戻るボタン押下時の処理
    @IBAction func returnHome(_ sender: Any) {
        let alert: UIAlertController = UIAlertController( title: "", message: "登録せずにホーム画面に戻りますか？", preferredStyle:  UIAlertController.Style.alert)
       
        // OKボタン(ホームに遷移)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.performSegue(withIdentifier: "home", sender: nil)
                // storyboardのインスタンス取得
                 let storyboard3: UIStoryboard = self.storyboard!
                 
                 // 遷移先ViewControllerのインスタンス取得
                 let nextView3 = storyboard3.instantiateViewController(withIdentifier: "home")
                //コードでフルスクリーン表示を指定
                 nextView3.modalPresentationStyle = .fullScreen
                 
                 // 画面遷移
                 self.present(nextView3, animated: true, completion: nil)
                 }
            }
        
        )
        // キャンセルボタン
        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.default)
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    
    }
    
    //　金額入力ボタン押下後
    @IBAction func Insert(_ sender: UIButton) {
        
        //どちらのボタンからの処理かを識別するための数字
        let num = 1
        //メソッド呼び出し
        let result = insert(dateTravel: dateTravel, travelName: travelTitle, member1: member1, member2: member2, member3: member3, member4: member4, member5: member5, member6: member6,num: num)
        if result {
           print("成功")
        } else {
         print("エラー取得")
        }
       
    }
    //　Segue実行前の処理
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
    // 作成完了ボタン押下時の処理
    @IBAction func InsertHome(_ sender: UIButton) {
        //どちらのボタンからの処理かを識別するための数字
        let num = 0
        //メソッド呼び出し
        let result = insert(dateTravel: dateTravel, travelName: travelTitle, member1: member1, member2: member2, member3: member3, member4: member4, member5: member5, member6: member6,num: num)
        if result {
           print("成功")
        } else {
         print("エラー取得")
        }
    }
    
    // TextFieldの値を受け取り、入力チェック及び、フォルダ作成処理を行うメソッド
    func insert (dateTravel:UITextField!,travelName:UITextField!,member1:UITextField!,member2:UITextField!,member3:UITextField!,member4:UITextField!,member5:UITextField!,member6:UITextField!,num:Int!) -> Bool {
        //引数の値を格納
        let dateTravelName: String = dateTravel.text!
        let travelName: String = travelName.text!
        let travelMember1: String = member1.text!
        let travelMember2: String! = member2.text!
        let travelMember3: String! = member3.text!
        let travelMember4: String! = member4.text!
        let travelMember5: String! = member5.text!
        let travelMember6: String! = member6.text!
        
        
        // 未入力チェック
        // 日付判定
        if  dateTravelName.isEmpty {
            let alert = UIAlertController(title: "エラー",
                                          message: "日付を選択してください",
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        // タイトル名未入力チェック
        } else if travelName.isEmpty {
            let alert = UIAlertController(title: "エラー",
                                          message: "タイトルを入力してください",
                                          preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
            // メンバーが一人でも入力されているかチェック
        } else if travelMember1.isEmpty {
            if travelMember2.isEmpty && travelMember3.isEmpty && travelMember4.isEmpty && travelMember5.isEmpty && travelMember6.isEmpty  {
                let alert = UIAlertController(title: "エラー",
                                              message: "メンバー名を入力してください",
                                              preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return false
            } else {
                let alert = UIAlertController(title: "エラー",
                                              message: "一番上からメンバー名を入力してください",
                                              preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return false
            }
        } else {
            
            // データベース接続
            let helper = DatabaseHelper()
            let result = helper.inDatabase{(db) in
                // 登録内容を格納
                let folder = Folderinfo(title: travelName, date: dateTravelName, member1: travelMember1, member2: travelMember2, member3: travelMember3, member4: travelMember4, member5: travelMember5, member6: travelMember6)
                // 登録処理
                try folder.insert(db)
                
            }
            // 結果がtrue且、遷移先の識別番号によって判定
            if result && num == 1 {
                var entity: Folderinfo?
                
                let result2 = helper.inDatabase { (db) in
                    // 登録した情報を取得
                    // 登録名が重複すると若い番号が取得される
                    // entity = try Folderinfo.filter(Folderinfo.Columns.title == travelNameString).fetchOne(db)
                    entity = try Folderinfo.filter(Folderinfo.Columns.title == travelName).filter(Folderinfo.Columns.date == dateTravelName).filter(Folderinfo.Columns.member1 == travelMember1).fetchOne(db)
                }
                
                if result2 {
                    print(entity?.folderid! as Any)
                    //print(entity?.title as Any)
                    sendId = entity?.folderid
                    // 取得した数字格納ずみを判定
                    print(sendId!)
                    // Segueの実行
                    performSegue(withIdentifier: segName, sender: nil)
                    
                }
                return true
            } else if result {
                print(num!)
                return true
            } else {
                return false
            }
            
        }
        
    }
}
