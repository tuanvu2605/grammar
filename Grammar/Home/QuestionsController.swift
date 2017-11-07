//
//  QuestionsController.swift
//  Grammar
//
//  Created by TuanAnh on 11/7/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit

class QuestionsController: BaseTableViewController {

    @IBOutlet weak var tblQuestions: UITableView!
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



}

extension QuestionsController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:questionCellId , for: indexPath) as! QuestionCell
        cell.selectionStyle = .none
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
    }
}
