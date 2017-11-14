//
//  HistoryDAO.swift
//  Grammar
//
//  Created by TuanAnh on 11/14/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit
import FMDB

class HistoryDAO: NSObject {
    
    private static let SQLSelect = "" +
        "SELECT " +
        "ID, TimeDate ,Title,Score , Status\n" +
        "FROM " +
    "Tests;"
    
    
    /// Query for the inssert row.
    private static let SQLInsert = "" +
        "INSERT INTO " +
        "Tests (TimeDate, Title,Score, Status) " +
        "VALUES " +
    "(?, ?, ?,?);"
    
    private let db: FMDatabase
    init(db: FMDatabase) {
        self.db = db
        super.init()
    }
    deinit {
        self.db.close()
    }
    
    func loadHistories() -> Array<History> {
        var tests = Array<History>()
        if let results =  self.db.executeQuery(HistoryDAO.SQLSelect, withArgumentsIn: []){
            while results.next() {
                let test = History(id_: Int(results.int(forColumn: "ID")), title: results.string(forColumn: "Title")!, timeDate: results.string(forColumn: "TimeDate")!, score: results.string(forColumn: "Score")!, status: Int(results.int(forColumn: "Status")))
                tests.append(test)
            }
        }
        
        return tests
    }
    
    func savehistory(his : History)
    {
        let success = self.db.executeUpdate(HistoryDAO.SQLInsert, withArgumentsIn: [his.timeDate , his.title , his.score , his.status])
        if success {
            print("savehistory success")
        }else
        {
          print("savehistory failed")
        }
    }

}
