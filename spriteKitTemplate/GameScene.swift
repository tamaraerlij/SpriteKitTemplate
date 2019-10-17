//
//  GameScene.swift
//  spriteKitTemplate
//
//  Created by Tamara Erlij on 17/10/19.
//  Copyright © 2019 Tamara Erlij. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var bird = SKSpriteNode()
    

    override func didMove(to view: SKView) {
        let birdTexture = SKTexture(imageNamed: "flappy1.png")
        
        bird = SKSpriteNode(texture: birdTexture)
        
        bird.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        self.addChild(bird)
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        }
        
       
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
