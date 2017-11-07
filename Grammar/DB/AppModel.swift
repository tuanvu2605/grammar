//
//  AppModel.swift
//  Grammar
//
//  Created by TuanAnh on 11/7/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit

class AppModel: NSObject {
    
    static let shareModel = AppModel()
    private(set )var  lessons : [Lesson] = [Lesson]()
    
    func run()
    {
        let daoFactory = DAOFactory()
        let lessonDAO = daoFactory.lessonDAO()
        let grammarDAO = daoFactory.grammarDAO()
        let questionDAO = daoFactory.questionDAO()
        lessons = lessonDAO!.loadLessons()
        grammarDAO!.loadGrammarForLession(lessons: lessons)
        questionDAO?.loadQuestions(lessons: lessons)
        
    }

}
