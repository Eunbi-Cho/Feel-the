//
//  File.swift
//  flavor orchestra
//
//  Created by 조은비 on 2022/04/23.
//

import GameplayKit
import SpriteKit
import SwiftUI

class gravityScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.black

        scene!.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
//        run(SKAction.repeat(SKAction.sequence([SKAction.run(touchesMoved), SKAction.wait(forDuration: 0.1)]), count: 1000))

    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?, ball: SKSpriteNode) {
        
        let ball = SKSpriteNode(imageNamed: "ball")
        ball.size = CGSize(width: 30, height: 30)
        ball.position = CGPoint(
            x: CGFloat(Int(arc4random()) & Int(size.width)),
            y: size.height - ball.size.height)

        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        
        self.addChild(ball)
        
        var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(
            x: CGFloat(Int(arc4random()) & Int(size.width)),
            y: -ball.size.height), duration: 2))
        
        actionArray.append(SKAction.removeFromParent())

        ball.run(SKAction.sequence(actionArray))
        
        for touch in touches {
            let location = touch.location(in: self)
            ball.position.x = location.x
            ball.position.y = location.y
        }
        
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
//
//    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?, ball: SKSpriteNode) {
//        for touch in touches {
//            let location = touch.location(in: self)
//            ball.position.x = location.x
//            ball.position.y = location.y
//        }
//    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}

struct gravity: View {
    
    
    var scene: SKScene {
        let scene = gravityScene()
        scene.size = CGSize(width: 800, height: 1600)
        scene.scaleMode = .fill
        return scene
    }
    
    
    var body: some View {
        HStack {
            SpriteView(scene: scene)
                .frame(width: 834, height: 1600)
        }
    }
}
