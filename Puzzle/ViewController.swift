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
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        position = cardViews
            .sorted(by: { $0.tag < $1.tag })
            .map({ $0.center })
    }

    //MARK: - IBAction
    
    @IBAction func move(_ sender: UIButton) {
        let direction = BlockView.Direction(rawValue:sender.tag)!
        self.spaceView.move(toward: direction, withDuration: duration, options: [])
    }
    
    @IBAction func refreshGame(_ sender: UIBarButtonItem) {
        UIView.animate(withDuration: duration, animations: {
            self.refreshMainView()
        })
    }
    
    private func refreshMainView() {
        cardViews.forEach({ $0.center = self.position[$0.tag-1000] })
    }
    
    private let duration:TimeInterval = 0.25
    private var cardViews: [BlockView] {
        return boardView.subviews as! [BlockView]
    }
    private var position: [CGPoint] = []
}
