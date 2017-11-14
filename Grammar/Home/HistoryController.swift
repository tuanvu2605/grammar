//
//  HistoryController.swift
//  Grammar
//
//  Created by TuanAnh on 11/14/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit

class HistoryController: BaseTableViewController {

    @IBOutlet weak var tblHistory: UITableView!
    let historyCellId  = "historyCellId"
    var listHistory  = [History]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title  = "Test History"
        tblHistory.backgroundColor = UIColor.groupTableViewBackground
        tblHistory.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tblHistory.register(UINib(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: historyCellId)
        tblHistory.delegate = self;
        tblHistory.dataSource = self;
        configueUI()
        self.listHistory  = AppModel.shareModel.historyDAO.loadHistories()
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

extension HistoryController
{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return listHistory.count;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:historyCellId , for: indexPath) as! HistoryCell
        let h = listHistory[indexPath.section]
        cell.display_(history : h)
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
    }
}
