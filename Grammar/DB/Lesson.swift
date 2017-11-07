//
//  Lesson.swift
//  Grammar
//
//  Created by TuanAnh on 11/7/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit

class Lesson: NSObject {
    
    var id_ : Int!
    var title = String()
    var status : Int!
    var number_of_grammar : Int!
    var score : Int!
    var grammars  = [Grammar]()
    
    init(id_ : Int , title : String , status : Int , numberOfGrammar : Int , score : Int) {
        self.id_ = id_;
        self.status = status;
        self.number_of_grammar = numberOfGrammar;
        self.score = score;
        self.title = title;
    }

}
