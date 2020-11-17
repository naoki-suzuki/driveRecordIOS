//  ViewController.swift
//  driveRecord
//
//  Upgrade by 鈴木 on 2020/10/28

import UIKit
import GRDB

class ViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var mapBtn: UIButton!
    
    // データ格納用の配列
    private var folderid: [Int64?] = []
    private var folderList: [String] = []
    private var date: [String] = []
    
    // 元からあるコード
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapBtn.imageView?.contentMode = .scaleAspectFit
        mapBtn.contentHorizontalAlignment = .fill
        mapBtn.contentVerticalAlignment = .fill
        
        // データベース接続
        var result: [Folderinfo] = []
        let helper = DatabaseHelper()
        helper.inDatabase{ (db) in
            result = try Folderinfo.fetchAll(db)
        }
        result.forEach{(it) in
            print("\(Int64(it.folderid!)) - \(String(describing: it.title)) - \(String(describing: it.date))")
        }
        
        for it in result {
            
            // ②テーブルに表示するデータの準備
            folderid.append(it.folderid)
            folderList.append(it.title)
            date.append(it.date)
        }
    }
    
    // ③テーブルの行数を指定するメソッド（必須）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderList.count
    }
    
    // ④セルの中身を設定するメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath as IndexPath)
        
        // ラベルオブジェクトを作る
        // 日付のラベル
        let labelDate = cell.viewWithTag(1) as! UILabel
        // ラベルに表示する文字列を設定
        labelDate.text = (date[indexPath.row])
        
        // ラベルオブジェクトを作る
        // タイトルのラベル
        let labelFolderList = cell.viewWithTag(2) as! UILabel
        // ラベルに表示する文字列を設定
        labelFolderList.text = (folderList[indexPath.row])
        
        return cell
    }
    
    
    @IBOutlet private weak var tableView: UITableView!
    
    
    // セル押下時の画面遷移
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "showDetailSegue" {
    //
    //            let nextView = segue.destination as! FolderDetailViewController
    //
    //            nextView.argString = folderid[indexPath.row]
    //        }
    //
    //    }
    
    /* セル押下時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // タップされたセルの行番号を出力
        print("\(indexPath.row)番目の行が選択されました。")
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        // 画面遷移
        // sender に渡したい値
        performSegue(withIdentifier: "showDetailSegue", sender: folderid[indexPath.row])
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue" {
            
        let x = self.tableView.indexPathForSelectedRow
        // 選択した行数を習得
        let y = x?.row
        // 送信したい値を格納
        let post = folderid[y!]
        print(post!)
        // 送信先の画面をインスタンス化
        let nextVC  = segue.destination as! FolderDetailViewController
        //let secondView = nextVC.topViewController as! FolderDetailViewController
        nextVC.receiveId = post!
        }
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
        
        let index = folderid[indexPath.row]
        
        // 外部キーの制約のため、先に子テーブルのParagraphinfoの該当列から削除処理を行う
              let result2 = helper.inDatabase { (db) in
                  try Paragraphinfo.filter(Paragraphinfo.Columns.folderid == index).deleteAll(db)
              }
              
              if result2 {
                  print("成功")
              } else {
                  print("失敗")
              }
        
        // フォルダID取得
        
        _ = helper.inDatabase { (db) in
            try Folderinfo.filter(key: index).deleteAll(db)
        }
        
        // フォルダID配列の要素を削除
        folderid.remove(at: indexPath.row)
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            folderList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
}

class CustomBtn: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        print("awakeFromNib")
        // UIButtonサイズは width:44, height:30 に固定
        // UIButton配置は viewSafeAreaのHcenter/Vcenter
        // ここへの記述が的確なのか？
        self.imageView?.contentMode = .scaleAspectFit
        self.contentHorizontalAlignment = .fill
        self.contentVerticalAlignment = .fill
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}