//
//  GameScene.swift
//  8l_KukobaAlexander
//
//  Created by Александр Кукоба on 14.06.2022.
//

import SpriteKit
import GameplayKit

struct CollisionCategory {
    
    static let Snake: UInt32 = 0x1 << 0 //0001
    static let SnakeHead: UInt32 = 0x1 << 1 //0010
    static let Apple: UInt32 = 0x1 << 2 //0100
    static let EdgeBody: UInt32 = 0x1 << 3 //1000
    
}


class GameScene: SKScene {
    
    var snake: Snake?
  
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.lightGray

        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        self.physicsBody?.allowsRotation = false
        
        view.showsPhysics = true
        
        let counterClockwiseButton = SKShapeNode()
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockwiseButton.position = CGPoint(x: view.scene!.frame.minX + 30, y: view.scene!.frame.minY + 30)
        counterClockwiseButton.fillColor = .black
        counterClockwiseButton.strokeColor = .black
        counterClockwiseButton.lineWidth = 10
        counterClockwiseButton.name = "counterClockwiseButton"
        self.addChild(counterClockwiseButton)
        
        
   
        let counterClockButton = SKShapeNode()
        counterClockButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockButton.position = CGPoint(x: view.scene!.frame.maxX - 70, y: view.scene!.frame.minY + 30)
        counterClockButton.fillColor = .black
        counterClockButton.strokeColor = .black
        counterClockButton.lineWidth = 10
        counterClockButton.name = "counterClockButton"
        self.addChild(counterClockButton)
        
        createApple()
        
        createSnake()
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode,
                  touchNode.name == "counterClockwiseButton" || touchNode.name == "counterClockButton" else {
                      return
                  }
            
            touchNode.fillColor = .green
            
            if touchNode.name == "counterClockButton" {
                snake!.moveClockwise()
            } else if touchNode.name == "counterClockwiseButton" {
                snake!.moveCounterClockwise()
            }
        }
        
        
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode,
                  touchNode.name == "counterClockwiseButton" || touchNode.name == "counterClockButton" else {
                      return
                  }
            
            touchNode.fillColor = .gray
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    

    
    override func update(_ currentTime: TimeInterval) {
        snake!.move()
    }
}


extension GameScene {
    
    func createApple() {
        
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX-5)))
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY-5)))
        
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        
        self.addChild(apple)
    }
    
    func createSnake(){
        
        snake = Snake(atPoint: CGPoint(x: view!.scene!.frame.midX, y: view!.scene!.frame.midY))
        self.addChild(snake!)
        self.physicsWorld.contactDelegate = self
        self.physicsBody?.categoryBitMask = CollisionCategory.EdgeBody
        self.physicsBody?.collisionBitMask = CollisionCategory.Snake | CollisionCategory.SnakeHead
    
    }
    
}


extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let collisionObject = bodyes - CollisionCategory.SnakeHead
        
        switch collisionObject {
        case CollisionCategory.Apple:
            
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake?.addBodyPart()
            apple?.removeFromParent()
            createApple()
            
        case CollisionCategory.EdgeBody:
            print("ударились об край экрана")
            
            snake?.removeAllChildren()
            snake?.removeFromParent()
            snake = nil
            
            createSnake()
            break
        default:
            break
        }
        
        
    }
    
}
