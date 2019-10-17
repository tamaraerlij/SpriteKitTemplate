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
    var backgroundMusic: SKAudioNode!
    

    override func didMove(to view: SKView) {
        // Adicionar música de fundo
        if let musicURL = Bundle.main.url(forResource: "BackgroundMusic", withExtension: ".mp3") {
        backgroundMusic = SKAudioNode(url: musicURL)
        addChild(backgroundMusic)
        }
        
        
        
        
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
        
      
        // posição do elemento no meio da tela
        bird.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        bird.run(makeBirdFlap)
        // Aparição
        self.addChild(bird)
        
       let ground = SKNode()
        ground.position = CGPoint(x: self.frame.midX, y: -self.frame.height / 2)
        
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
        
        // O chão não é afetado pela gravidade:
        ground.physicsBody!.isDynamic = false
        
        self.addChild(ground)
        
        
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Somente será afetado pela gravidade quando o usuário tocar na tela
        
            let birdTexture = SKTexture(imageNamed: "flappy1.png")
      //  bird.physicsBody!.isDynamic = true
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 2)
        
        bird.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        
        bird.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 100))
        
     
             
        }
        
       
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
