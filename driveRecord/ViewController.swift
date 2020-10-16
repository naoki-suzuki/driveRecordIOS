//  ViewController.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/12.

import UIKit

class ViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    // ②テーブルに表示するデータの準備
    var folderList = ["出張", "ドライブ２", "ドライブ３"]
    
    var date = ["2020/8/23", "2020/10/31", "2020/9/3"]
    
    //セルの編集許可
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
        {
            return true
        }

        //スワイプしたセルを削除
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == UITableViewCell.EditingStyle.delete {
                folderList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    
    // 元からあるコード
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    // ③テーブルの行数を指定するメソッド（必須）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderList.count
    }
 
    // ④セルの中身を設定するメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        // セルに値を設定する
        cell.textLabel!.text = folderList[indexPath.row]
        return cell
     
        
    }
 
}
