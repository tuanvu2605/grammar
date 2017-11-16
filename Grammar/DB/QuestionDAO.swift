//
//  QuestionDAO.swift
//  Grammar
//
//  Created by TuanAnh on 11/7/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit
import FMDB

class QuestionDAO: NSObject {
    
    private let db: FMDatabase
    init(db: FMDatabase) {
        self.db = db
        super.init()
    }
    deinit {
        self.db.close()
    }
    
    func loadQuestionWithListTestDetail(testDetails : [TestDetail])->[Question]
    {
        var lisQuestion = [Question]()
        for td in testDetails
        {
            let query  = "" +
                "SELECT " +
                "ID, Lesson_ID ,Grammar_ID,Question,Answer1,Answer2,Answer3,Answer4,CorrectAnswer,status \n" +
                "FROM " +
                "Question " +
            "WHERE ID == \(String(td.questionID!)) ;"
            if let results =  self.db.executeQuery(query, withArgumentsIn: []){
                while results.next() {
                    let question = Question(id_: Int(results.int(forColumn: "ID")), lessonId: Int(results.int(forColumn: "Lesson_ID")), grammarId:Int(results.int(forColumn: "Grammar_ID")), question: results.string(forColumn: "Question")!, answer1:results.string(forColumn: "Answer1")!, answer2:results.string(forColumn: "Answer2")!, answer3: results.string(forColumn: "Answer3")!, answer4: results.string(forColumn: "Answer4")!, correctAnswer: Int(results.int(forColumn: "CorrectAnswer")), status: Int(results.int(forColumn: "status")))
                    print("question title : \(question.question)")
                    lisQuestion.append(question)
                }
                
            }
        }
        return lisQuestion
    }
    
    
    func updateQuestionStatus(quesId : Int , status : Int)
    {
        let query  = "UPDATE " +
            "Question " +
            "SET " +
            "status = ? " +
            "WHERE " +
        "ID = ?;"
        let _ = self.db.executeUpdate(query, withArgumentsIn: [quesId , status])
    }
    
    func loadQuestions(lessons: [Lesson]) {
        for l in lessons {
            
            for grammar in l.grammars
            {
                let query  = "" +
                    "SELECT " +
                    "ID, Lesson_ID ,Grammar_ID,Question,Answer1,Answer2,Answer3,Answer4,CorrectAnswer,status \n" +
                    "FROM " +
                    "Question " +
                    "WHERE Lesson_ID == \(String(l.id_!)) AND Grammar_ID == \(String(grammar.index_in_lesson!));"
                if let results =  self.db.executeQuery(query, withArgumentsIn: []){
                    while results.next() {
                        let question = Question(id_: Int(results.int(forColumn: "ID")), lessonId: Int(results.int(forColumn: "Lesson_ID")), grammarId:Int(results.int(forColumn: "Grammar_ID")), question: results.string(forColumn: "Question")!, answer1:results.string(forColumn: "Answer1")!, answer2:results.string(forColumn: "Answer2")!, answer3: results.string(forColumn: "Answer3")!, answer4: results.string(forColumn: "Answer4")!, correctAnswer: Int(results.int(forColumn: "CorrectAnswer")), status: Int(results.int(forColumn: "status")))
                        print("question title : \(question.question)")
                        grammar.questions.append(question);
                    }

                }
                
            }
            
        }
    }

}
