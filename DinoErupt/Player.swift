//
//  Player.swift
//  DinoErupt
//
//  Created by Darin Wilson on 3/23/17.
//  Copyright © 2017 DarinDev. All rights reserved.
//

import SpriteKit

struct colliderType {
    static let player: UInt32 = 0
    static let rock: UInt32 = 1
    static let crackedRockandCollectable: UInt32 = 2
}

class Player: SKSpriteNode {
    
    private var textureAtlas = SKTextureAtlas()
    private var playerAnimation = [SKTexture]()
    private var animatePlayerAction = SKAction()
    
    //DAW: Last position of player
    private var lastY = CGFloat()
    
    //DAW: Intialize player animations and locate images for walk cycle.
    func intializePlayerAndAnimations() {
        
        textureAtlas = SKTextureAtlas(named: "Player.atlas")
        
        for i in 2...textureAtlas.textureNames.count{
            let name = "Player \(i)"
            playerAnimation.append(SKTexture(imageNamed: name))
        }
        
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.1, resize: true, restore: false)

        //DAW: Physics for player and making the player be affected by the rocks.
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        self.physicsBody?.categoryBitMask = colliderType.player
        self.physicsBody?.collisionBitMask = colliderType.rock
        self.physicsBody?.contactTestBitMask = colliderType.crackedRockandCollectable
        
        lastY = self.position.y
        
    }
    
    //DAW: Fixing animation issues with scaling
    func animatePlayer(moveLeft: Bool) {
        
        if moveLeft {
            self.xScale = -fabs(self.xScale)
        } else {
            self.xScale = fabs(self.xScale)
        }
        
        self.run(SKAction.repeatForever(animatePlayerAction), withKey: "animate")
        
    }
    
    //DAW: Stopping animation when finger is lifted
    func stopPlayerAnimation() {
        
        self.removeAction(forKey: "animate")
        self.texture = SKTexture(imageNamed: "Player 1")
        self.size = (self.texture?.size())!
    }
    
    // DAW: Move player left and right.
    func movePlayer(moveLeft: Bool) {
       
        if moveLeft {
            self.position.x -= 7
        } else {
            self.position.x += 7
        }
    }
    //DAW: Adding score points as the player goes down on the Y axis with last point of player at the top
    func setScore() {
        if self.position.y < lastY {
            GameplayController.instance.incrementScore()
            lastY = self.position.y
        }
    }
    
}
    








