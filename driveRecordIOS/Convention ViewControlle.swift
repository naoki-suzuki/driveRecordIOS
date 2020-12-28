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
        
        let webPage = "https://www.cimtech.co.jp/privacy/"
                let safariVC = SFSafariViewController(url: NSURL(string: webPage)! as URL)
                safariVC.modalPresentationStyle = .pageSheet  // フルスクリーンにしたい場合はこの行を削除
                present(safariVC, animated: true, completion: nil)
    }
    
}
