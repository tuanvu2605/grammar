//
//  ContentCell.swift
//  Grammar
//
//  Created by TuanAnh on 11/7/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit
import MDHTMLLabel

class ContentCell: UITableViewCell {

    @IBOutlet weak var lblContent: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func display_(grammar : Grammar)
    {
        lblContent.setHtml(grammar.content)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
