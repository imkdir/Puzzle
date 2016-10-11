//
//  SquareView+Flip.swift
//  Puzzle
//
//  Created by Tung on 11/10/2016.
//  Copyright © 2016 iMpression. All rights reserved.
//

import UIKit

extension SquareView {
    func flipAnimation(_ toward:Direction) {
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        switch toward {
        case .Left:
            self.layer.anchorPoint.x = 0.0
            self.center.x -= squareSize/2
        case .Up:
            self.layer.anchorPoint.y = 0.0
            self.center.y -= squareSize/2
        case .Right:
            self.layer.anchorPoint.x = 1.0
            self.center.x += squareSize/2
        case .Down:
            self.layer.anchorPoint.y = 1.0
            self.center.y += squareSize/2
        }
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseOut], animations: {
            self.layer.transform = self.rotationTransform(toward)
            }, completion: { finished in
                UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseIn], animations: {
                    self.layer.transform = CATransform3DIdentity
                    }, completion: { finished in
                        switch toward {
                        case .Left:
                            self.layer.anchorPoint.x = 0.5
                            self.center.x += squareSize/2
                        case .Up:
                            self.layer.anchorPoint.y = 0.5
                            self.center.y += squareSize/2
                        case .Right:
                            self.layer.anchorPoint.x = 0.5
                            self.center.x -= squareSize/2
                        case .Down:
                            self.layer.anchorPoint.y = 0.5
                            self.center.y -= squareSize/2
                        }
                })
        })
    }
    
    private func rotationTransform(_ direction: Direction) ->CATransform3D {
        var identity = CATransform3DIdentity
        identity.m34 = -1/1000.0
        switch direction {
        case .Left:
            return CATransform3DRotate(identity, CGFloat(-M_PI_4), 0.0, 1.0, 0.0)
        case .Up:
            return CATransform3DRotate(identity, CGFloat(M_PI_4), 1.0, 0.0, 0.0)
        case .Right:
            return CATransform3DRotate(identity, CGFloat(M_PI_4), 0.0, 1.0, 0.0)
        case .Down:
            return CATransform3DRotate(identity, CGFloat(-M_PI_4), 1.0, 0.0, 0.0)
        }
        
    }
}
