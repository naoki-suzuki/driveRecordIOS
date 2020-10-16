//
//  folderCreateViewController.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/12.
//

import UIKit

class folderCreateViewController : UIViewController, UITextFieldDelegate {
    //日付のTextField
    @IBOutlet weak var dateTravel: UITextField!
    //タイトル名のTextField
    @IBOutlet weak var travelName: UITextField!
    //メンバー名のTextField
    @IBOutlet weak var menber1: UITextField!
    
    //日付の保存用変数
    var dateTravelDate = ""
    //タイトル保存用の変数
    var travelNameString = ""
    //メンバー名保存用の変数
    var travelMenber1String = ""
    

    let datePicker = UIDatePicker()

        override func viewDidLoad() {
            super.viewDidLoad()

            createDatePicker()
        }

       func createDatePicker(){
            
            // DatePickerModeをDate(日付)に設定
            datePicker.datePickerMode = .date

            // DatePickerを日本語化
            datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale

            // textFieldのinputViewにdatepickerを設定
            dateTravel.inputView = datePicker
            
            // UIToolbarを設定
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            // Doneボタンを設定(押下時doneClickedが起動)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
            
            // Doneボタンを追加
            toolbar.setItems([doneButton], animated: true)
            
            // FieldにToolbarを追加
            dateTravel.inputAccessoryView = toolbar
        }
        
        @objc func doneClicked(){
            let dateFormatter = DateFormatter()

            // 持ってくるデータのフォーマットを設定
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            dateFormatter.locale    = NSLocale(localeIdentifier: "ja_JP") as Locale?
            dateFormatter.dateStyle = DateFormatter.Style.medium

            // textFieldに選択した日付を代入
            dateTravel.text = dateFormatter.string(from: datePicker.date)
            
            // キーボードを閉じる
            self.view.endEditing(true)
        }
            

    func InsertForm(_ sender: UIButton) {
        //各TextFieldから値を取得
       dateTravelDate = dateTravel.text!
       travelNameString = travelName.text!
       travelMenber1String = menber1.text!
        
        
}
    
}
