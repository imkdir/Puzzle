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
    
    @IBAction func refreshGame(_ sender: UIBarButtonItem) {
        UIView.animate(withDuration: duration, animations: {
            self.refreshMainView()
            }, completion: nil)
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
    
    private func refreshMainView() {
        
        func relocateWhiteViewTo(_ subView: UIView) {
            subView.backgroundColor = .white
            subView.layer.borderColor = UIColor.flatGray().cgColor
            subView.layer.borderWidth += 1.0
            self.whiteView = subView as! SquareView
        }
        
        let redSquareIndexs = [1, 4, 5, 8, 9, 12, 13]
        for subView in self.mainView.subviews {
            let index = subView.tag - 1000
            subView.layer.borderColor = UIColor.white.cgColor
            subView.layer.borderWidth = 1.0
            if index == 0 {
                relocateWhiteViewTo(subView)
            } else if redSquareIndexs.contains(index) {
                subView.backgroundColor = UIColor.carminePink()
            } else {
                subView.backgroundColor = UIColor.sanMarino()
            }
        }
    }
    
}
