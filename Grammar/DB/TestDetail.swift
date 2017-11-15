//
//  TestDetail.swift
//  Grammar
//
//  Created by TuanAnh on 11/15/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit

class TestDetail: NSObject {
    
    var id_ : Int!
    var testId : Int!
    var questionID :Int!
    var status : Int!
    var userAnswer : Int!
    

    override init() {
        self.status = 0
    }
    init(id_ : Int , testId : Int  , questionID : Int , userAnswer : Int , status : Int) {
        self.id_ = id_;
        self.testId = testId;
        self.questionID = questionID;
        self.status = status;
        self.userAnswer = userAnswer;
    }

}
