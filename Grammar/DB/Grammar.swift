//
//  Grammar.swift
//  Grammar
//
//  Created by TuanAnh on 11/7/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit

class Grammar: NSObject {
    
    var id_ : Int!
    var lesson_id : Int!
    var index_in_lesson : Int!
    var title = String()
    var status  = Int()
    var content = String()
    var questions = [Question]()
    
    init(id_ : Int , lessionId : Int , indexInLesstion:Int , title:String , status : Int , content : String) {
        self.id_ = id_;
        self.lesson_id = lessionId;
        self.index_in_lesson = indexInLesstion;
        self.title  = title;
        self.status = status;
        self.content = content;
    }
    

}
