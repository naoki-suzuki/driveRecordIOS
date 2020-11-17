//
//  cameraViewController.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/26.
//

import Foundation
import UIKit

class cameraViewController: UIViewController, UIImagePickerControllerDelegate,
                      UINavigationControllerDelegate{
    
   
    @IBOutlet weak var cameraPic: UIImageView!
    var cameraReceive: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // cameraPic.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.cameraPic.image = self.cameraReceive
    }
    
   
    // 撮影した写真の保存
    @IBAction func save(_ sender: Any) {
   
        let image:UIImage! = cameraPic.image
        
        if image != nil {
            UIImageWriteToSavedPhotosAlbum(
                image,
                self,
                #selector(cameraViewController.image(_:didFinishSavingWithError:contextInfo:)),
                nil)
            
            let alert = UIAlertController(title: "", message: "写真を保存しました" ,preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,handler: nil))
            present(alert, animated: true, completion: nil)
        }
        else{
            
        }
        
    }
   
    
    // 書き込み完了結果の受け取り
    @objc func image(_ image: UIImage,
                     didFinishSavingWithError error: NSError!,
                     contextInfo: UnsafeMutableRawPointer) {
        
        if error != nil {
            print(error.code)
            
        }
        else{
            
        }
    }
    
    
}
