//
//  GameViewController.swift
//  8l_KukobaAlexander
//
//  Created by Александр Кукоба on 14.06.2022.
//


import UIKit
import SpriteKit
import GameplayKit


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true

        scene.scaleMode = .resizeFill
        
//        let offset = 20.0
//
//        skView.layer.borderWidth = offset
//        skView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
//        skView.frame =  CGRect(x: offset, y: offset, width:skView.frame.size.width - offset, height:skView.frame.size.height - offset)

        skView.presentScene(scene)
 
    }
}

