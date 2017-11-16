//
//  StudyHistoryController.swift
//  Grammar
//
//  Created by TuanAnh on 11/16/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit

class StudyHistoryController: BaseTableViewController {

    @IBOutlet weak var tblStudyHistory: UITableView!
    var listLession = [Lesson]()
    let studyHistoryCellId = "studyHistoryCell"
    override func viewDidLoad() {
        super.viewDidLoad()

        self.listLession = AppModel.shareModel.lessons;
        
        
        self.title = "Study History"
        tblStudyHistory.backgroundColor = UIColor.groupTableViewBackground
        tblStudyHistory.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tblStudyHistory.register(UINib(nibName: "StudyHistoryCell", bundle: nil), forCellReuseIdentifier: studyHistoryCellId)
        tblStudyHistory.delegate = self;
        tblStudyHistory.dataSource = self;
        
        tblStudyHistory.estimatedRowHeight = 300;
        tblStudyHistory.rowHeight = UITableViewAutomaticDimension
        configueUI()
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
extension StudyHistoryController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return listLession.count;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:studyHistoryCellId , for: indexPath) as! StudyHistoryCell
        let l = listLession[indexPath.section]
        cell.display(index: indexPath.section, lesson: l)
        return cell;
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        let lesson = listLession[indexPath.section];
        let grammarController = GrammarsController(nibName: "GrammarsController", bundle: nil)
        grammarController.title = lesson.title
        grammarController.grammars = lesson.grammars
        self.navigationController?.pushViewController(grammarController, animated: true)
        
    }
}
