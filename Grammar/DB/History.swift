//
//  History.swift
//  Grammar
//
//  Created by TuanAnh on 11/14/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit

class History: NSObject {
    
    var id_ : Int!
    var title = String()
    var timeDate = String()
    var status : Int!
    var score : String!
    var isReviewed = Bool()

    
    override init() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.timeDate = dateFormatter.string(from: Date())
        self.status = 0
        
    }
    init(id_ : Int , title : String  , timeDate : String , score : String , status : Int) {
        self.id_ = id_;
        self.status = status;
        self.score = score;
        self.title = title;
        self.timeDate = timeDate;
    }

}
