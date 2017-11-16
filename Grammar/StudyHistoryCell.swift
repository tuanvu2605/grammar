//
//  StudyHistoryCell.swift
//  Grammar
//
//  Created by TuanAnh on 11/16/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit

class StudyHistoryCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblComponent: UILabel!
    @IBOutlet weak var viewContent: UIView!
    
    let failColor = "#f49f9f"
    let successColor = "#9ff39f"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        // Initialization code
    }
    
    func display(index : Int , lesson : Lesson)
    {
        lblTitle.text = "\(index + 1).\(lesson.title)"
        
        var component = String()
        var check = true;
        for i in 0 ..< lesson.grammars.count {
            let g = lesson.grammars[i]
            if i == lesson.grammars.count
            {
                component = component + " - " +  g.title
            }else
            {
                component =   component + " - " + g.title + "\n"
            }
            for q in g.questions
            {
                if q.status != 2
                {
                    check = false
                }
            }
        }
        self.lblComponent.text = component
        viewContent.backgroundColor = check ?  UIColor(successColor) :  UIColor(failColor)
    }


}
