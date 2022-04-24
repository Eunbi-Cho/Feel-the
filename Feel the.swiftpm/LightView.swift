//
//  File.swift
//  Feel the
//
//  Created by 조은비 on 2022/04/24.
//

import Foundation
import SwiftUI
import SpriteKit

class LightScene: SKScene {
    var player = SKSpriteNode()
    var touchPoint: CGPoint = CGPoint()
    var touching: Bool = false
    
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
                    return
                }
        let location = touch.location(in:self)
        touchPoint = location
        player = SKSpriteNode(imageNamed: "light")
        player.size = CGSize(width: 100, height: 100)
        self.addChild(player)
        player.position = location
        touching = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in:self)
            player.position.x = location.x
            player.position.y = location.y
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.run(SKAction.removeFromParent())
        touching = false
    }
        
    override func update(_ currentTime: TimeInterval) {
    
    }
    
}
        
        

struct LightView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var scene: SKScene {
        let scene = LightScene()
        scene.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scene.scaleMode = .fill
        scene.backgroundColor = .black
        return scene
    }
    
    var body: some View {
        NavigationView {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            SpriteView(scene: scene)
                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            
            Text("Find the Exit, and Tap")
                .foregroundColor(.black)
            Button(action:{presentationMode.wrappedValue.dismiss()}){Image(systemName: "xmark").foregroundColor(.black)}.padding().buttonStyle(BorderlessButtonStyle())
                .position(CGPoint(
                    x: .random(in: 0...UIScreen.main.bounds.size.width),
                    y: .random(in: 0...UIScreen.main.bounds.size.height)))
        }
        }
    }

    
}