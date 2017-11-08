//
//  HIRadioButton.swift
//  Grammar
//
//  Created by TuanAnh on 11/8/17.
//  Copyright © 2017 tuananh. All rights reserved.
//

import UIKit
import DLRadioButton

protocol HIRadioButtonDelegate {
    func buttonDidTap(sender : HIRadioButton)
}

class HIRadioButton: DLRadioButton {
    var delegate : HIRadioButtonDelegate?
    
    override func touchUpInside()
    {
        super.touchUpInside()
        delegate?.buttonDidTap(sender: self)
    }

}
