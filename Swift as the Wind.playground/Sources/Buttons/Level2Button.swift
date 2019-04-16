//
//  Level2Button.swift
//  Wind
//
//  Created by Hugo on 15/03/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import SpriteKit

public class Level2Button: Button {
    
    public var buttonWasPressed = false
    public var buttonIsReady = true
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.parent != nil {
            if buttonWasPressed != true && buttonIsReady == true{
                buttonWasPressed = true
                self.buttonAction()
            }
        }
    }
    
    override public func buttonAction() {
        
        let scene = self.parent as! MenuScene
        scene.menuMusic.run(SKAction.changeVolume(to: 0, duration: 0.2))
        
        let reveal = SKTransition.crossFade(withDuration: 0.5)
        if let seaScene = SeaScene2(fileNamed: "seaScene2"){
            scene.view?.presentScene(seaScene, transition: reveal)
        }
        
        
    }
    
}

