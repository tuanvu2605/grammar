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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List Lesson"
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
