//
//  ResultController.swift
//  Grammar
//
//  Created by TuanAnh on 11/8/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit

class ResultController: BaseTableViewController {

    @IBOutlet weak var tblResult: UITableView!
    @IBOutlet weak var btnReview: UIButton!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    
    let failColor = "#f49f9f"
    let successColor = "#9ff39f"
    
    var questionController  : QuestionsController?
    let resultCellId = "resultCellId"
    var listQuestion = [Question]()
    var result = [(grammar : Grammar , numQuestion : Int , numCorrect : Int)]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Test Result"
        tblResult.backgroundColor = UIColor.groupTableViewBackground
        tblResult.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tblResult.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: resultCellId)
        tblResult.delegate = self;
        tblResult.dataSource = self;
        configureUI()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var total = 0
        var correct = 0
        for t in result
        {
            total = total + t.numQuestion
            correct = correct + t.numCorrect
            
        }
        self.lblResult.text = "Total \(correct)/\(total)"
        if correct == total
        {
           self.lblMessage.text = "Congratulation! You have passed all lesson!"
        }else
        {
            self.lblMessage.text = "You have to learn again!"
        }
    }
    
    func configureUI()
    {
        self.btnReview.layer.cornerRadius = 5.0
        let btnBack = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(backButtonDidTap))
        btnBack.tintColor = .white
        navigationItem.leftBarButtonItem = btnBack
    }
    
    func backButtonDidTap()
    {
        self.navigationController?.popViewController(animated: true)
    }



    @IBAction func btnReviewDidTap(_ sender: Any) {
        questionController?.isEnableReviewButton = true
       self.navigationController?.popViewController(animated: true)
    }
    
}

extension ResultController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return result.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:resultCellId , for: indexPath) as! TitleCell
        let r = result[indexPath.section]
        cell.title.text = "Lesson \(r.grammar.lesson_id!)_ \(r.grammar.title) : \(r.numCorrect)/\(r.numQuestion)"
        cell.title.textColor = .black
        if r.numCorrect == r.numQuestion {
            cell.viewContent.backgroundColor = UIColor(successColor)
        }else
        {
          cell.viewContent.backgroundColor = UIColor(failColor)
        }
        return cell;
    }
    
}


