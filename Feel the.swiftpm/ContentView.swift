import SpriteKit
import SwiftUI
import GameplayKit

class GameScene: SKScene {
    var sprite: SKSpriteNode!
    var touchPoint: CGPoint = CGPoint()
    var touching: Bool = false
    
    
    
    override func didMove(to view: SKView) {
        run(SKAction.repeat(SKAction.sequence([SKAction.run(createBall), SKAction.wait(forDuration: 0.05)]), count: 200))
    }
    
    func createBall() {
        sprite = SKSpriteNode(imageNamed: "ball")
        sprite.size = CGSize(width: 50, height: 50)
        
        sprite.position = CGPoint(
            x: CGFloat(Int(arc4random()) & Int(size.width)),
            y: size.height - sprite.size.height)

        sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width/2)
        
        self.addChild(sprite)
    
        
        var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(
            x: CGFloat(Int(arc4random()) & Int(size.width)),
            y: -sprite.size.height), duration: 2))
        
        actionArray.append(SKAction.removeFromParent())

        sprite.run(SKAction.sequence(actionArray))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in:self)
        touchPoint = location
        sprite.run(SKAction.move(to: CGPoint(x:  location.x, y:location.y), duration: 0.5))
        touching = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        touchPoint = location
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touching = false
    }
        
    override func update(_ currentTime: TimeInterval) {
        if touching {
            let dt:CGFloat = 1.0/60.0
            let distance = CGVector(dx: touchPoint.x-sprite.position.x, dy: touchPoint.y-sprite.position.y)
            let velocity = CGVector(dx: distance.dx/dt, dy: distance.dy/dt)
            sprite.physicsBody!.velocity=velocity
        }
    }
}


struct ContentView: View {
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 900, height: 1200)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        HStack {
            SpriteView(scene: scene)
                .frame(width: 900, height: 1200)
        }
    }
}
