//
//  MainView.swift
//  Puzzle
//
//  Created by Tung on 10/10/2016.
//  Copyright © 2016 iMpression. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    var blankView:SquareView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        
        self.backgroundColor = .white
        // Set border style
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 5
        
        // Set autoresizingMask and clipToBounds
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.clipsToBounds = true
    }
}
