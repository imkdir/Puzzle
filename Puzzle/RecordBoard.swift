//
//  RecordBoard.swift
//  Puzzle
//
//  Created by Tung on 12/10/2016.
//  Copyright © 2016 iMpression. All rights reserved.
//

import UIKit
import QuartzCore

class RecordBoard: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.sanMarino()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var paths:[String] = [] {
        didSet {
            setNeedsDisplay()
            let route = paths.reduce("", +)
            UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
            route.draw(in: bounds, withAttributes: textAttributes)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            let maskLayer = CALayer()
            maskLayer.backgroundColor = UIColor.clear.cgColor
            maskLayer.frame = bounds
            maskLayer.contents = image?.cgImage
            gradientLayer.mask = maskLayer
        }
    }
    
    let textAttributes: [String:AnyObject] = {
        let style = NSMutableParagraphStyle(); style.alignment = .center
        let font = UIFont.preferredFont(forTextStyle: .headline)
        return [NSFontAttributeName: font,
                NSParagraphStyleAttributeName: style]
    }()
    
    let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0.0, y: 0.5)
        layer.endPoint = CGPoint(x: 1.0, y: 0.5)
        let colors:[UIColor] = [.darkGray, .white, .darkGray]
        layer.colors = colors.map { $0.cgColor }
        layer.locations = [0.25, 0.5, 0.75]
        
        return layer
    }()
    
    override func layoutSubviews() {
        gradientLayer.frame = bounds
    }
    
    func startGradientAnimation(){
        guard !paths.isEmpty else {
            return
        }; layer.addSublayer(gradientLayer)
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.0, 0.25]
        animation.toValue = [0.75, 1.0, 1.0]
        animation.duration = 2.0
        animation.repeatCount = 1.0
        gradientLayer.locations = [0.75, 1.0, 1.0]
        gradientLayer.add(animation, forKey: nil)
    }
}
