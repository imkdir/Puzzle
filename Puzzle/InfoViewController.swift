//
//  InfoViewController.swift
//  Puzzle
//
//  Created by Tung on 12/10/2016.
//  Copyright © 2016 iMpression. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let pan = UIPanGestureRecognizer(target: self, action: #selector(InfoViewController.handlePan(_:)))
        self.view.gestureRecognizers = [pan]
    }

    func handlePan(_ gesture:UIPanGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}
