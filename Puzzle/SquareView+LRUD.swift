//
//  SquareView+LRUD.swift
//  Puzzle
//
//  Created by Tung on 11/10/2016.
//  Copyright © 2016 iMpression. All rights reserved.
//

import UIKit

let standardValue:CGFloat = 8.0

extension SquareView {
    
    enum Direction: String {
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
    
    func LRUD_animate(toward: Direction, withDuration duration: TimeInterval, options: UIViewAnimationOptions) {
        if !possibleToMove(toward) {
            self.flipAnimation(toward)
            return
        }
        
        let adjacent = self.findAdjacentViewAt(toward)
        
        UIView.animate(withDuration: duration, delay: 0.0, options: options, animations: {
            switch toward {
            case .Left:
                adjacent.center.x = self.center.x
                self.center.x -= squareSize
            case .Right:
                adjacent.center.x = self.center.x
                self.center.x += squareSize
            case .Up:
                adjacent.center.y = self.center.y
                self.center.y -= squareSize
            case .Down:
                adjacent.center.y = self.center.y
                self.center.y += squareSize
            }
            
            }, completion: { finished in
                swap(&self.tag, &adjacent.tag)
        })
    }
    
    private func findAdjacentViewAt(_ direction: Direction) -> SquareView {
        let index:(row:Int, col: Int) =
            (Int(self.center.y/60),
             Int(self.center.x/60))
        var tag:Int = 1000
        switch direction {
        case .Left:
            tag += 4*index.row+index.col-1
        case .Right:
            tag += 4*index.row+index.col+1
        case .Down:
            tag += 4*(index.row+1)+index.col
        case .Up:
            tag += 4*(index.row-1)+index.col
        }
        return self.superview!.viewWithTag(tag) as! SquareView
    }
    
    private func possibleToMove(_ direction:Direction) -> Bool {
        switch direction {
        case .Left:
            return self.center.x > direction.limit()
        case .Right:
            return self.center.x < direction.limit()
        case .Up:
            return self.center.y > direction.limit()
        case .Down:
            return self.center.y < direction.limit()
        }
    }
}
