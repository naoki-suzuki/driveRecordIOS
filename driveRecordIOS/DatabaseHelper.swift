//
//  DatabaseHelper.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/15.
//

import Foundation
import GRDB

class DatabaseHelper {
    
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
                return
            }
            let result = inDatabase {(db) in
                //両テーブル作成
                try Folderinfo.create(db)
                try Paragraphinfo.create(db)
                
            }

            if !result {
                do {try FileManager.default.removeItem(atPath: Const.dbFileName)} catch {}
            }
        }
    
    
    
}
