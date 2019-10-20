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
    @objc func makePipes() {
        let movePipes = SKAction.move(by: CGVector(dx: -2 * self.frame.width, dy: 0), duration: TimeInterval(self.frame.width / 100))
              
              let gapHeight = bird.size.height * 4
              let movementAmount  = arc4random() % UInt32(self.frame.height / 2)
              let pipeOffSet = CGFloat(movementAmount) - self.frame.height / 4
              
              // Criacao da barreira
              let pipeTexture = SKTexture(imageNamed: "pipe2.png")
              let pipe1 = SKSpriteNode(texture: pipeTexture)
              pipe1.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY + pipeTexture.size().height / 2 + gapHeight + pipeOffSet)
              pipe1.run(movePipes)
              self.addChild(pipe1)
              
              let pipe2Texture = SKTexture(imageNamed: "pipe2.png")
              let pipe2 = SKSpriteNode(texture: pipe2Texture)
              pipe2.position = CGPoint(x : self.frame.midX + self.frame.width, y: self.frame.midY - pipe2Texture.size().height / 2 - gapHeight - pipeOffSet)
              pipe2.run(movePipes)
              self.addChild(pipe2)
        
    }
    

    override func didMove(to view: SKView ) {
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.makePipes), userInfo: nil, repeats: true)
     
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
