//
//  GameplayController.swift
//  DinoErupt
//
//  Created by Darin Wilson on 4/7/17.
//  Copyright © 2017 DarinDev. All rights reserved.
//

import Foundation
import SpriteKit


class GameplayController {
    
    //DAW: Using private init we do not allow any other class to create this object, but it can be called as GameplayController.instance
    static let instance = GameplayController()
    private init() {}
    
    
    //DAW: When you set an optional (?) when you call it later on you need to unwrap it with (!)
    var scoreText: SKLabelNode?
    var coinText: SKLabelNode?
    var lifeText: SKLabelNode?
    var score: Int?
    var coin: Int?
    var life: Int?
    
    func intializeVariables() {
        
        if GameManager.instance.gameStartedFromMainMenu {
            
            GameManager.instance.gameStartedFromMainMenu = false
            
            score = 0
            life = 2
            coin = 0
            
            scoreText?.text = ("\(score!)")
            lifeText?.text = ("x\(life!)")
            coinText?.text = ("x\(coin!)")
            
        } else if GameManager.instance.gameRestartedPlayerDied {
            
            GameManager.instance.gameRestartedPlayerDied = false
            
            scoreText?.text = ("\(score!)")
            lifeText?.text = ("x\(life!)")
            coinText?.text = ("x\(coin!)")
        }
        
    }
    
    func incrementLife() {
        life! += 1
        score! += 300
        lifeText?.text = "x\(life!)"
        scoreText?.text = "\(score!)"
    }
    
    func incrementCoin() {
        coin! += 1
        score! += 200
        coinText?.text = "x\(coin!)"
        scoreText?.text = "\(score!)"
    }
    
    func incrementScore() {
        score! += 1
        scoreText?.text = "\(score!)"
    }
}
    


















