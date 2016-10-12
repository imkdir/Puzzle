//
//  ViewController.swift
//  Puzzle
//
//  Created by Tung on 10/10/2016.
//  Copyright © 2016 iMpression. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let recordBoard = RecordBoard(frame: boardFrame)
    
    @IBOutlet weak var mainView: MainView!
    @IBOutlet weak var whiteView: SquareView!
    @IBOutlet var buttons: [UIButton]!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(recordBoard)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(_:)))
        self.view.gestureRecognizers = [pan]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.pullDownRecordBoardWithCompletion(nil)
    }

    //MARK: - IBAction
    @IBAction func move(_ sender: UIButton) {
        guard let title = sender.title(for: .normal),
                let direction = SquareView.Direction(rawValue:title) else {
            return
        }
        recordBoard.paths.append(title)
        self.whiteView.LRUD_animate(toward: direction, withDuration: duration, options: [])
        self.disableButtonsForOneSecond()
    }
    
    @IBAction func refreshGame(_ sender: UIBarButtonItem) {
        UIView.animate(withDuration: duration, animations: {
            self.refreshMainView()
            }, completion: nil)
    }
    
    //MARK: - GestureRecognizers
    func handlePan(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            gesture.isEnabled = false
            self.recordBoard.startGradientAnimation()
            self.pullDownRecordBoardWithCompletion({ finished in
                gesture.isEnabled = true
            })
        default:
            break
        }
    }
    
    //MARK: - Helper Methods
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
        
        recordBoard.paths.removeAll()
    }
    
    private func pullDownRecordBoardWithCompletion(_ completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseOut], animations: {
            self.recordBoard.center.y += 64.0
            }, completion: { finished in
                UIView.animate(withDuration: 0.2, delay: 1.5, options: [.curveEaseIn], animations: {
                    self.recordBoard.center.y -= 64.0
                    }, completion: { finished in
                        completion?(finished)
                })
        })
    }
    
    let duration:TimeInterval = 0.5
    static let boardFrame = CGRect(x:0.0, y:0.0, width:UIScreen.main.bounds.size.width, height:68.0)
}
