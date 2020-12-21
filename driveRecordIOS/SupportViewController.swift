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
    
}
