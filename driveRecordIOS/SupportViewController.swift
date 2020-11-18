//
//  SupportViewController.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/12.
//

import UIKit

class SupportViewController : UIViewController {
    
    
    @IBAction func license(_ sender: Any) {
        showOSSettingView()
    }
    
    // 設定画面に遷移を行うメソッド
    func showOSSettingView() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    
}
