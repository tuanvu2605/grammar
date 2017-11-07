//
//  GrammarsController.swift
//  Grammar
//
//  Created by TuanAnh on 11/7/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit

class GrammarsController: BaseTableViewController {
    
    @IBOutlet weak var tblGrammars: UITableView!
    let lessonCellId = "lessonCellId"
    var grammars = [Grammar]();
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblGrammars.backgroundColor = UIColor.groupTableViewBackground
        tblGrammars.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tblGrammars.register(UINib(nibName: "ContentCell", bundle: nil), forCellReuseIdentifier: lessonCellId)
        tblGrammars.delegate = self;
        tblGrammars.dataSource = self;
        tblGrammars.estimatedRowHeight = 300;
        tblGrammars.rowHeight = UITableViewAutomaticDimension
        
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

extension GrammarsController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return grammars.count;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:lessonCellId , for: indexPath) as! ContentCell
        let gr = grammars[indexPath.section]
        cell.display_(grammar : gr)
        cell.selectionStyle = .none
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
    }
}

