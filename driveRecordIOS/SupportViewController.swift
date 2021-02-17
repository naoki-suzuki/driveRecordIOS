//
//  SupportViewController.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/12.
//

import UIKit

class SupportViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Tabバーの色の指定
        UINavigationBar.appearance().barTintColor = UIColor.systemTeal
        // Tabバーの文字の色の指定
        self.navigationController?.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.white]
        
    }
    @IBAction func license(_ sender: Any) {
        showOSSettingView()
    }
    
    // 設定画面に遷移を行うメソッド
    func showOSSettingView() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func backView() {
        
    self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ActivityGuide(_ sender: Any) {
        
        // 外部ブラウザでURLを開く
        let webPage = NSURL(string: "http://www.cimtech.co.jp/apl/dlog/guide.pdf")
        
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
