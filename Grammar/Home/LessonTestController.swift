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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List Lesson"
        tblListTest.backgroundColor = UIColor.groupTableViewBackground
        tblListTest.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tblListTest.register(UINib(nibName: "CheckBoxCell", bundle: nil), forCellReuseIdentifier: lessonTestCellId)
        tblListTest.delegate = self;
        tblListTest.dataSource = self;
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

extension LessonTestController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:lessonTestCellId , for: indexPath) as! CheckBoxCell
        cell.title.text = "List Lesson"
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
