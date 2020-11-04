//
//  moneyInsertViewController.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/12.
//  Update by 大越悠司 on 2020/10/30
//

import UIKit
import GRDB

class MoneyInsertViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return list.count
        } else {
            return repayerList.count
        }
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return list[row]
        } else {
            return repayerList[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {      // <<<<<<<<<<　変更
            List.text = list[row]
        } else {
            selectRepayer.text = repayerList[row]
        }
    }
    
    
    //値の取得
    var receiveId:Int64 = 0
    //項目の変数
    @IBOutlet private weak var List: UITextField!
    //金額入力を管理する変数
    @IBOutlet private weak var money: UITextField!
    //負担者を選択する変数
    @IBOutlet private weak var selectRepayer: UITextField!
    
    private var pickerView: UIPickerView = UIPickerView()
    private var pickerView2: UIPickerView = UIPickerView()
    //項目の選択肢
    private let list: [String] = ["レンタカー代", "ガソリン代", "高速道路代", "駐車場代", "その他"]
    private var member1:String?
    private var member2: String?
    private var member3: String?
    private var member4: String?
    private var member5: String?
    private var member6: String?
    
    
    //負担者を格納する変数
    var repayerList:[String?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //データベース接続
        let helper = DatabaseHelper()
        //前画面で作成したfolderinfoの一列情報を格納するための変数
        var entity: Folderinfo?
        //前画面のfolderid情報を基に検索を行う
        let result2 = helper.inDatabase { (db) in
            //全画面で登録したフォルダ情報を取得
            entity = try Folderinfo.filter(Folderinfo.Columns.folderid == receiveId).fetchOne(db)
        }
        if(!result2) {
            print("sippai")
        } else {
            //負担者のViewPickerを作成するため、検索結果から取り出す
            member1 = entity?.member1
            member2 = entity?.member2
            member3 = entity?.member3
            member4 = entity?.member4
            member5 = entity?.member5
            member6 = entity?.member6
            
            //入力されているか判定し、配列に格納をする
            if !(member1!.isEmpty) {
                repayerList.append(member1)
            }
            if !(member2!.isEmpty) {
                repayerList.append(member2)
            }
            if !(member3!.isEmpty) {
                repayerList.append(member3)
            }
            if !(member4!.isEmpty){
                repayerList.append(member4)
            }
            if !(member5!.isEmpty) {
                repayerList.append(member5)
            }
            if !(member5!.isEmpty) {
                repayerList.append(member6)
            }
        }
        
        pickerView.tag = 1
        pickerView2.tag = 2
        // ピッカー設定
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView2.delegate = self
        pickerView2.dataSource = self
        
        
        //決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        //let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        //let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        //toolbar.setItems([spacelItem, doneItem], animated: true)
        
        
        // 左側のBarButtonItemはflexibleSpace。これがないと右に寄らない。
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        // Doneボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(commitButtonTapped))
        
        // BarButtonItemの配置
        toolbar.items = [spacer, commitButton]
        // textViewのキーボードにツールバーを設定
        money.inputAccessoryView = toolbar
        selectRepayer.inputAccessoryView = toolbar
        // インプットビュー設定
        List.inputView = pickerView
        List.inputAccessoryView = toolbar
        selectRepayer.inputView = pickerView2
        
        //金額入力を数字のみにする
        self.money.keyboardType = UIKeyboardType.numberPad
        
        
    }
    
    
    /*入力完了後、キーボードを閉じる
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     self.view.endEditing(true)
     } */
    
    
    @objc func onClickCommitButton (sender: UIButton) {
        if(money.isFirstResponder){
            money.resignFirstResponder()
        }
    }
    
    @objc func commitButtonTapped() {
        self.view.endEditing(true)
        //List.text = "\(list[pickerView.selectedRow(inComponent: 0)])"
        
    }
    
    
    
    /*決定ボタン押下
     @objc func done() {
     List.endEditing(true)
     List.text = "\(list[pickerView.selectedRow(inComponent: 0)])"
     } */
    
    
    @IBAction func complete(_ sender: Any) {
        //各TextFieldから値を取得し格納
        let selectList:String! = List.text
        let inputMoney:String! = money.text
        //StringからInt型への変換
        let intMoney:Int64? = Int64(inputMoney)
        let chooseRepayer:String! = selectRepayer.text
        //未入力チェック
        if selectList.isEmpty {
            let alert = UIAlertController(title: "エラー", message: "項目を選択してください" ,preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
            present(alert, animated: true, completion: nil)
        } else if inputMoney.isEmpty {
            let alert = UIAlertController(title: "エラー", message: "金額を入力してください" ,preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
            present(alert, animated: true, completion: nil)
        } else if chooseRepayer.isEmpty {
            let alert = UIAlertController(title: "エラー", message: "負担者を選択してください" ,preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            
            let helper2 = DatabaseHelper()
            let result = helper2.inDatabase{(db) in
                //receivedIdは送信されたフォルダ番号
                let folder = Paragraphinfo(folderid: receiveId, para_name: selectList, para_cost: intMoney, repayer: chooseRepayer)
                //登録処理
                try folder.insert(db)
            }
            if (!result) {
                print("失敗")
            } else {
                print("成功")
                //登録済みか確認用コード
                var result3 :[Paragraphinfo] = []
                let helper4 = DatabaseHelper()
                
                let str = helper4.inDatabase { (db) in
                    result3 = try Paragraphinfo.fetchAll(db)
                }
                // 出力
                result3.forEach { (it) in
                    print("\(String(describing: it.folderid)) - \(String(describing: it.para_name)) - \(String(describing: it.para_cost)) - \(String(describing: it.para_num))")
                }
                if (!str) {
                    print("失敗")
                } else {
                    
                }
                
            }
            
            let alert: UIAlertController = UIAlertController( title: "", message: "どちらに移動しますか？", preferredStyle:  UIAlertController.Style.alert)
            
            // ② Actionの設定
            // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
            // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
            // 詳細ボタン
            let detailAction: UIAlertAction = UIAlertAction(title: "詳細", style: UIAlertAction.Style.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.performSegue(withIdentifier: "detail", sender: nil)
                    // storyboardのインスタンス取得
                    let storyboard1: UIStoryboard = self.storyboard!
                    
                    // 遷移先ViewControllerのインスタンス取得
                    let nextView1 = storyboard1.instantiateViewController(withIdentifier:"detail")
                    //コードでフルスクリーン表示を指定
                    nextView1.modalPresentationStyle = .fullScreen
                    // 画面遷移
                    self.present(nextView1, animated: true, completion: nil)
                }
                print("詳細")
            }
            
            )
            // ホームボタン
            let homeAction: UIAlertAction = UIAlertAction(title: "ホーム", style: UIAlertAction.Style.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    // storyboardのインスタンス取得
                    let storyboard2: UIStoryboard = self.storyboard!
                    
                    // 遷移先ViewControllerのインスタンス取得
                    let nextView2 = storyboard2.instantiateViewController(withIdentifier: "home")
                    //コードでフルスクリーン表示を指定
                    nextView2.modalPresentationStyle = .fullScreen
                    // 画面遷移
                    self.present(nextView2, animated: true, completion: nil)
                }
                print("ホーム")
            }
            )
            
            // ③ UIAlertControllerにActionを追加
            alert.addAction(homeAction)
            alert.addAction(detailAction)
            // ④ Alertを表示
            present(alert, animated: true, completion: nil)
            
        }
    }
}


