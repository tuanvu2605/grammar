//
//  QuestionCell.swift
//  Grammar
//
//  Created by TuanAnh on 11/7/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit
import DLRadioButton
import MDHTMLLabel


protocol QuestionCellDelegate {
    func questionCellDidChooseAnswer(cell: QuestionCell , answer : Int)
}

class QuestionCell: UITableViewCell {

    var delegate : QuestionCellDelegate?

    @IBOutlet weak var lblQuestion: MDHTMLLabel!
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
    
    
    let failColor = "#f49f9f"
    let successColor = "#9ff39f"

    
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
            btn.indicatorSize = 12;
            btn.indicatorColor = UIColor(indicatorColor)!
            btn.iconColor = UIColor(indicatorColor)!
            btn.backgroundColor = .clear
            
        }
    }
    
    func display_(question : Question , index : Int , answer : Int)
    {
        lblQuestion.htmlText = "\(index + 1). " + question.question;
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
            let btn = listButtons[answer-1]
            btn.isSelected = true
            btn.deselectOtherButtons()
        }
    }
    
    func displayReviewMode(question : Question , index : Int , answer : Int)
    {
        print("question answer : \(question.correct_answer) user answer \(answer)")
        lblQuestion.htmlText = "\(index + 1). " + question.question;
        if listAnswerTitle.count == question.listAnswers.count
        {
            for i in 0 ..< question.listAnswers.count{
                let l = listAnswerTitle[i];
                l.text = question.listAnswers[i]
            }
        }
        let correct = question.correct_answer!
        if answer == 0
        {
            for btn in listButtons
            {
                btn.isSelected = false;
                btn.indicatorColor = UIColor(indicatorColor)!
                btn.iconColor = UIColor(indicatorColor)!
            }
            let button = listButtons[correct - 1]
            button.isSelected = true
            button.indicatorColor = .blue
            button.iconColor = .blue
            button.deselectOtherButtons()
            
        }else
        {
            if correct == answer
            {
                
                let button = listButtons[correct - 1]
                button.isSelected = true
                button.indicatorColor = .blue
                button.iconColor = .blue
                button.deselectOtherButtons()
                for btn in listButtons
                {
                    if btn != button
                    {
                        btn.isSelected = false;
                        btn.indicatorColor = .white
                        btn.iconColor = UIColor(indicatorColor)!
                    }
                }
            }else
            {
                let buttonCorrect = listButtons[correct - 1]
                buttonCorrect.isSelected = true
                buttonCorrect.indicatorColor = .blue
                buttonCorrect.iconColor = .blue
                
                let buttonAnswer = listButtons[answer - 1]
                buttonAnswer.isSelected = true
                buttonAnswer.indicatorColor =  UIColor(indicatorColor)!
                buttonAnswer.iconColor =  UIColor(indicatorColor)!

                for btn in listButtons
                {
                    if btn != buttonCorrect && btn != buttonAnswer
                    {
                        btn.isSelected = false;
                        btn.indicatorColor = .white
                        btn.iconColor = UIColor(indicatorColor)!
                    }
                }
            }
        }
        
        
        
        
    }

    
}

extension QuestionCell : HIRadioButtonDelegate
{
    func buttonDidTap(sender: HIRadioButton) {
        print("Radio button touchUpInside \(sender.tag)");
        SoundManager.shared().playSound("Tock.caf")
   
        delegate?.questionCellDidChooseAnswer(cell: self, answer: sender.tag)
    }
}
