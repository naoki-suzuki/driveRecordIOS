//
//  SupportViewController.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/12.
//  Update by 大越悠司　on 2020/11/17

import UIKit

class SupportViewController : UIViewController {
    
    // ライセンスボタンを押下時の処理
    @IBAction func licens(_ sender: Any) {
        showOSSettingView()
    }
    
    // 設定画面に遷移を行うメソッド
    func showOSSettingView() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
