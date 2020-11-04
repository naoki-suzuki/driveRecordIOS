//
//  FolderDetailViewContorller.swift
//  driveRecord
//
//  Created by 長阪智哉 on 2020/11/4.
//
import UIKit
import GRDB

class FolderDetailViewController : UIViewController {
    
    //各ラベルに受け取った値を格納
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var folderTitle: UILabel!
    @IBOutlet weak var people: UILabel!
    @IBOutlet weak var mem1: UILabel!
    @IBOutlet weak var mem2: UILabel!
    @IBOutlet weak var mem3: UILabel!
    @IBOutlet weak var mem4: UILabel!
    @IBOutlet weak var mem5: UILabel!
    @IBOutlet weak var mem6: UILabel!
    
    
    /* @IBAction func showActivityView(_ sender: UIBarButtonItem) {
     
     let controller  = UIActivityViewController(activityItems: [show], applicationActivities: nil)
     self.present(controller,animated:true, completion:nil)
     }*/
    
    var folderList: String?   //title
    var date: String?          //日付
    var member1: String?      //メンバー
    var member2: String?     //メンバー
    var member3: String?    //メンバー
    var member4: String?    //メンバー
    var member5: String?    //メンバー
    var member6: String?     //メンバー
    
    //メンバー数をカウントする変数の作成
    private var count = 1
    
    //値の取得
    //var receiveId:Int64 = 0
    var Id = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //データベース接続
        let helper = DatabaseHelper()
        //前画面で作成したfolderinfoの一列情報を格納するための変数
        var entity: Folderinfo?
        
        //前画面のfolderid情報を基に検索を行う
        let result = helper.inDatabase { (db) in
            //全画面で登録したフォルダ情報を取得
            entity = try Folderinfo.filter(Folderinfo.Columns.folderid == Id).fetchOne(db)
        }
        if(!result) {
            print("sippai")
        } else {
            //検索結果から取り出し各変数に代入
            
            date = entity?.date
            folderList = entity?.title
            member1 = entity?.member1
            member2 = entity?.member2
            member3 = entity?.member3
            member4 = entity?.member4
            member5 = entity?.member5
            member6 = entity?.member6
            
            
        }
        //変数の格納ができているか調べるためのprint処理（最終的には消す）
        print(Id)
        print(member1 as Any)
        
        
        
        
        
        //ラベルテキストを使って角ラベルに貼り付け
        day.text = date
        folderTitle.text = folderList
        mem1.text = member1
        
        
        
        //member2-6はいない可能性もあるためnilであれば白紙にする
        if member2 == "" {
            
        } else {
            //nilでなければラベルに代入して人数を1増やす
            mem2.text = member2
            count += 1
        }
        
        if member3 == "" {
            
        } else {
            mem3.text = member3
            count += 1
        }
        
        if member4 == "" {
            
        } else {
            mem4.text = member4
            count += 1
        }
        
        if member5 == "" {
            
        } else {
            mem5.text = member5
            count += 1
        }
        
        if member6 == "" {
            
        } else {
            mem6.text = member6
            count += 1
        }
        
        
        //カウントした人数をラベルに貼り付ける
        people.text = "\(count)人"
        
        //memberのnilの数を参照する
        
        
        
    }
    
}
