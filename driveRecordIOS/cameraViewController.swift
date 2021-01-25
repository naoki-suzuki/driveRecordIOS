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
    
    // 撮影した写真の表示
    @IBOutlet weak var cameraPic: UIImageView!
    
    // MoneyInsertで冊絵した写真を受け取る変数
    var cameraReceive: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // cameraPic.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.cameraPic.image = self.cameraReceive
        
        // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
        self.navigationController?.navigationBar.tintColor = .white
        
    }
    
    
    // 撮影した写真の保存
    @IBAction func save(_ sender: Any) {
        // UIImageViewからUIImageへ型の変更
        let image:UIImage! = cameraPic.image
        
        // 保存するか否かのアラート
        let alertController = UIAlertController(title: "保存", message: "この画像を保存しますか？", preferredStyle: .alert)
        // OK
        let okAction = UIAlertAction(title: "OK", style: .default) { (ok) in
            //ここでフォトライブラリに画像を保存
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.showResultOfSaveImage(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        // キャンセル
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default) { (cancel) in
            alertController.dismiss(animated: true, completion: nil)
        }
        //　OKとキャンセルを表示追加し、アラートを表示
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    // 保存結果をアラート
    @objc func showResultOfSaveImage(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
        var title = "保存完了"
        var message = "カメラロールに保存しました"
        
        if error != nil {
            //保存許可を認めていない時、発生
            title = "エラー"
            message = "保存に失敗しました"
        }
        // アラート表示するタイトルとメッセージの格納
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // OKボタンを追加
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // UIAlertController を表示
        self.present(alert, animated: true, completion: nil)
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
