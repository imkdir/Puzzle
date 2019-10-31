//
//  BlockView.swift
//  Puzzle
//
//  Created by Tung CHENG on 10/10/2016.
//  Copyright © 2016 Objective CHENG. All rights reserved.
//

import UIKit

let squareSize:CGFloat = 60.0

@IBDesignable
final class BlockView: UIView {
    
    override func draw(_ rect: CGRect) {
        let border = UIBezierPath(rect: rect)
        border.lineWidth = 2
        UIColor.systemBackground.setStroke()
        border.stroke()
    }
}

extension BlockView {
    
    enum Direction: Int { case left, right, up, down }
    
    func move(toward direction: Direction, withDuration duration: TimeInterval, options: UIView.AnimationOptions) {

        guard let next = self.findAdjacentViewAt(direction) else { return }
        
        UIView.animate(withDuration: duration, delay: 0.0, options: options, animations: {
            switch direction {
            case .left:
                next.center.x = self.center.x
                self.center.x -= squareSize
            case .right:
                next.center.x = self.center.x
                self.center.x += squareSize
            case .up:
                next.center.y = self.center.y
                self.center.y -= squareSize
            case .down:
                next.center.y = self.center.y
                self.center.y += squareSize
            }
        })
    }
    
    private func findAdjacentViewAt(_ direction: Direction) -> BlockView? {
        var target = self.center
        switch direction {
        case  .left: target.x -= squareSize
        case .right: target.x += squareSize
        case  .down: target.y += squareSize
        case    .up: target.y -= squareSize
        }
        let cardViews = superview!.subviews as! [BlockView]
        return cardViews.first(where: { $0.frame.contains(target) })
    }
}
