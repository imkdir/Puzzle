//
//  ViewController.swift
//  Puzzle
//
//  Created by Tung CHENG on 10/10/2016.
//  Copyright © 2016 Objective CHENG. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var spaceView: BlockView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originalPositions = cardViews
            .sorted(by: { $0.tag < $1.tag })
            .map({ $0.center })
    }

    //MARK: - IBAction
    
    @IBAction func move(_ sender: UIButton) {
        guard let direction = BlockView.Direction(rawValue:sender.tag) else { return }
        spaceView.move(toward: direction, withDuration: duration, options: [])
    }
    
    @IBAction func reset() {
        UIView.animate(withDuration: duration, animations: {
            self.resetBlocksPosition()
        })
    }
    
    private func resetBlocksPosition() {
        cardViews.forEach({ $0.center = self.originalPositions[$0.tag-1000] })
    }
    
    private let duration:TimeInterval = 0.25
    private var originalPositions: [CGPoint] = []
    private var cardViews: [BlockView] {
        return boardView.subviews.compactMap({ $0 as? BlockView })
    }
}
