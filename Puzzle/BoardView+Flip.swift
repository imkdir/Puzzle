//
//  CardView+Flip.swift
//  Puzzle
//
//  Created by Tung on 11/10/2016.
//  Copyright © 2016 iMpression. All rights reserved.
//

import UIKit

extension CardView {
    func flipAnimation(_ toward:Direction) {
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        switch toward {
        case .left:
            self.layer.anchorPoint.x = 0.0
            self.center.x -= squareSize/2
        case .up:
            self.layer.anchorPoint.y = 0.0
            self.center.y -= squareSize/2
        case .right:
            self.layer.anchorPoint.x = 1.0
            self.center.x += squareSize/2
        case .down:
            self.layer.anchorPoint.y = 1.0
            self.center.y += squareSize/2
        }
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            options: [.curveEaseOut],
            animations: {
                self.layer.transform = self.rotationTransform(toward)
            },
            completion: { finished in
                UIView.animate(
                    withDuration: 0.1,
                    delay: 0.0,
                    options: [.curveEaseIn],
                    animations: {
                        self.layer.transform = CATransform3DIdentity
                    },
                    completion: { finished in
                        switch toward {
                        case .left:
                            self.layer.anchorPoint.x = 0.5
                            self.center.x += squareSize/2
                        case .up:
                            self.layer.anchorPoint.y = 0.5
                            self.center.y += squareSize/2
                        case .right:
                            self.layer.anchorPoint.x = 0.5
                            self.center.x -= squareSize/2
                        case .down:
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
        case .left:
            return CATransform3DRotate(identity, -.pi/4, 0.0, 1.0, 0.0)
        case .up:
            return CATransform3DRotate(identity, .pi/4, 1.0, 0.0, 0.0)
        case .right:
            return CATransform3DRotate(identity, .pi/4, 0.0, 1.0, 0.0)
        case .down:
            return CATransform3DRotate(identity, -.pi/4, 1.0, 0.0, 0.0)
        }
        
    }
}
