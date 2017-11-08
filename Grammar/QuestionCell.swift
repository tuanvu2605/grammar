//
//  QuestionCell.swift
//  Grammar
//
//  Created by TuanAnh on 11/7/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit
import DLRadioButton


protocol QuestionCellDelegate {
    func questionCellDidChooseAnswer(cell: QuestionCell , answer : Int)
}

class QuestionCell: UITableViewCell {

    var delegate : QuestionCellDelegate?

    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblAnswerA: UILabel!
    @IBOutlet weak var lblAnswerB: UILabel!
    @IBOutlet weak var lblAnswerC: UILabel!
    @IBOutlet weak var lblAnswerD: UILabel!
    
    @IBOutlet weak var btnA: HIRadioButton!
    @IBOutlet weak var btnB: HIRadioButton!
    @IBOutlet weak var btnC: HIRadioButton!
    @IBOutlet weak var btnD: HIRadioButton!
    
    let indicatorColor = "#8cdd00"
    
    
    var listAnswerTitle = [UILabel]() ;
    var listButtons = [DLRadioButton]();
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        listAnswerTitle = [lblAnswerA,lblAnswerB,lblAnswerC,lblAnswerD]
        btnA.tag = 1;
        btnB.tag = 2;
        btnC.tag = 3;
        btnD.tag = 4;
        btnA.delegate = self;
        btnB.delegate = self;
        btnC.delegate = self;
        btnD.delegate = self;
        
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
    }
    
    func display_(question : Question , index : Int , answer : Int)
    {
        lblQuestion.text = "\(index + 1). " + question.question;
        if listAnswerTitle.count == question.listAnswers.count
        {
            for i in 0 ..< question.listAnswers.count{
                let l = listAnswerTitle[i];
                l.text = question.listAnswers[i]
            }
        }
        
        if answer == 0 {
            for btn in listButtons
            {
                btn.isSelected = false;
            }
        }else
        {
            let btn = listButtons[answer]
            btn.isSelected = true
            btn.deselectOtherButtons()
        }
    }

    
}

extension QuestionCell : HIRadioButtonDelegate
{
    func buttonDidTap(sender: HIRadioButton) {
        print("Radio button touchUpInside \(sender.tag)");
        delegate?.questionCellDidChooseAnswer(cell: self, answer: sender.tag)
    }
}
