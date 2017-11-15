//
//  LessonTestController.swift
//  Grammar
//
//  Created by TuanAnh on 11/7/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit

class LessonTestController: BaseTableViewController {

    @IBOutlet weak var tblListTest: UITableView!
    let lessonTestCellId = "lessonTestCellId"
    var listLesson = [Lesson]()
    var listChecked = [Bool]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List Lesson"
        tblListTest.backgroundColor = UIColor.groupTableViewBackground
        tblListTest.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tblListTest.register(UINib(nibName: "CheckBoxCell", bundle: nil), forCellReuseIdentifier: lessonTestCellId)
        tblListTest.delegate = self;
        tblListTest.dataSource = self;
        listLesson = AppModel.shareModel.lessons
        listChecked = listLesson.map({ (l) -> Bool in
            return false
        })
        tblListTest.reloadData()
        configueUI()

        // Do any additional setup after loading the view.
    }
    
    func configueUI()
    {
        // custom back button
        let btnBack = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(backButtonDidTap))
        btnBack.tintColor = .white
        navigationItem.leftBarButtonItem = btnBack
        
        let selectedDone = UIBarButtonItem(image:#imageLiteral(resourceName: "checkmark"), style: .plain, target: self, action: #selector(buttonSelectedDoneDidTap))
        selectedDone.tintColor = .white
        navigationItem.rightBarButtonItem = selectedDone
    }
    
    func buttonSelectedDoneDidTap()
    {
       
        let questionController = QuestionsController(nibName: "QuestionsController", bundle: nil)
        var listLesson_ = [Lesson]()
        for i in 0 ..< listChecked.count
        {
            if listChecked[i]
            {
               listLesson_.append(self.listLesson[i])
            }
        }
        if listQuestionsForTest(listLesson: listLesson_).gr.count > 0 {
            questionController.listQuestions = listQuestionsForTest(listLesson: listLesson_).ques
            questionController.listGrammar = listQuestionsForTest(listLesson: listLesson_).gr
            questionController.listAnswers = questionController.listQuestions.map({ (q) -> Int in
                return 0;
            })
            questionController.title = "Test Component"
            questionController.type = .component
            AppModel.shareModel.history?.title = "Test Component (\(listLesson_.count))"
            self.navigationController?.pushViewController(questionController, animated: true)
        }
        
    }
    
    func backButtonDidTap()
    {
        self.navigationController?.popViewController(animated: true)
        if (AppModel.shareModel.history?.isReviewed)! {
            AppModel.shareModel.historyDAO.savehistory(his: AppModel.shareModel.history!)
            AppModel.shareModel.history = nil;
        }
        
    }



}

extension LessonTestController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listLesson.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:lessonTestCellId , for: indexPath) as! CheckBoxCell
        let lesson = listLesson[indexPath.row]
        let isCheck = listChecked[indexPath.row]
        cell.display_(lesson: lesson, isSelect: isCheck)
        cell.delegate = self
        cell.selectionStyle = .none
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
    }
}

extension LessonTestController : CheckBoxCellDelegate
{
    func cellDidTapCheckBox(cell: CheckBoxCell, isSelected: Bool) {
        let idx = self.tblListTest.indexPath(for: cell)
        listChecked[(idx?.row)!] = isSelected;
    }
}

extension LessonTestController
{
    func listQuestionsForTest(listLesson : [Lesson]) ->  (ques : [Question] , gr : [Grammar])
    {
        var listQuestion = [Question]()
        var listGrammar = [Grammar]()
        let numQuestionGrammar = listLesson.count < 3 ? 5 : (listLesson.count < 7 ? 4 :(listLesson.count < 10 ? 3 : (listLesson.count < 14 ? 2 : 1)))
        for l in listLesson
        {
            for gr in l.grammars
            {
                var countQues = 0;
                for q in gr.questions
                {
                    if q.status == 0 || q.status == 1
                    {
                        listQuestion.append(q)
                        countQues = countQues + 1;
                        if countQues >= numQuestionGrammar
                        {
                            break;
                        }
                        
                    }
                    if countQues > 0 && !listGrammar.contains(gr)
                    {
                        listGrammar.append(gr)
                    }
                }
            }
        }
        return (listQuestion,listGrammar)
    }
}
