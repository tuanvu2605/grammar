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
    private (set) var histories : [History] = [History]()
    var daoFactory : DAOFactory!
    var lessonDAO : LessonDAO!
    var grammarDAO : GrammarDAO!
    var questionDAO : QuestionDAO!
    var historyDAO : HistoryDAO!
    var history : History?
    
    
    func run()
    {
        daoFactory = DAOFactory()
        lessonDAO = daoFactory.lessonDAO()
        grammarDAO = daoFactory.grammarDAO()
        questionDAO = daoFactory.questionDAO()
        historyDAO = daoFactory.historyDAO()
        lessons = lessonDAO!.loadLessons()
        grammarDAO!.loadGrammarForLession(lessons: lessons)
        questionDAO?.loadQuestions(lessons: lessons)
        histories = historyDAO.loadHistories()
        
    }

}
