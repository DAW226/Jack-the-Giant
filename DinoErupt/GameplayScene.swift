//
//  GameplayScene.swift
//  DinoErupt
//
//  Created by Darin Wilson on 3/23/17.
//  Copyright © 2017 DarinDev. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    var rocksController = rockController()
    var mainCamera: SKCameraNode?
    
    var bg1: BGClass?
    var bg2: BGClass?
    var bg3: BGClass?
    
    var player: Player?
    var canMove = false
    var moveLeft = false
    
    var center: CGFloat?
    private var cameraRespawnRocks = CGFloat()
    let distanceBetweenRocks = CGFloat(240)
    let minX = CGFloat(-160)
    let maxX = CGFloat(160)
    
    private var PauseBtnPressed: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
        intializeVariables()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveCamera()
        managePlayer()
        manageBackgrounds()
        createNewRocks()
        player?.setScore()
        
    }
    
    
    //DAW: The intial contact function -- Player contacting with collectables
    func didBeginContact(contact: SKPhysicsContact) {
    //DAW: The first body will always be the player.
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
    //DAW: Decaring bodyA (First Body) to Player
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        //DAW: Both of these statements need to be true or both false if you use the && sign
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Life" {
            //DAW: Play the sound of the life collectable
            //DAW: Change the life score
            GameplayController.instance.incrementLife()
            //DAW: Remove the life collectable from the game
            secondBody.node?.removeFromParent()
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Coin" {
            //DAW: Play the scound of the coin collectable
            //DAW: Change the coin score
            GameplayController.instance.incrementCoin()
            //DAW: Remove the coin collectable from game
            secondBody.node?.removeFromParent()
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Dark Cloud" {
            //DAW: Play the sound of death
            //DAW: Change the life score
            //DAW: Kill Player
        }
    }
    
    
    //DAW: Touches making the player move - MAKE HOOK COME OUT
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            //DAW: Pausing everything in the scene!
            if self.scene?.isPaused == false {
                if location.x > center! {
                    moveLeft = false
                    player?.animatePlayer(moveLeft: moveLeft)
                } else {
                    moveLeft = true
                    player?.animatePlayer(moveLeft: moveLeft)
                }
            }
            
            //DAW: active the Pause Panel.
            if atPoint(location).name == "Pause" {
                self.scene?.isPaused = true
                createPausePanel()
                
            }
            
            //DAW: Resume game.
            if atPoint(location).name == "Resume" {
                PauseBtnPressed?.removeFromParent()
                self.scene?.isPaused = false
            }
            //DAW: Quit game.
            if atPoint(location).name == "Quit" {
                let scene = mainMenu(fileNamed: "MainMenu")
                scene!.scaleMode = .aspectFill
                
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 0.5))
                
                print("the quit button was pressed")
            }
            
            
        }
        
        canMove = true
        
    }
    
    func intializeVariables() {
        
        physicsWorld.contactDelegate = self
        
        center = (self.scene?.size.width)! / (self.scene?.size.height)!
        
        player = self.childNode(withName: "Player") as? Player!
        player?.intializePlayerAndAnimations()
        
        mainCamera = self.childNode(withName: "Main Camera") as? SKCameraNode!
        
        getBackground()
        getLabel()
        
        GameplayController.instance.intializeVariables()
        
        rocksController.arrangeRocksInScene(scene: self.scene!, DistanceBetweenRocks: distanceBetweenRocks, center: center!, minX: minX, maxX: maxX, intialRocks: true)
        
        cameraRespawnRocks = (mainCamera?.position.y)! - 400
        
        print("Scene loaded!")
        
    }
    
    
    //DAW: BACKGROUNDS
    func getBackground() {
        bg1 = self.childNode(withName: "BG 1") as? BGClass!
        bg2 = self.childNode(withName: "BG 2") as? BGClass!
        bg3 = self.childNode(withName: "BG 3") as? BGClass!
    }
    //DAW: Stopping the walking animation, because touch has ended
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
        player?.stopPlayerAnimation()
    }
    
    //DAW: Make Player move right or left
    func managePlayer() {
        if canMove {
            player?.movePlayer(moveLeft: moveLeft)
        }
    }
    //DAW: Moving Camera downwards
    func moveCamera() {
        self.mainCamera?.position.y -= 3
    }
    //DAW: Moving Backgrounds with Camera - Needs to move with player
    func manageBackgrounds() {
        bg1?.moveBG(camera: mainCamera!)
        bg2?.moveBG(camera: mainCamera!)
        bg3?.moveBG(camera: mainCamera!)
    }
    //DAW: Creating new Rock so they're Infinite
    func createNewRocks() {
        
        if cameraRespawnRocks > (mainCamera?.position.y)! {
            cameraRespawnRocks = (mainCamera?.position.y)! - 400
            
            rocksController.arrangeRocksInScene(scene: scene!, DistanceBetweenRocks: distanceBetweenRocks, center: center!, minX: minX, maxX: maxX, intialRocks: false)
            
        }
    }
    
    //DAW: The score, coin, and life texts
        func getLabel() {
        GameplayController.instance.scoreText = self.mainCamera!.childNode(withName: "Score Text") as? SKLabelNode!
        GameplayController.instance.coinText = self.mainCamera!.childNode(withName: "Coin Text") as? SKLabelNode!
        GameplayController.instance.lifeText = self.mainCamera!.childNode(withName: "Life Text") as? SKLabelNode!
    }
    
        func createPausePanel() {
            
            //DAW: Grabbing the assests from the folder
            PauseBtnPressed = SKSpriteNode(imageNamed: "Pause Menu")
            //DAW: Creating the button actions and grabbing the assests from the folder
            let resumeBtn = SKSpriteNode(imageNamed: "Resume Button")
            let quitBtn = SKSpriteNode(imageNamed: "Quit Button 2")
            
            //DAW: Positioning, Resizing, and Putting Pause Panel ontop of scene
            PauseBtnPressed?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            PauseBtnPressed?.xScale = 1.6
            PauseBtnPressed?.yScale = 1.6
            PauseBtnPressed?.zPosition = 5
            //DAW: Making the Pause Panel Child of the mainCamera
            PauseBtnPressed?.position = CGPoint(x: (self.mainCamera?.frame.size.width)! / 2, y: (self.mainCamera?.frame.size.height)! / 2)
            //DAW: Placing and position of the Resume Button on the Pause Panel
            resumeBtn.name = "Resume"
            resumeBtn.zPosition = 6
            resumeBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            resumeBtn.position = CGPoint(x: (PauseBtnPressed?.position.x)!, y: (PauseBtnPressed?.position.y)! + 25)
            //DAW: Placing and position of the Quit Button on the Pause Panel
            quitBtn.name = "Quit"
            quitBtn.zPosition = 6
            quitBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            quitBtn.position = CGPoint(x: (PauseBtnPressed?.position.x)!, y: (PauseBtnPressed?.position.y)! - 30)
            //DAW: Adding the two buttons to the Pause Panel
            PauseBtnPressed?.addChild(resumeBtn)
            PauseBtnPressed?.addChild(quitBtn)
            //DAW: Adding the Pause Panel to the Scene
            self.mainCamera?.addChild(PauseBtnPressed!)
        }
    }
    

    

    
    
    
    
    
    
    
    
    
    
    
    




