//
//  DAOFactory.swift
//  Grammar
//
//  Created by TuanAnh on 11/7/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit
import FMDB

class DAOFactory: NSObject {
    
    private let filePath: String
    static let dbName = "gm.sqlite"
    
    override init() {
        self.filePath = DAOFactory.databaseFilePath()
        super.init()
        copyDatabaseIfNeeded()
        
        // For debug
        print(self.filePath)
    }
    
    func copyDatabaseIfNeeded() {
        //Using NSFileManager we can perform many file system operations.
        let fileManager = FileManager.default
        let dbPath: String = filePath
        
        let defaultDBPath: String? = Bundle.main.path(forResource: "gm", ofType: "sqlite")
        if fileManager.fileExists(atPath: dbPath)
        {
            return
        }
        if defaultDBPath == nil {
            print("defaultDBPath Error!")
            return;
        }
        do {
            try fileManager.copyItem(atPath:defaultDBPath! , toPath: dbPath)
        } catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
    
    func lessonDAO() -> LessonDAO? {
        if let db = connect() {
            return LessonDAO(db: db)
        }
        
        return nil
    }
    
    func questionDAO() -> QuestionDAO? {
        if let db = connect() {
            return QuestionDAO(db: db)
        }
        
        return nil
    }
    
    func grammarDAO() -> GrammarDAO? {
        if let db = connect() {
            return GrammarDAO(db: db)
        }
        
        return nil
    }
    
    init(filePath: String) {
        self.filePath = filePath
        super.init()
    }
    
    private func connect() -> FMDatabase? {
        let db = FMDatabase(path: self.filePath)
        return (db.open()) ? db : nil
    }
    
    private static func databaseFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let dir   = paths[0] as NSString
        return dir.appendingPathComponent(DAOFactory.dbName)
    }

}
