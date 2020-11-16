//
//  FolderDetailViewContorller.swift
//  driveRecord
//
//  Created by 長阪智哉 on 2020/11/4
//
import UIKit
import GRDB

class FolderDetailViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    

    // 各ラベルに受け取った値を格納
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var folderTitle: UILabel!
    @IBOutlet weak var people: UILabel!
    @IBOutlet weak var mem1: UILabel!
    @IBOutlet weak var mem2: UILabel!
    @IBOutlet weak var mem3: UILabel!
    @IBOutlet weak var mem4: UILabel!
    @IBOutlet weak var mem5: UILabel!
    @IBOutlet weak var mem6: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    /* @IBAction func showActivityView(_ sender: UIBarButtonItem) {
     
     let controller  = UIActivityViewController(activityItems: [show], applicationActivities: nil)
     self.present(controller,animated:true, completion:nil)
     }*/
    
    var folderList: String?   // title
    var date: String?          // 日付
    var member1: String?      // メンバー
    var member2: String?     // メンバー
    var member3: String?    // メンバー
    var member4: String?    // メンバー
    var member5: String?    // メンバー
    var member6: String?     // メンバー
    var use: [String] = []        // 使用用途
    var cost: [Int64?] = []          // 費用
    var buyer: [String] = []      // 負担者
    
    // メンバー数をカウントする変数の作成
    private var count = 1
    
    // 値の取得
    var receiveId:Int64 = 0
    //var Id = 1
    
    @IBAction func moenyInsert(_ sender: Any) {
        //segueの実行
        performSegue(withIdentifier: "moneyView", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // データベース接続
        let helper = DatabaseHelper()
        // 前画面で作成したfolderinfoの一列情報を格納するための変数
        var entity1: Folderinfo?
        
        // 前画面で作成したfolderinfoの一列情報を格納するための変数
        var entity2: [Paragraphinfo?] = []
        
        // 前画面のfolderid情報を基にfolderinfoに検索を行う
        let result1 = helper.inDatabase { (db) in
            // 全画面で登録したフォルダ情報を取得
            entity1 = try
                Folderinfo.filter(Folderinfo.Columns.folderid == receiveId).fetchOne(db)
            
        }
        if(!result1) {
            print("sippai")
        } else {
            // 検索結果から取り出し各変数に代入
            
            date = entity1?.date
            folderList = entity1?.title
            member1 = entity1?.member1
            member2 = entity1?.member2
            member3 = entity1?.member3
            member4 = entity1?.member4
            member5 = entity1?.member5
            member6 = entity1?.member6
            
            
        }
        
        //前画面のfolderid情報を基にParagraphinfoに検索を行う
        let result2 = helper.inDatabase { (db) in
            //全画面で登録したフォルダ情報を取得
            entity2 = try Paragraphinfo.filter(Paragraphinfo.Columns.folderid == receiveId).fetchAll(db)
            
        }
        
        if(!result1) {
            print("sippai")
        } else {
            // 検索結果から取り出し各変数に代入
            
            for it in entity2 {
                use.append(it!.para_name)
                cost.append(it?.para_cost)
                buyer.append(it!.repayer)
                
            }
            
            
        }
        
        
        
        
        //ラベルテキストを使って角ラベルに貼り付け
        day.text = date
        folderTitle.text = folderList
        mem1.text = member1
        
        
        
        //member2-6はいない可能性もあるためnilであれば空文字にする
        if member2 == "" {
            mem2.text = ""
            
        } else {
            //nilでなければラベルに代入して人数を1増やす
            mem2.text = member2
            count += 1
        }
        
        if member3 == "" {
            mem3.text = ""
            
        } else {
            mem3.text = member3
            count += 1
        }
        
        if member4 == "" {
            mem4.text = ""
            
        } else {
            mem4.text = member4
            count += 1
        }
        
        if member5 == "" {
            mem5.text = ""
            
        } else {
            mem5.text = member5
            count += 1
        }
        
        if member6 == "" {
            mem6.text = ""
            
        } else {
            mem6.text = member6
            count += 1
        }
        
        
        //カウントした人数をラベルに貼り付ける
        people.text = "\(count)人"
        
        //memberのnilの数を参照する
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return use.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 130
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "table", for: indexPath as IndexPath)
        
        // ラベルオブジェクトを作る
        // 使用用途のラベル
        let labeluse = cell.viewWithTag(1) as! UILabel
        // ラベルに表示する文字列を設定
        labeluse.text = "使用用途"
        
        // ラベルオブジェクトを作る
        // 使用用途のラベル
        let labelUse = cell.viewWithTag(2) as! UILabel
        // ラベルに表示する文字列を設定
        labelUse.text = (use[indexPath.row])
        
        // ラベルオブジェクトを作る
        // 金額のラベル
        let labelmoney = cell.viewWithTag(3) as! UILabel
        // ラベルに表示する文字列を設定
        labelmoney.text = "金額"
        
        // ラベルオブジェクトを作る
        // 金額のラベル
        let labelMoney = cell.viewWithTag(4) as! UILabel
        // ラベルに表示する文字列を設定
        labelMoney.text = "000えん"//(cost[indexPath.row])
        
        // 一人当たり金額のラベル
        let labelsyou = cell.viewWithTag(5) as! UILabel
        // ラベルに表示する文字列を設定
        labelsyou.text = "一人当たり"
        
        // 一人当たり金額のラベル
        let labelSyou = cell.viewWithTag(6) as! UILabel
        // ラベルに表示する文字列を設定
        labelSyou.text = "えん園"
        
        // 負担者のラベル
        let labelbuyer = cell.viewWithTag(7) as! UILabel
        // ラベルに表示する文字列を設定
        labelbuyer.text = "負担者"
        
        // 負担者のラベル
        let labelBuyer = cell.viewWithTag(8) as! UILabel
        // ラベルに表示する文字列を設定
        labelBuyer.text = (buyer[indexPath.row])
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moneyView" {
            
            // 送信したい値を格納
            let post = receiveId
            print(post)
            // 送信先の画面をインスタンス化
            let nextVC  = segue.destination as! UINavigationController
            let secondView = nextVC.topViewController as! MoneyInsertViewController
            secondView.receiveId = post
            
            
        }
    }
    
}
