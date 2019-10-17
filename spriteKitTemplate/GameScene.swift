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
    
    // Criação das variáveis
    var bird = SKSpriteNode()
    var bg = SKSpriteNode()
    

    override func didMove(to view: SKView) {
        
        let bgTexture = SKTexture(imageNamed: "bg.png")
        
        let moveBGAnimation = SKAction.move(by: CGVector(dx: -bgTexture.size().width, dy: 0), duration: 7)
        let shiftBGAnimation = SKAction.move(by: CGVector(dx: bgTexture.size().width, dy: 0), duration: 5)
        let moveBGForever = SKAction.repeatForever(SKAction.sequence([moveBGAnimation, shiftBGAnimation]))
        
        var i : CGFloat = 0
        
        while i < 3 {

               bg = SKSpriteNode(texture: bgTexture)
               
               bg.position = CGPoint(x: bgTexture.size().width / 2 + bgTexture.size().width * i , y: self.frame.midY)
        
               bg.size.height = self.frame.height
        
                bg.run(moveBGForever)
               
                 bg.zPosition = -1
               self.addChild(bg)
        
                 i += 1
            
       
    }
        
        // Criação da textura
        let birdTexture = SKTexture(imageNamed: "flappy1.png")
        let birdTexture2 = SKTexture(imageNamed: "flappy2.png")
        
        // Pequena animação
        let animation = SKAction.animate(with: [birdTexture, birdTexture2], timePerFrame: 0.1)
        let makeBirdFlap = SKAction.repeatForever(animation)
        
        // Incorporação da textura
        bird = SKSpriteNode(texture: birdTexture)
        
        // posição do elemento
        bird.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        bird.run(makeBirdFlap)
        // Aparição
        self.addChild(bird)
        
       
        
        
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        }
        
       
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
