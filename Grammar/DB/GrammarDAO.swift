//
//  GrammarDAO.swift
//  Grammar
//
//  Created by TuanAnh on 11/7/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit
import FMDB

class GrammarDAO: NSObject {
    

    
    private let db: FMDatabase
    init(db: FMDatabase) {
        self.db = db
        super.init()
    }
    deinit {
        self.db.close()
    }
    
    func loadGrammarForLession(lessons: [Lesson])
    {
        for l in lessons {
            let query  = "" +
                "SELECT " +
                "ID, Lesson_ID , IndexInLesson , Title, Status, Content \n" +
                "FROM " +
                "Grammar " +
                "WHERE Lesson_ID == \(String(l.id_!)) ;"
            if let results =  self.db.executeQuery(query, withArgumentsIn: []){
                while results.next() {
                    
                    let grammar = Grammar(id_: Int(results.int(forColumn: "ID")), lessionId: Int(results.int(forColumn: "Lesson_ID")), indexInLesstion: Int(results.int(forColumn: "IndexInLesson")), title: results.string(forColumn: "Title")!, status: Int(results.int(forColumn: "Status")), content: results.string(forColumn: "Content")!)
                    l.grammars.append(grammar)
                }
                l.grammars.sort(by: {$0.index_in_lesson < $1.index_in_lesson})
            }
            
        }
    }
    
    

}
