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
    
    private static let SQLInsertTestDetail = "" +
        "INSERT INTO " +
        "Test_Detail (Test_ID, Question_ID,User_Answer, Status) " +
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
    
    func loadTestDetails(hisId : Int) -> [TestDetail]
    {
        var testDetails = [TestDetail]()
        let query  = "" +
            "SELECT * FROM " +
            "Test_Detail " +
        "WHERE Test_ID == \(String(hisId)) ;"
        if let results =  self.db.executeQuery(query, withArgumentsIn: []){
             while results.next() {
                let testDetail = TestDetail(id_: Int(results.int(forColumn: "ID")), testId: Int(results.int(forColumn: "Test_ID")), questionID: Int(results.int(forColumn: "Question_ID")), userAnswer: Int(results.int(forColumn: "User_Answer")), status: Int(results.int(forColumn: "Status")))
                testDetails.append(testDetail)
            }
            
        }
        return testDetails
        
    }
    
    func savehistory(his : History)
    {
        let success = self.db.executeUpdate(HistoryDAO.SQLInsert, withArgumentsIn: [his.timeDate , his.title , his.score , his.status])
        if success {
            let lastId = self.db.lastInsertRowId
            for QaA in his.listQuestionAndAnswer
            {
                let _  = saveTestDetailByHistoryID(hisId_: Int(lastId), QaA: QaA)
            }
            
            print(" lastId \(lastId)")
            print("savehistory success")
        }else
        {
          print("savehistory failed")
        }
    }
    
    func updateHistory(his : History)
    {
        let query  = "UPDATE " +
            "Tests " +
            "SET " +
            "TimeDate = ?, Score = ? " +
            "WHERE " +
        "ID = ?;"
        let success = self.db.executeUpdate(query, withArgumentsIn: [his.timeDate , his.score,his.id_])
        let testDetails = self.loadTestDetails(hisId: his.id_)
        if success {
            print("update  his success")
            if testDetails.count == his.listQuestionAndAnswer.count
            {
                for i in 0 ..< testDetails.count
                {
                    let check = self.updateTestDetail(testDetail:testDetails[i] , QaA: his.listQuestionAndAnswer[i])
                    if check
                    {
                        print("update test detail success")
                    }else{
                       print("update test detail fail")
                    }
                }
            }
        }else
        {
            print("update  his fail")
        }
    }
    
    func updateTestDetail(testDetail : TestDetail , QaA : (ques : Question , answer : Int)) -> Bool
    {
        let query  = "UPDATE " +
            "Test_Detail " +
            "SET " +
            "User_Answer = ? " +
            "WHERE " +
        "ID = ?;"
        let success = self.db.executeUpdate(query, withArgumentsIn: [QaA.answer , testDetail.id_])
        return success
    }
    
    func saveTestDetailByHistoryID(hisId_ : Int , QaA : (ques : Question , answer : Int)) -> Bool
    {
        let success = self.db.executeUpdate(HistoryDAO.SQLInsertTestDetail, withArgumentsIn: [hisId_ , QaA.ques.id_ , QaA.answer , 0])
        if success {
            print("save ques with Id : \(QaA.ques.id_ ) success")
        }
        return success
    }

}
