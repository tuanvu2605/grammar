//
//  HomeController.swift
//  Grammar
//
//  Created by TuanAnh on 11/6/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit

class HomeController: BaseTableViewController {

    @IBOutlet weak var tblList: UITableView!
    var listOption : [Any] = [Any]();
    let homeCellID = "homeCellID"
    let controllerTitle = "English Grammar"
    var listTitle = ["Lesson", "Test Full" , "Test Components" , "My Tests","Study History" , "Contact Support"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tblList.delegate = self;
        tblList.dataSource  = self;
        tblList.backgroundColor = UIColor.groupTableViewBackground
        tblList.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tblList.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: homeCellID)
        tblList.separatorStyle = .none
        self.title = controllerTitle

    }




}

extension HomeController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return listTitle.count;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:homeCellID , for: indexPath) as! TitleCell
        cell.title.text = listTitle[indexPath.section]
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        switch indexPath.section {
        case 0:
            let listLessonController = ListLessonController(nibName: "ListLessonController", bundle: nil)
            self.navigationController?.pushViewController(listLessonController, animated: true)
        case 1:
            var listGr = [Grammar]()
            for l in AppModel.shareModel.lessons
            {
                listGr.append(contentsOf: l.grammars)
            }
            let questionController = QuestionsController(nibName: "QuestionsController", bundle: nil)
            questionController.listGrammar = listGr;
            questionController.title = "Test Full"
            questionController.listQuestions = self.getAllQuestionForTestFull()
            self.navigationController?.pushViewController(questionController, animated: true)
        case 2:
            let lessonsTestController =  LessonTestController(nibName: "LessonTestController", bundle: nil)
            self.navigationController?.pushViewController(lessonsTestController, animated: true)
        case 3:
            let questionsController =  QuestionsController(nibName: "QuestionsController", bundle: nil)
            self.navigationController?.pushViewController(questionsController, animated: true)
        default:
            print("index not fount")
        }
    }
    
}

extension HomeController
{
    func getAllQuestionForTestFull()->[Question]
    {
        var listQues = [Question]()
        for lesson  in  AppModel.shareModel.lessons
        {
            for gr in lesson.grammars
            {
                let max = (UInt32)(gr.questions.count);
                let r = Int(arc4random_uniform(max))
                print("max : \(max) r : \(r) , g id : \(gr.id_)")
                let q = gr.questions[r]
                listQues.append(q)
            }
        }
        return listQues;
    }
}
