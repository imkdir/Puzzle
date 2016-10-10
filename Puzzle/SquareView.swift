//
//  SquareView.swift
//  Puzzle
//
//  Created by Tung on 10/10/2016.
//  Copyright © 2016 iMpression. All rights reserved.
//

import UIKit

@IBDesignable
class SquareView: UIView {
    
    @IBInspectable
    var borderColor: UIColor = .white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 1 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
