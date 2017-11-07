//
//  CheckBoxCell.swift
//  Grammar
//
//  Created by TuanAnh on 11/7/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit
import BEMCheckBox

class CheckBoxCell: UITableViewCell {

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
        

       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
