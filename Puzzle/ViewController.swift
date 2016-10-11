//
//  ViewController.swift
//  Puzzle
//
//  Created by Tung on 10/10/2016.
//  Copyright © 2016 iMpression. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let duration:TimeInterval = 0.5
    
    @IBOutlet weak var mainView: MainView!
    @IBOutlet weak var whiteView: SquareView!
    @IBOutlet var buttons: [UIButton]!

    @IBAction func move(_ sender: UIButton) {
        guard let title = sender.title(for: .normal),
                let direction = SquareView.Direction(rawValue:title) else {
            return
        }
        self.whiteView.LRUD_animate(toward: direction, withDuration: duration, options: [])
        self.disableButtonsForOneSecond()
    }
    
    private func disableButtonsForOneSecond() {
        UIView.animate(withDuration: duration/2.0, animations: {
            for button in self.buttons { button.alpha = 0.8 }
            }, completion: { finished in
                UIView.animate(withDuration: self.duration/2.0, animations: {
                    for button in self.buttons { button.alpha = 1.0 }
                })
        })
    }
}
