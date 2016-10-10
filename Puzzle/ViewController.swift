//
//  ViewController.swift
//  Puzzle
//
//  Created by Tung on 10/10/2016.
//  Copyright © 2016 iMpression. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainView: MainView!
    @IBOutlet weak var whiteView: SquareView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.blankView = whiteView
    }

    
}

