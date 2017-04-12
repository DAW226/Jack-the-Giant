//
//  CollectablesController.swift
//  DinoErupt
//
//  Created by Darin Wilson on 4/11/17.
//  Copyright © 2017 DarinDev. All rights reserved.
//

import SpriteKit

//DAW: ADDD
class CollectableController {

    func getCollectable() -> SKSpriteNode {
        
        var collectable = SKSpriteNode()
        
        if Int(rockXPlacement(firstNum: 0, secondNum: 7)) >= 4{
         //DAW: Creating Life collectable
            if GameplayController.instance.life! < 2 {
                collectable = SKSpriteNode(imageNamed: "Life")
                collectable.name = "Life"
                collectable.physicsBody = SKPhysicsBody(rectangleOf: collectable.size)
            
            }
            
        } else {
           //DAW: Creating Coin collectable 
                collectable = SKSpriteNode(imageNamed: "Coin")
                collectable.name = "Coin"
                collectable.physicsBody = SKPhysicsBody(circleOfRadius: collectable.size.height / 2)
        }
        
        collectable.physicsBody?.affectedByGravity = false
        collectable.physicsBody?.categoryBitMask = colliderType.crackedRockandCollectable
        collectable.physicsBody?.categoryBitMask = colliderType.player
        collectable.zPosition = 2
        
        return collectable
    }
    
    //DAW: Creating random rocks placements
    func rockXPlacement(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
}



