//
//  CheckBoxCell.swift
//  Grammar
//
//  Created by TuanAnh on 11/7/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit
import BEMCheckBox

protocol CheckBoxCellDelegate {
    func cellDidTapCheckBox(cell : CheckBoxCell , isSelected : Bool)
}

class CheckBoxCell: UITableViewCell {

    var delegate : CheckBoxCellDelegate?
    @IBOutlet weak var checkBox: BEMCheckBox!
    let oncheckColor = "#8cdd00"

    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBox.lineWidth = 3.0
        checkBox.cornerRadius = 0.0
        checkBox.boxType = .square
        checkBox.onAnimationType = .fade
        checkBox.offAnimationType = .fade
        checkBox.animationDuration = 0.01
        checkBox.onCheckColor = UIColor(oncheckColor)!
        title.adjustsFontSizeToFitWidth = true
        checkBox.delegate = self;
    }
    
    func display_(lesson : Lesson , isSelect : Bool)
    {
       title.text = lesson.title
       checkBox.on = isSelect;
    }
}

extension CheckBoxCell : BEMCheckBoxDelegate
{
    func didTap(_ checkBox: BEMCheckBox) {
        self.delegate?.cellDidTapCheckBox(cell: self, isSelected: checkBox.on)
    }
}
