//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Angela Yu on 14/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ball1: UIImageView!

    @IBAction func askMe(_ sender: UIButton) {
        ball1.image = [UIImage(named: "ball1"), UIImage(named: "ball2"),UIImage(named: "ball3"),UIImage(named: "ball4"),UIImage(named: "ball5")][Int.random(in: 0...4)]
    }
    

}

