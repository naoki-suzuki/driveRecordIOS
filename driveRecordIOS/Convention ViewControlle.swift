//
//  Convention ViewControlle.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/12.
//

import UIKit
import SafariServices


class ConventionViewController : UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    @IBAction func safariPrivacy(_ sender: Any) {
        // 外部ブラウザでURLを開く
        let webPage = NSURL(string: "https://www.cimtech.co.jp/privacy/")
        
        let alert: UIAlertController = UIAlertController( title: "", message: "外部サイトへリンクしますか？", preferredStyle:  UIAlertController.Style.alert)
        
        // OKボタン(ホームに遷移)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            if UIApplication.shared.canOpenURL(webPage! as URL){
                UIApplication.shared.open(webPage! as URL, options: [:], completionHandler: nil)
            }
                        }
        )
        
        // キャンセルボタン
        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.default)

        
        // UIAlertControllerにActionを追加
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        // Alertを表示
        present(alert, animated: true, completion: nil)
    }
    
}
