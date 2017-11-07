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
            let lessonTestController = LessonTestController(nibName: "LessonTestController", bundle: nil)
            self.navigationController?.pushViewController(lessonTestController, animated: true)
        case 2:
            let lessonsController =  LessonsController(nibName: "LessonsController", bundle: nil)
            self.navigationController?.pushViewController(lessonsController, animated: true)
        case 3:
            let questionsController =  QuestionsController(nibName: "QuestionsController", bundle: nil)
            self.navigationController?.pushViewController(questionsController, animated: true)
        default:
            print("index not fount")
        }
    }
    
}
