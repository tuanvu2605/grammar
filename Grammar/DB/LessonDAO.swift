//
//  LessonDAO.swift
//  Grammar
//
//  Created by TuanAnh on 11/7/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit
import FMDB

class LessonDAO: NSObject {
    
    private static let SQLSelect = "" +
        "SELECT " +
        "ID, Title, Status, NumOfGrammar,Score \n" +
        "FROM " +
    "Lesson;"
    
    private let db: FMDatabase
    init(db: FMDatabase) {
        self.db = db
        super.init()
    }
    deinit {
        self.db.close()
    }
    
    func loadLessons() -> Array<Lesson> {
        var lessons = Array<Lesson>()
        if let results =  self.db.executeQuery(LessonDAO.SQLSelect, withArgumentsIn: []){
            while results.next() {
                let lesson = Lesson(id_: Int(results.int(forColumn: "ID")), title:results.string(forColumn: "Title")!, status: Int(results.int(forColumn: "Status")), numberOfGrammar: Int(results.int(forColumn: "NumOfGrammar")), score: results.string(forColumn: "Score")!)
                lessons.append(lesson)
            }
        }
        
        return lessons
    }

}
