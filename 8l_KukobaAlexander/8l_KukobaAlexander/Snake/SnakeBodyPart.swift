//
//  SnakeBodyPart.swift
//  8l_KukobaAlexander
//
//  Created by Александр Кукоба on 14.06.2022.
//

import UIKit
import SpriteKit


class SnakeBodyPart: SKShapeNode {
    
    let diametr = 12
    
    
    init(atPoint point: CGPoint) {
        super.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: diametr, height: diametr)).cgPath
        fillColor = .green
        strokeColor = .green
        lineWidth = 5
        self.position = point
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(diametr),
                                         center: CGPoint(x: 5, y: 5))
        self.physicsBody?.isDynamic = true
        
        self.physicsBody?.categoryBitMask = CollisionCategory.Snake
        self.physicsBody?.contactTestBitMask = CollisionCategory.EdgeBody | CollisionCategory.Apple
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
