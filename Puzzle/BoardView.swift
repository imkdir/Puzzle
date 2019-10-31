//
//  BoardView.swift
//  Puzzle
//
//  Created by Tung CHENG on 10/10/2016.
//  Copyright © 2016 Objective CHENG. All rights reserved.
//

import UIKit

final class BoardView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 5
    }
}
