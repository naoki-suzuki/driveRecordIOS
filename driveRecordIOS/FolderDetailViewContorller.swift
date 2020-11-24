//
//  FolderDetailViewContorller.swift
//  driveRecord
//
//  Created by 長阪智哉 on 2020/11/20
//
import UIKit
import GRDB

class FolderDetailViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    // 各ラベルに受け取った値を格納
    @IBOutlet private weak var day: UILabel!
    @IBOutlet private weak var folderTitle: UILabel!
    @IBOutlet private weak var people: UILabel!
    @IBOutlet private weak var mem1: UILabel!
    @IBOutlet private weak var mem2: UILabel!
    @IBOutlet private weak var mem3: UILabel!
    @IBOutlet private weak var mem4: UILabel!
    @IBOutlet private weak var mem5: UILabel!
    @IBOutlet private weak var mem6: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var sum: UILabel!
    @IBOutlet private weak var ave: UILabel!
    
    
    /* @IBAction func showActivityView(_ sender: UIBarButtonItem) {
     
     let controller  = UIActivityViewController(activityItems: [show], applicationActivities: nil)
     self.present(controller,animated:true, completion:nil)
     }*/
    
    private var folderid: Int64?        //フォルダID
    private var paragraphId: [Int64] = []     //パラグラフID
    private var folderList: String?   // title
    private var date: String?          // 日付
    private var member1: String?      // メンバー
    private var member2: String?     // メンバー
    private var member3: String?    // メンバー
    private var member4: String?    // メンバー
    private var member5: String?    // メンバー
    private var member6: String?     // メンバー
    private var use: [String] = []        // 使用用途
    private var cost: [Int64] = []        //費用
    private var buyer: [String] = []      // 負担者
    // メンバー数をカウントする変数の作成
    private var count: Int64 = 1
    // 値の取得
    var receiveId:Int64 = 0
    private var sumCost: Int64 = 0     //合計金額
    private var aveCost: Int64 = 0     //一人当たりの金額
    
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
        
        // 前画面のfolderid情報を基にParagraphinfoに検索を行う
        let result2 = helper.inDatabase { (db) in
            // 全画面で登録したフォルダ情報を取得
            entity2 = try Paragraphinfo.filter(Paragraphinfo.Columns.folderid == receiveId).fetchAll(db)
            
        }
        
        if(!result2) {
            print("sippai")
        } else {
            // 検索結果から取り出し各変数に代入
            
            for it in entity2 {
                paragraphId.append(it!.para_num)
                use.append(it!.para_name)
                // cost.append(it?.para_cost)
                cost.append((it?.para_cost)!)
                buyer.append(it!.repayer)
                
            }
            
        }
        
        // ラベルテキストを使って角ラベルに貼り付け
        day.text = date
        folderTitle.text = folderList
        mem1.text = member1
        
        // member2-6はいない可能性もあるためnilであれば空文字にする
        if member2 == "" {
            mem2.text = ""
            
        } else {
            // nilでなければラベルに代入して人数を1増やす
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
        
        //　合計金額と一人当たりの金額を算出
        sumCost = cost.reduce(0) { $0 + $1}
        print(sumCost)
        
        aveCost = sumCost / count
        print(aveCost)
        
        // ラベルに合計と一人当たりの金額の貼り付け
        sum.text = "\(sumCost)円"
        ave.text = "\(aveCost)円"
        
        // カウントした人数をラベルに貼り付ける
        people.text = "\(count)人"

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return use.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath as IndexPath)
        
        // ラベルオブジェクトを作る
        // 使用用途のラベル
        let labelUse = cell.viewWithTag(1) as! UILabel
        // ラベルに表示する文字列を設定
        labelUse.text = (use[indexPath.row])
        
        // ラベルオブジェクトを作る
        // 金額のラベル
        let labelmoney = cell.viewWithTag(2) as! UILabel
        // ラベルに表示する文字列を設定
        labelmoney.text = "金額"
        
        // ラベルオブジェクトを作る
        // 金額のラベル
        let labelMoney = cell.viewWithTag(3) as! UILabel
        // ラベルに表示する文字列を設定
        // labelMoney.text = "000えん"//(cost[indexPath.row])
        labelMoney.text = "\(cost[indexPath.row])円"
        
        // 一人当たり金額のラベル
        let labelsyou = cell.viewWithTag(4) as! UILabel
        // ラベルに表示する文字列を設定
        labelsyou.text = "一人当たり"
        
        // 一人当たり金額のラベル
        let labelSyou = cell.viewWithTag(5) as! UILabel
        // ラベルに表示する文字列を設定
        labelSyou.text = "\(cost[indexPath.row]/count)円"
        
        // 負担者のラベル
        let labelbuyer = cell.viewWithTag(6) as! UILabel
        // ラベルに表示する文字列を設定
        labelbuyer.text = "負担者"
        
        // 負担者のラベル
        let labelBuyer = cell.viewWithTag(7) as! UILabel
        // ラベルに表示する文字列を設定
        labelBuyer.text = (buyer[indexPath.row])
        
        return cell
    }
    
    // セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    // スワイプしたセルを削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // データベース接続し、該当項目のフォルダを削除
        let helper = DatabaseHelper()
        
        let index = paragraphId[indexPath.row]
        
        // 外部キーの制約のため、先に子テーブルのParagraphinfoの該当列から削除処理を行う
        let result2 = helper.inDatabase { (db) in
            try Paragraphinfo.filter(Paragraphinfo.Columns.para_num == index).deleteAll(db)
        }
        
        if result2 {
            print("成功")
        } else {
            print("失敗")
        }
        
        // パラグラフID配列の要素を削除
        paragraphId.remove(at: indexPath.row)
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            use.remove(at: indexPath.row)
            buyer.remove(at: indexPath.row)
            cost.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            
            //　削除後の合計金額と一人当たりの金額を算出してラベルに再度貼り付け
            sumCost = cost.reduce(0) { $0 + $1}
            aveCost = sumCost / count
            sum.text = "\(sumCost)円"
            ave.text = "\(aveCost)円"
            
        }
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
    
    @IBAction func showActivityView(_ sender: Any) {
        // 表示情報を取得
        if let shareLabel = day.text {
            let shareLabel2:String = folderTitle.text!
            let shareLabel3:String = people.text!
            let shareLabel4:[String] = [mem1.text!,mem2.text!,mem3.text!,mem4.text!,mem5.text!,mem6.text!]
            var memberText:String = ""
            var text = ""
            
            // 使用項目がある場合と無い場合でtextを変更
            if use.count == 0 {
                text = "未登録\n"
            } else {
                for s in 0..<use.count {
                    text += """
                \(use[s])
                \(String(describing: cost[s]))円
                1人当たり：\(cost[s]/count)円
                負担者：\(buyer[s])\n
                """
                }
            }
            
            // メンバーのデータが空白以外の場合にmembertextに代入
            for i in 0..<shareLabel4.count {
                if shareLabel4[i] != "" {
                    memberText += """
                    \(shareLabel4[i])\n
                    """
                }
            }
            
            
            
            
            let lineText = """
            ドラレコ
            日付
            \(shareLabel)\n
            タイトル
            \(shareLabel2)\n
            人数
            \(shareLabel3)\n
            メンバー
            \(memberText)
            使用項目
            \(text)
            合計金額
            \(sumCost)円\n
            1人当たり
            \(aveCost)円
            """
            //UIActivityに渡す配列を作成
            let shareItems = [lineText]
            //UIACtitivityViewControllerにシェアラベルを渡す
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            //iPadで落ちてしまう対策
            controller.popoverPresentationController?.sourceView = view
            
            //UIActivityViewControllerを表示
            present(controller, animated: true, completion: nil)
        }
    }
    
}
