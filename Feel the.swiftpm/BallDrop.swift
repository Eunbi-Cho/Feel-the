//
//  File.swift
//  Feel the
//
//  Created by 조은비 on 2022/04/23.
//

import Foundation
import SpriteKit

class BallDrop: SKNode {
    init(image: SKSpriteNode) {
        super.init()
        
        let randomNumber = arc4random_uniform(2)
        let x: CGFloat = randomNumber == 0 ? 1 : -1
        
        self.position = CGPoint(
            x: (CGFloat(arc4random_uniform(UInt32(UIScreen.main.bounds.width))) * x),
            y: UIScreen.main.bounds.height)
        
        self.setScale(0.05)
        
        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "ball"), size: CGSize(width: image.size.width * 0.05, height: image.size.height * 0.05))
        
        self.addChild(image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(foder:) has not been implemented")
    }
    
    func move(touchLocation: CGPoint) {
        if self.calculateAccumulatedFrame().contains(touchLocation) {
            self.position.x = touchLocation.x
            self.position.y = touchLocation.y
        }
    }
}
