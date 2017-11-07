//
//  TitleCell.swift
//  Grammar
//
//  Created by TuanAnh on 10/30/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
       
        super.awakeFromNib()
//        self.viewContent.layer.cornerRadius = 6.0
        self.backgroundColor = .clear
      
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        let shadowPath = UIBezierPath(rect: bounds)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.1)
        layer.shadowOpacity = 0.15
        layer.shadowPath = shadowPath.cgPath
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
