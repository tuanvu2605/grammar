//
//  QuestionsController.swift
//  Grammar
//
//  Created by TuanAnh on 11/7/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit

enum QuestionType {
    case full
    case component
    case history
}

class QuestionsController: BaseTableViewController {

    @IBOutlet weak var tblQuestions: UITableView!
    var listQuestions = [Question]()
    var type : QuestionType?
    var listAnswers = [Int]()
    var listGrammar = [Grammar]()
    let questionCellId = "questionCellId"
    var isEnableReviewButton = Bool()
    var isEnableReviewMode = Bool()
    var btnReview : UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblQuestions.backgroundColor = UIColor.groupTableViewBackground
        tblQuestions.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tblQuestions.register(UINib(nibName: "QuestionCell", bundle: nil), forCellReuseIdentifier: questionCellId)
        tblQuestions.delegate = self;
        tblQuestions.dataSource = self;
        tblQuestions.estimatedRowHeight = 300;
        tblQuestions.rowHeight = UITableViewAutomaticDimension
        configueUI()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isEnableReviewButton
        {
            self.btnReview = UIBarButtonItem(image:#imageLiteral(resourceName: "CheckList"), style: .plain, target: self, action: #selector(enableReviewMode))
            self.btnReview?.tintColor = .white
            navigationItem.rightBarButtonItem = btnReview
        }else
        {
           navigationItem.rightBarButtonItems = []
        }
    }
    
    func enableReviewMode()
    {
        isEnableReviewMode = true
        self.tblQuestions.reloadData()
    }
    func configueUI()
    {
        // custom back button
        let btnBack = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(backButtonDidTap))
        btnBack.tintColor = .white
        navigationItem.leftBarButtonItem = btnBack
        
    }
    
    func backButtonDidTap()
    {
        self.navigationController?.popViewController(animated: true)
        if type == .full && (AppModel.shareModel.history?.isReviewed)!
        {
            AppModel.shareModel.historyDAO.savehistory(his: AppModel.shareModel.history!)
            AppModel.shareModel.history = nil;
        }
        if type == .history && (AppModel.shareModel.history?.isReviewed)!
        {
            AppModel.shareModel.historyDAO.updateHistory(his: AppModel.shareModel.history!)
           AppModel.shareModel.history = nil;
        }
    }


    @IBAction func checkResultButtonDidTap(_ sender: UIButton) {
        AppModel.shareModel.history?.isReviewed = true
        
        var count = 0
        for i in 0 ..< listAnswers.count
        {
            if (listAnswers[i] == 0){
               
                count = count + 1
            }
        }
        func presentResult()
        {
            let resultController = ResultController(nibName: "ResultController", bundle: nil)
            resultController.questionController = self
//            let navi = UINavigationController(rootViewController: resultController)
            
            var result  = [(ques : Question , answer : Int)]()
            for i in 0 ..< listQuestions.count
            {
                result.append((ques:listQuestions[i] ,answer:listAnswers[i]))
            }
            
            let filter = self.filterResult(listGrammar:listGrammar, listQuestion: result)
            resultController.result = filter
            self.navigationController?.pushViewController(resultController, animated: true)
        }
        
        
        if count != 0 {
            let mess = "You haven't answered \(count) question.\n Do you really want to hand in?"
            let alert = UIAlertController(title: nil, message: mess, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) in
                
            })
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                presentResult()
            })
            alert.addAction(ok)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }else{
            presentResult()
        }
    }
    
    
}

extension QuestionsController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return listQuestions.count;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:questionCellId , for: indexPath) as! QuestionCell
        let ques = listQuestions[indexPath.section]
        let answer = listAnswers[indexPath.section]
        cell.delegate = self
        cell.selectionStyle = .none
        if isEnableReviewMode
        {
            cell.displayReviewMode(question: ques , index: indexPath.section , answer: answer)
        }else
        {
          cell.display_(question: ques , index: indexPath.section , answer: answer)
        }
        
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
    }

}

extension QuestionsController
{
    func filterResult(listGrammar :[Grammar],  listQuestion : [(ques : Question , answer : Int)]) -> [(grammar : Grammar , numQuestion : Int , numCorrect : Int)]
    {
        var grammars  = [Grammar]()
        if listGrammar.count < 1 {
            let listGrIdAndLessonId : [(grID : Int , lessonId : Int)] = listQuestion.map { (arg0) -> (grID : Int  , lessonId : Int) in
                let (ques , _) = arg0
                return (ques.grammar_id , ques.lesson_id)
            }
            
            var uniList = [(grID : Int , lessonId : Int)]()
            for i in 0 ..< listGrIdAndLessonId.count
            {
                let e = listGrIdAndLessonId[i]
                if i == 0
                {
                    uniList.append(listGrIdAndLessonId[0])
                }else
                {
                    let check =  uniList.contains(where: { (arg0) -> Bool in
                        let (grID , lessonId) = arg0
                        return (grID == e.grID && lessonId == e.lessonId)
                    })
                    if !check
                    {
                        uniList.append(e)
                    }
                }
            }
            grammars = AppModel.shareModel.grammarDAO.loadGrammar(tuples: uniList)
        }else
        {
           grammars = listGrammar
        }
        
        var filter = [(grammar : Grammar , numQuestion : Int , numCorrect : Int)]()
        var totalCorrectAnswer = 0;
        for gr in grammars
        {
            let temp = listQuestion.filter({ $0.ques.grammar_id == gr.index_in_lesson && $0.ques.lesson_id == gr.lesson_id})
            var numCorrect = 0;
            for i in 0 ..< temp.count
            {
                let ques = temp[i].ques
                let ans = temp[i].answer
                if ques.correct_answer == ans
                {
                    numCorrect = numCorrect + 1
                }
            }
            totalCorrectAnswer = totalCorrectAnswer + numCorrect;
            let elementFilter = ((grammar : gr , numQuestion : temp.count , numCorrect : numCorrect))
            filter.append(elementFilter)
        }
        AppModel.shareModel.history?.score = "\(totalCorrectAnswer)/\(listQuestion.count)"
        AppModel.shareModel.history?.listQuestionAndAnswer = listQuestion;
        
        

        return filter;
    }
}

extension QuestionsController : QuestionCellDelegate
{
    func questionCellDidChooseAnswer(cell: QuestionCell, answer: Int) {
        let ipath = tblQuestions.indexPath(for: cell)
        listAnswers[(ipath?.section)!] = answer
    }
    
    
}
