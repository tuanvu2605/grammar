//
//  QuestionCell.swift
//  Grammar
//
//  Created by TuanAnh on 11/7/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit
import DLRadioButton

class QuestionCell: UITableViewCell {

    @IBOutlet weak var lblQuestion: UILabel!
    
    @IBOutlet weak var lblAnswerA: UILabel!
    
    @IBOutlet weak var lblAnswerB: UILabel!
    
    @IBOutlet weak var lblAnswerC: UILabel!
    
    @IBOutlet weak var lblAnswerD: UILabel!
    
    
    @IBOutlet weak var btnA: DLRadioButton!
    @IBOutlet weak var btnB: DLRadioButton!
    @IBOutlet weak var btnC: DLRadioButton!
    @IBOutlet weak var btnD: DLRadioButton!
    
    let indicatorColor = "#8cdd00"
    
    
    var listAnswerTitle = [UILabel]() ;
    var listAnswer = ["Duis aute irure dolor in reprehenderit ","Duis aute irure dolor in reprehenderit ","Duis aute irure ","Duis aute "]
    var listButtons = [DLRadioButton]();
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        listAnswerTitle = [lblAnswerA,lblAnswerB,lblAnswerC,lblAnswerD]
        self.lblQuestion.text = "10. Lorem ipsum dolor sit amet, consectetur adipisicing elit,"
        listButtons = [btnA,btnB,btnC,btnD]
        
        
        for i in 0..<listButtons.count
        {
            let btn = listButtons[i]
            btn.iconSize = 22;
            btn.indicatorSize = 14;
            btn.indicatorColor = UIColor(indicatorColor)!
            btn.iconColor = UIColor(indicatorColor)!
            btn.backgroundColor = .clear
            
        }
        if listAnswerTitle.count == listAnswer.count {
            for i in 0..<listAnswer.count
            {
               let l = listAnswerTitle[i]
                l.text = listAnswer[i];
            }
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
