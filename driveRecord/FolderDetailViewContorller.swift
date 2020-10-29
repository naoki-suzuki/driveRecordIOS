//
//  folderDetailViewContorller.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/13.
//
// コメント追加
import UIKit

class FolderDetailViewController : UIViewController {
    
    @IBAction func showActivityView(_ sender: UIBarButtonItem) {
        
        let controller  = UIActivityViewController(activityItems: [show], applicationActivities: nil)
        self.present(controller,animated:true, completion:nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
