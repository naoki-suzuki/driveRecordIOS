//
//  folderDetailViewContorller.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/13.
//

import UIKit

class folderDetailViewController : UIViewController {
    
    @IBAction func showActivityView(_ sender: UIBarButtonItem) {
        
        let controller  = UIActivityViewController(activityItems: [show], applicationActivities: nil)
        self.present(controller,animated:true, completion:nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
