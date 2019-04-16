//
//  HomeButton.swift
//  Wind
//
//  Created by Hugo on 14/03/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import SpriteKit

public class HomeButton: Button {
    
    public var buttonWasPressed = false
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.parent != nil {
            if buttonWasPressed != true{
                buttonWasPressed = true
                self.buttonAction()
            }
        }
    }
    
    override public func buttonAction() {
        let cameraNode = self.parent as! SKCameraNode
        let scene = cameraNode.parent as! SeaScene
        
        let reveal = SKTransition.crossFade(withDuration: 0.5)
        
        if let menuScene = MenuScene(fileNamed: "menuScene"){
            menuScene.scaleMode = .resizeFill
            scene.self.view?.presentScene(menuScene, transition: reveal)
        }

    }
        
}
    


