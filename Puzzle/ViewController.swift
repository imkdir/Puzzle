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

    @IBAction func move(_ sender: UIButton) {
        guard let title = sender.title(for: .normal),
                let direction = SquareView.Direction(rawValue:title) else {
            return
        }
        self.whiteView.LRUD_animate(toward: direction, withDuration: 1.0, options: [])
    }
}
