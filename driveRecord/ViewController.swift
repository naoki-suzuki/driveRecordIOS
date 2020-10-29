//  ViewController.swift
//  driveRecord
//
//  Upgrade by 鈴木 on 2020/10/28

import UIKit
import GRDB

class ViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var folderid: [Int64?] = []
    private var folderList: [String] = []
    private var date: [String] = []
    
    // 元からあるコード
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // タップされたセルの行番号を出力
        print("\(indexPath.row)番目の行が選択されました。")
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        // 画面遷移
        // sender に渡したい値
        performSegue(withIdentifier: "showDetailSegue", sender: folderid[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetailSegue" {
            if let nextVC = segue.destination as? FolderDetailViewController,
               let index = sender as? Int {
            }
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
