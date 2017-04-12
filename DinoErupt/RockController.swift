//
//  RockController.swift
//  DinoErupt
//
//  Created by Darin Wilson on 3/28/17.
//  Copyright © 2017 DarinDev. All rights reserved.
//

import SpriteKit


class rockController {
    
    let collectableController = CollectableController()
   
    var lastRockPositionY = CGFloat()
    //DAW: Shuffling Rocks so they're not all the same
    func shuffleRocks( rocksArray: [SKSpriteNode]) -> [SKSpriteNode] {
        var rocksArray = rocksArray
        
        
        for i in ((0 + 1)...rocksArray.count - 1).reversed() {
            
            let j = Int(arc4random_uniform(UInt32(i - 1)))
            swap(&rocksArray[i], &rocksArray[j])
            
        }
        
        return rocksArray
    }
    
    //DAW: Creating random rocks placements
    func rockXPlacement(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
      return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    //DAW: Creating the Rocks
    func createRocks() -> [SKSpriteNode] {
        
        
        var rocks = [SKSpriteNode]()
        
        for i in 0..<2 {
            let rock1 = SKSpriteNode(imageNamed: "Cloud 1")
            rock1.name = "1"
            let rock2 = SKSpriteNode(imageNamed: "Cloud 2")
            rock2.name = "2"
            let rock3 = SKSpriteNode(imageNamed: "Cloud 3")
            rock3.name = "3"
            let crackedRock = SKSpriteNode(imageNamed: "Dark Cloud")
            crackedRock.name = "Dark Cloud"
            
            rock1.xScale = 0.9
            rock1.yScale = 0.9
            
            rock2.xScale = 0.9
            rock2.yScale = 0.9
            
            rock3.xScale = 0.9
            rock3.yScale = 0.9
            
            crackedRock.xScale = 0.9
            crackedRock.yScale = 0.9
            
            //DAW: Adding Physic Bodies to the Rocks, and Collision with the player
            rock1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rock1.size.width - 50, height: rock1.size.height - 15))
            rock1.physicsBody?.affectedByGravity = false
            rock1.physicsBody?.restitution = 0
            rock1.physicsBody?.categoryBitMask = colliderType.rock
            rock1.physicsBody?.collisionBitMask = colliderType.player
            
            rock2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rock2.size.width - 50, height: rock2.size.height - 15))
            rock2.physicsBody?.affectedByGravity = false
            rock2.physicsBody?.restitution = 0
            rock2.physicsBody?.categoryBitMask = colliderType.rock
            rock2.physicsBody?.collisionBitMask = colliderType.player

            rock3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rock3.size.width - 50, height: rock3.size.height - 15))
            rock3.physicsBody?.affectedByGravity = false
            rock3.physicsBody?.restitution = 0
            rock3.physicsBody?.categoryBitMask = colliderType.rock
            rock3.physicsBody?.collisionBitMask = colliderType.player

            crackedRock.physicsBody = SKPhysicsBody(rectangleOf: crackedRock.size)
            crackedRock.physicsBody?.affectedByGravity = false
            crackedRock.physicsBody?.categoryBitMask = colliderType.crackedRockandCollectable
            crackedRock.physicsBody?.collisionBitMask = colliderType.player

            
            
            
            rocks.append(rock1)
            rocks.append(rock2)
            rocks.append(rock3)
            rocks.append(crackedRock)
            
        }
        //DAW: Shuffling the rocks so they appear in a unpredicted order
        rocks = shuffleRocks(rocksArray: rocks)
        
        return rocks
    }
    
    func arrangeRocksInScene( scene: SKScene, DistanceBetweenRocks: CGFloat, center: CGFloat, minX: CGFloat, maxX: CGFloat, intialRocks: Bool) {
        
        var rocks = createRocks()
        
        if intialRocks {
            while(rocks[0].name == "Dark Cloud") {
               
                rocks = shuffleRocks(rocksArray: rocks)
            }
        }
        
        var positionY = CGFloat()
        
        if intialRocks {
            positionY = center - 100
        } else {
            positionY = lastRockPositionY
        }
        
        var random = 0
        //DAW: Random Rock Placement
        for i in 0...rocks.count - 1 {
            
            var randomX = CGFloat()
            
            if random == 0 {
                randomX = rockXPlacement(firstNum: center + 60, secondNum: maxX)
                random = 1
            } else if random == 1 {
                randomX = rockXPlacement(firstNum: center - 60, secondNum: minX)
                random = 0
            }
            
            rocks[i].position = CGPoint(x: randomX, y: positionY)
            rocks[i].zPosition = 3
            //DAW: Not spawning collectable at the intial clouds!
            if !intialRocks {
                //DAW: Summoning  collectables at a rate of greater or equal to 3 -- higher number less spawn
                if Int(rockXPlacement(firstNum: 0, secondNum: 7)) <= 3 {
                    
                    if rocks[i].name != "Dark Cloud" {
                    //DAW: Spawning collectables ontop of clouds
                    let collectable = collectableController.getCollectable()
                    collectable.position = CGPoint(x: rocks[i].position.x, y: rocks[i].position.y + 55)
                    
                    //DAW: Adding collectables to scene
                    scene.addChild(collectable)
                    }
                    
                }
                
            }
            
            scene.addChild(rocks[i])
            positionY -= DistanceBetweenRocks
            lastRockPositionY = positionY
        }
        
    }
    
}














