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
}

class QuestionsController: BaseTableViewController {

    @IBOutlet weak var tblQuestions: UITableView!
    var listQuestions = [Question]()
    var type : QuestionType?
    var listAnswers = [Int]()
    let questionCellId = "questionCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblQuestions.backgroundColor = UIColor.groupTableViewBackground
        tblQuestions.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tblQuestions.register(UINib(nibName: "QuestionCell", bundle: nil), forCellReuseIdentifier: questionCellId)
        tblQuestions.delegate = self;
        tblQuestions.dataSource = self;
        tblQuestions.estimatedRowHeight = 300;
        tblQuestions.rowHeight = UITableViewAutomaticDimension
        listAnswers = listQuestions.map({ (q) -> Int in
            return 0;
        })
        configueUI()

        // Do any additional setup after loading the view.
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
    }


    @IBAction func checkResultButtonDidTap(_ sender: UIButton) {
        
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
            let navi = UINavigationController(rootViewController: resultController)
            
            var result  = [(ques : Question , answer : Int)]()
            for i in 0 ..< listQuestions.count
            {
                result.append((ques:listQuestions[i] ,answer:listAnswers[i]))
            }
            
            let filter = self.filterResult(type: .full, listGrammar: [], listQuestion: result)
            resultController.result = filter
            self.present(navi, animated: true, completion: nil)
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
        cell.display_(question: ques , index: indexPath.section , answer: answer)
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
    }
    
    
    
    
    
    
}

extension QuestionsController
{
    func filterResult(type : QuestionType , listGrammar :[Grammar],  listQuestion : [(ques : Question , answer : Int)]) -> [(grammar : Grammar , numQuestion : Int , numCorrect : Int)]
    {
        var filter = [(grammar : Grammar , numQuestion : Int , numCorrect : Int)]()
        
        // full
        if type == .full {
            for l in AppModel.shareModel.lessons
            {
                for gr in l.grammars
                {
                    let temp = listQuestion.filter({ $0.ques.grammar_id == gr.index_in_lesson && $0.ques.lesson_id == l.id_})
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
                    let elementFilter = ((grammar : gr , numQuestion : temp.count , numCorrect : numCorrect))
                    filter.append(elementFilter)
                }
            }
        }
        
        //component
        
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
