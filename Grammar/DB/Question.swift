//
//  Question.swift
//  Grammar
//
//  Created by TuanAnh on 11/7/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit

class Question: NSObject {
    
    var id_ : Int!
    var lesson_id : Int!
    var grammar_id : Int!
    var question = String()
    var answer_1 = String()
    var answer_2 = String()
    var answer_3 = String()
    var answer_4 = String()
    var correct_answer : Int!
    var status : Int!
    
    init(id_ : Int , lessonId : Int! , grammarId : Int , question : String , answer1 : String , answer2 : String , answer3 : String , answer4 : String , correctAnswer : Int , status : Int!) {
        
        self.id_ = id_;
        self.lesson_id = lessonId;
        self.grammar_id = grammarId;
        self.question = question;
        self.answer_1 = answer1;
        self.answer_2 = answer2;
        self.answer_3 = answer3;
        self.answer_4 = answer4;
        self.correct_answer = correctAnswer;
        self.status = status;
    }

}
