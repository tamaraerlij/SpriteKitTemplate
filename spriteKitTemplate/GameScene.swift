//
//  GameScene.swift
//  spriteKitTemplate
//
//  Created by Tamara Erlij on 17/10/19.
//  Copyright © 2019 Tamara Erlij. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Criação das variáveis
    var bird = SKSpriteNode()
    var bg = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    var score = 0
    var gameOverLabel = SKLabelNode()
    
    
    enum ColliderType: UInt32{
        case Bird = 1
        case Object = 2
        case Gap = 4
        
    }
    var gameOver = false
    var backgroundMusic: SKAudioNode!
    @objc func makePipes() {
        let movePipes = SKAction.move(by: CGVector(dx: -2 * self.frame.width, dy: 0), duration: TimeInterval(self.frame.width / 100))
        let removePipes = SKAction.removeFromParent()
        let moveAndRemovePipes = SKAction.sequence([movePipes, removePipes])
              
              let gapHeight = bird.size.height * 4
              let movementAmount  = arc4random() % UInt32(self.frame.height / 2)
              let pipeOffSet = CGFloat(movementAmount) - self.frame.height / 4
              
              // Criacao da barreira
              let pipeTexture = SKTexture(imageNamed: "pipe2.png")
              let pipe1 = SKSpriteNode(texture: pipeTexture)
              pipe1.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY + pipeTexture.size().height / 2 + gapHeight + pipeOffSet)
              pipe1.run(moveAndRemovePipes)
        pipe1.physicsBody = SKPhysicsBody(rectangleOf: pipeTexture.size())
        pipe1.physicsBody!.isDynamic = false
        pipe1.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        pipe1.physicsBody!.categoryBitMask = ColliderType.Bird.rawValue
        pipe1.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
              self.addChild(pipe1)
              
              let pipe2Texture = SKTexture(imageNamed: "pipe2.png")
              let pipe2 = SKSpriteNode(texture: pipe2Texture)
              pipe2.position = CGPoint(x : self.frame.midX + self.frame.width, y: self.frame.midY - pipe2Texture.size().height / 2 - gapHeight - pipeOffSet)
              pipe2.run(moveAndRemovePipes)
        
        pipe2.physicsBody = SKPhysicsBody(rectangleOf: pipeTexture.size())
        pipe2.physicsBody!.isDynamic = false
        pipe2.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        pipe2.physicsBody!.categoryBitMask = ColliderType.Bird.rawValue
        pipe2.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
              self.addChild(pipe2)
      
        let gap = SKNode()
        gap.position = CGPoint(x: self.frame.midX + self.frame.width, y: self.frame.midY + pipeOffSet )
        gap.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: pipeTexture.size().width, height: gapHeight))
        gap.physicsBody?.isDynamic = false
        gap.run(moveAndRemovePipes)
        gap.physicsBody!.contactTestBitMask = ColliderType.Bird.rawValue
        gap.physicsBody!.categoryBitMask = ColliderType.Gap.rawValue
        gap.physicsBody!.collisionBitMask = ColliderType.Gap.rawValue
        
        self.addChild(gap)
    }
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == ColliderType.Gap.rawValue || contact.bodyA.categoryBitMask == ColliderType.Gap.rawValue {
           score += 1
            scoreLabel.text = String(score)
            
        } else {
        self.speed = 0
        gameOver = true
            gameOverLabel.fontName = "Helvetica"
            gameOverLabel.fontSize = 30
            gameOverLabel.text = "Game over! tap to play again"
            gameOverLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            
            self.addChild(gameOverLabel)
    }
 }
    override func didMove(to view: SKView ) {
        self.physicsWorld.contactDelegate = self
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
        

      
          bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 2)
        bird.physicsBody!.isDynamic = false
        
        bird.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        bird.physicsBody!.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        // Aparição
        self.addChild(bird)
        
       let ground = SKNode()
        ground.position = CGPoint(x: self.frame.midX, y: -self.frame.height / 2)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 1))
        
        // O chão não é afetado pela gravidade:
        ground.physicsBody!.isDynamic = false
        ground.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        ground.physicsBody!.categoryBitMask = ColliderType.Bird.rawValue
        ground.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        self.addChild(ground)
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.height / 2 - 70)
        self.addChild(scoreLabel)
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameOver == false {
        // Somente será afetado pela gravidade quando o usuário tocar na tela
           bird.physicsBody!.isDynamic = true
        
           bird.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        
           bird.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 100))
     
        }
        }
        
       
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
