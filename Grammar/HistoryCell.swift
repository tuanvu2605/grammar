//
//  HistoryCell.swift
//  Grammar
//
//  Created by TuanAnh on 11/14/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblTestName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        lblTime.adjustsFontSizeToFitWidth = true
        lblScore.adjustsFontSizeToFitWidth = true
        lblTestName.adjustsFontSizeToFitWidth = true
    }
    func display_(history : History)
    {
        self.lblTime.text = history.timeDate;
        self.lblTestName.text = history.title
        self.lblScore.text = history.score
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
