//
//  moneyInsertViewController.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/12.
//

import UIKit

class moneyInsertViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    // UIPickerViewの最初の表示
        func pickerView(_ pickerView: UIPickerView,
                        titleForRow row: Int,
                        forComponent component: Int) -> String? {
            
            return list[row]
        }

    
    
    @IBOutlet weak var List: UITextField!
    
    
    var pickerView: UIPickerView = UIPickerView()
        let list: [String] = ["レンタカー代", "ガソリン代", "高速道路代", "駐車場代", "その他"]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // ピッカー設定
            pickerView.delegate = self
            pickerView.dataSource = self
            
            
            // 決定バーの生成
            let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
            let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
            toolbar.setItems([spacelItem, doneItem], animated: true)
            
            // インプットビュー設定
            List.inputView = pickerView
            List.inputAccessoryView = toolbar
        }
        
        // 決定ボタン押下
        @objc func done() {
            List.endEditing(true)
            List.text = "\(list[pickerView.selectedRow(inComponent: 0)])"
        }
    }
     
            

