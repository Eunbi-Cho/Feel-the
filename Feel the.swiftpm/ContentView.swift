import SpriteKit
import SwiftUI
import GameplayKit

class GameScene: SKScene {
    var sprite: SKSpriteNode!
    var touchPoint: CGPoint = CGPoint()
    var touching: Bool = false
    
    override func didMove(to view: SKView) {
        let physicsFrame = CGRect(x: 0, y: 50, width: self.frame.size.width, height: self.frame.size.height - 100)
        self.physicsBody = SKPhysicsBody.init(edgeLoopFrom: physicsFrame)
        sprite = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
        sprite.physicsBody = SKPhysicsBody.init(rectangleOf: sprite.size)
        sprite.position = CGPoint(x: self.size.width/2.0, y: self.size.height/2.0)
        self.addChild(sprite)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in:self)
        if sprite.frame.contains(location) {
            touchPoint = location
            touching = true
        }
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
