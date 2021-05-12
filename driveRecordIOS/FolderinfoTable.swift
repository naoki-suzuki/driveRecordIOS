//
//  FolderinfoTable.swift
//  driveRecord
//
//  Created by 大越悠司 on 2020/10/15.
//  Updated by 長阪智哉

import Foundation
import GRDB

class Folderinfo : Record {
    // テーブル名
        override static var databaseTableName: String {
            return "folderinfo"
        }

        var folderid: Int64?//AutoIncrementを行うため、initで呼び出されないようにするため
        var title: String!
        var date: String!
        var member1:String!
        var member2:String!
        var member3:String!
        var member4:String!
        var member5:String!
        var member6:String!
        var Destination:String!
        var Departure:String!
    

        static func create(_ db: Database) throws {
            try db.create(table: databaseTableName, body: { (makeTable: TableDefinition) in
                makeTable.column("folderid", .integer).primaryKey(onConflict: .replace, autoincrement: true)
                makeTable.column("title", .text).notNull()// 重複を許さないのなら.unique()をつける
                makeTable.column("date", .numeric).notNull() // Nullを許さないのなら.notNull()をつける
                makeTable.column("member1", .text).notNull() // Nullを許さないのなら.notNull()をつける
                makeTable.column("member2", .text) // Nullを許す
                makeTable.column("member3", .text) // Nullを許す
                makeTable.column("member4", .text) // Nullを許す
                makeTable.column("member5", .text) // Nullを許す
                makeTable.column("member6", .text) // Nullを許す
                makeTable.column("Destination", .text) // Nullを許す
                makeTable.column("Departure", .text)    // Nullを許す
            })
        }

        enum Columns {
            static let folderid = Column("folderid")
            static let title = Column("title")
            static let date = Column("date")
            static let member1 = Column("member1")
            static let membet2 = Column("member2")
            static let member3 = Column("member3")
            static let member4 = Column("member4")
            static let member5 = Column("member5")
            static let member6 = Column("member6")
            static let Destination = Column("Destination")
            static let Departure = Column("Departure")
        }

    init(title: String!, date: String!,member1: String!,member2: String!,member3: String!,member4: String!,member5: String!,member6: String!,Destination: String!,Departure :String!) {
            self.title = title
            self.date = date
            self.member1 = member1
            self.member2 = member2
            self.member3 = member3
            self.member4 = member4
            self.member5 = member5
            self.member6 = member6
            self.Destination = Destination
            self.Departure = Departure
            super.init()
        }

        required init(row: Row) {
            self.folderid = row["folderid"]
            self.title = row["title"]
            self.date = row["date"]
            self.member1 = row["member1"]
            self.member2 = row["member2"]
            self.member3 = row["member3"]
            self.member4 = row["member4"]
            self.member5 = row["member5"]
            self.member6 = row["member6"]
            self.Destination = row["Destination"]
            self.Departure = row["Departure"]
            super.init(row: row)
        }

        override func encode(to container: inout PersistenceContainer) {
            container["folderid"] = self.folderid
            container["title"] = self.title
            container["date"] = self.date
            container["member1"] = self.member1
            container["member2"] = self.member2
            container["member3"] = self.member3
            container["member4"] = self.member4
            container["member5"] = self.member5
            container["member6"] = self.member6
            container["Destination"] = self.Destination
            container["Departure"] = self.Departure
        }

        override func didInsert(with rowID: Int64, for column: String?) {
            self.folderid = rowID
            
        }
    
}

