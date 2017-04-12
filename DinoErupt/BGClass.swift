//
//  BGClass.swift
//  DinoErupt
//
//  Created by Darin Wilson on 3/24/17.
//  Copyright © 2017 DarinDev. All rights reserved.
//

import SpriteKit


class BGClass: SKSpriteNode {
    
    
    //DAW: Infinite Background
    func moveBG(camera: SKCameraNode) {
        if self.position.y - self.size.height - 10 > camera.position.y {
            self.position.y -= self.size.height * 3
        }
    }
    
}
