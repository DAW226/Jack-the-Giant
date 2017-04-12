//
//  MainMenu.swift
//  DinoErupt
//
//  Created by Darin Wilson on 4/5/17.
//  Copyright © 2017 DarinDev. All rights reserved.
//

import SpriteKit


class mainMenu: SKScene {
    
    
    override func didMove(to view: SKView) {
        
    }
    //DAW: Touches Began either to start game, options, highscore etc
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
 
            let location = touch.location(in: self)
            
            if atPoint(location).name == "Start Game" {
                
                //DAW: Telling the app to have the labels be a child of mainCamera, check getLabel Function in gameplay scene.
                GameManager.instance.gameStartedFromMainMenu = true
                
                let scene = GameplayScene(fileNamed: "GameplayScene")
                scene!.scaleMode = .aspectFill
                //DAW: mainMenu animations
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 0.5))
                
                
                    print("the start game button was pressed")
            }

            //DAW: Highscore button pressed
            if atPoint(location).name == "Highscore" {
                
                let scene = HighscoreScene(fileNamed: "HighscoreScene")
                scene!.scaleMode = .aspectFill
                //DAW: Highscore animations
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 0.5))
                
                
                    print("the highscore button was pressed")
            }
            //DAW: Options was pressed
            if atPoint(location).name == "Option" {
                
                let scene = OptionScene(fileNamed: "OptionScene")
                scene!.scaleMode = .aspectFill
                //DAW: Options animations
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 0.5))
                
                    print("the options button was pressed")
            
            }
        }
    }
}
    
    






