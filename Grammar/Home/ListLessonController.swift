//
//  ListLessonController.swift
//  Grammar
//
//  Created by TuanAnh on 11/6/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit

class ListLessonController: BaseTableViewController {

    @IBOutlet weak var tblListLesstion: UITableView!
    let listLessionId = "listLessionId"
    var listLession = [Lesson]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listLession = AppModel.shareModel.lessons;
        
        
        self.title = "List Lesson"
        tblListLesstion.backgroundColor = UIColor.groupTableViewBackground
        tblListLesstion.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tblListLesstion.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: listLessionId)
        tblListLesstion.delegate = self;
        tblListLesstion.dataSource = self;
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

extension ListLessonController
{

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.listLession.count;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:listLessionId , for: indexPath) as! TitleCell
        cell.title.text = "\(indexPath.section + 1)." + self.listLession[indexPath.section].title;
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
