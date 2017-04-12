//
//  OptionScene.swift
//  DinoErupt
//
//  Created by Darin Wilson on 4/5/17.
//  Copyright © 2017 DarinDev. All rights reserved.
//

import SpriteKit

class OptionScene: SKScene {
    
    override func didMove(to view: SKView) {
        
    }
    //Back Button was pressed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "Back" {
                
                let scene = mainMenu(fileNamed: "MainMenu")
                scene!.scaleMode = .aspectFill
                
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 0.5))
                
                print("the back button was pressed")
    
            }
        }
    }
}

