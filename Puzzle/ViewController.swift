//
//  ViewController.swift
//  Puzzle
//
//  Created by Tung on 10/10/2016.
//  Copyright © 2016 iMpression. All rights reserved.
//

import UIKit

let standardValue:CGFloat = 8.0

class ViewController: UIViewController {
    
    private enum Direction: String {
        case Left = "L"
        case Right = "R"
        case Up = "U"
        case Down = "D"
        
        func limit() -> CGFloat {
            switch self {
            case .Left, .Up:
                return standardValue + squareSize * 0.5
            case .Right, .Down:
                return standardValue + squareSize * 3.5
            }
        }
    }

    @IBOutlet weak var mainView: MainView!
    @IBOutlet weak var whiteView: SquareView!
    
    var whiteViewCenter:CGPoint = .zero // for test
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        
        whiteViewCenter = whiteView.center
    }

    @IBAction func move(_ sender: UIButton) {
        guard let title:String = sender.title(for: .normal),
                let direction = Direction(rawValue:title) else {
            abort() // should never happen
        }
        if isPossibleToMoveTo(direction) {
            var point = CGPoint.zero
            switch direction {
            case .Left:
                let tag = 1000 + 4 * (Int(self.whiteView.center.y)/60) + Int(self.whiteView.center.x)/60 - 1
                let adjacent = self.mainView.viewWithTag(tag) as! SquareView
                UIView.animate(withDuration: 1.0, animations: {
                    adjacent.center.x = self.whiteView.center.x
                    self.whiteView.center.x -= squareSize
                    }, completion: { finished in
                        self.swapTwoInts(&self.whiteView.tag, &adjacent.tag)
                })
                point.x = whiteViewCenter.x - squareSize
                print("whiteView's center.x should be \(point.x)")
                whiteViewCenter.x = point.x
            case .Right:
                let tag = 1000 + 4 * (Int(self.whiteView.center.y)/60) + Int(self.whiteView.center.x)/60 + 1
                let adjacent = self.mainView.viewWithTag(tag) as! SquareView
                UIView.animate(withDuration: 1.0, animations: {
                    adjacent.center.x = self.whiteView.center.x
                    self.whiteView.center.x += squareSize
                    }, completion: { finished in
                        self.swapTwoInts(&self.whiteView.tag, &adjacent.tag)
                })
                point.x = whiteViewCenter.x + squareSize
                print("whiteView's center.x should be \(point.x)")
                whiteViewCenter.x = point.x
            case .Up:
                let tag = 1000 + 4 * (Int(self.whiteView.center.y)/60 - 1) + Int(self.whiteView.center.x)/60
                let adjacent = self.mainView.viewWithTag(tag) as! SquareView
                UIView.animate(withDuration: 1.0, animations: {
                    adjacent.center.y = self.whiteView.center.y
                    self.whiteView.center.y -= squareSize
                    }, completion: { finished in
                        self.swapTwoInts(&self.whiteView.tag, &adjacent.tag)
                })
                point.y = whiteViewCenter.y - squareSize
                print("whiteView's center.y should be \(point.y)")
                whiteViewCenter.y = point.y
            case .Down:
                let tag = 1000 + 4 * (Int(self.whiteView.center.y)/60 + 1) + Int(self.whiteView.center.x)/60
                let adjacent = self.mainView.viewWithTag(tag) as! SquareView
                UIView.animate(withDuration: 1.0, animations: {
                    adjacent.center.y = self.whiteView.center.y
                    self.whiteView.center.y += squareSize
                    }, completion: { finished in
                        self.swapTwoInts(&self.whiteView.tag, &adjacent.tag)
                })
                point.y = whiteViewCenter.y + squareSize
                print("whiteView's center.y should be \(point.y)")
                whiteViewCenter.y = point.y
            }
        } else {
            // TODO: Add swizzling animation to alert
        }
    }
    
    // TODO: Factory methods provides Group Animation for SquareView
    private func animationTo(_ direction: Direction) -> CAAnimationGroup {
        return CAAnimationGroup()
    }
    
    
    private func isPossibleToMoveTo(_ direction:Direction) -> Bool {
        switch direction {
        // FIXME: Remember change back to whiteView.center.x
        case .Left:
            return whiteViewCenter.x > direction.limit()
        case .Right:
            return whiteViewCenter.x < direction.limit()
        case .Up:
            return whiteViewCenter.y > direction.limit()
        case .Down:
            return whiteViewCenter.y < direction.limit()
        }
    }
    
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
}

