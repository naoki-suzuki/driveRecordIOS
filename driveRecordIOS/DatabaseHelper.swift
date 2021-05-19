//
//  DatabaseHelper.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/15.
//  Updated by 長阪智哉 on 2021/5/17.

import Foundation
import GRDB

class DatabaseHelper {
    
    let userDefaults = UserDefaults.standard
    private struct Const {
            static let dbFileName = NSTemporaryDirectory() + "drive.db"
        }

        init() {
            self.creatDatabase()
        }

        func inDatabase(_ block: (Database) throws -> Void) -> Bool {
            do {
                // 初回実行時にデータベースファイルを生成する
                let dbQueue = try DatabaseQueue(path: Const.dbFileName)
                try dbQueue.inDatabase(block)
            }catch _ {
                return false
            }
            return true
        }
    // データベースの生成処理
        private func creatDatabase() {
            if FileManager.default.fileExists(atPath: Const.dbFileName) {
                // 既にDBが作成されている場合
                // let userDefaults = UserDefaults.standard
                // UserDefaults.standard.integer(forKey: "UpdateCheck")
                if userDefaults.integer(forKey: "UpdateCheck") == 0 {
                    
                    _ = inDatabase {(db) in
                    try db.alter(table: Folderinfo.databaseTableName) { (t) in
                        t.add(column: "Destination", .text)
                    }
                    
                    try db.alter(table: Folderinfo.databaseTableName) { (t) in
                        t.add(column: "Departure", .text)
                    }
                    }
                    // UserDefaults.integerに数値を登録し今後はcolumnの追加コードを通らないようにする
                    userDefaults.set(1, forKey: "UpdateCheck")
                }
                
                return
            }
            let result = inDatabase {(db) in
                //両テーブル作成
                try Folderinfo.create(db)
                try Paragraphinfo.create(db)
                
                // UserDefaults.integerに数値を登録し今後は38行目のコードでfalseになるようにする
                userDefaults.set(1, forKey: "UpdateCheck")
                
            }

            if !result {
                do {try FileManager.default.removeItem(atPath: Const.dbFileName)} catch {}
            }
        }
    
    
    
}
