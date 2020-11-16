//
//  ParagraphinfoTable.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/21.
//

import Foundation
import GRDB

class Paragraphinfo : Record {
        // テーブル名
        override static var databaseTableName: String {
            return "paragraphinfo"
        }
    
        //static let folderForeifnKey = ForeignKey(["folderid"]))
    
        var folderid:Int64!
        var para_num: Int64!
        var para_name: String!
        var para_cost: Int64!
        var repayer:String!
    
    static func create(_ db: Database) throws {
        try db.create(table: databaseTableName, body: { (makeTable: TableDefinition) in
            makeTable.column("folderid", .integer).references("folderinfo", column: "folderid", onDelete: Database.ForeignKeyAction(rawValue: "cascade"), onUpdate: Database.ForeignKeyAction(rawValue: "cascode"), deferred: true)
            makeTable.column("para_num", .integer).primaryKey(onConflict: .replace, autoincrement: true)
            makeTable.column("para_name", .text).notNull() // Nullを許さないのなら.notNull()をつける
            makeTable.column("para_cost", .integer).notNull() // Nullを許さないのなら.notNull()をつける
            makeTable.column("repayer", .text) // Nullを許す
        })
    }
    
  
    
    enum Columns {
        static let folderid = Column("folderid")
        static let para_num = Column("para_num")
        static let para_name = Column("para_name")
        static let para_cost = Column("para_cost")
        static let repayer = Column("repayer")
       
    }
    
    init(folderid:Int64!,para_name: String!, para_cost:Int64!,repayer: String!) {
            self.folderid = folderid
            self.para_name = para_name
            self.para_cost = para_cost
            self.repayer = repayer
            super.init()
        }

        required init(row: Row) {
            self.folderid = row["folderid"]
            self.para_num = row["para_num"]
            self.para_name = row["para_name"]
            self.para_cost = row["para_cost"]
            self.repayer = row["repayer"]
            super.init(row: row)
        }
    override func encode(to container: inout PersistenceContainer) {
        container["folderid"] = self.folderid
        container["para_num"] = self.para_num
        container["para_name"] = self.para_name
        container["para_cost"] = self.para_cost
        container["repayer"] = self.repayer
    }

    override func didInsert(with rowID: Int64, for column: String?) {
        self.para_num = rowID
    }
    
}
