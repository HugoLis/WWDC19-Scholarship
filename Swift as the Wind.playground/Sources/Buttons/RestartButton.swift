//
//  RestartButton.swift
//  Wind
//
//  Created by Hugo Lispector on 14/03/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import SpriteKit

public class RestartButton: Button {
    
    public var buttonWasPressed = false
    public var level: Int?
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.parent != nil{
            if buttonWasPressed != true{
                buttonWasPressed = true
                self.buttonAction()
            }
        }
    }
    
    override public func buttonAction() {
        let cameraNode = self.parent as! SKCameraNode
        let scene = cameraNode.parent as! SeaScene
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        
        switch level {
        case 1:
            if let restartScene = SeaScene1(fileNamed: "seaScene1"){
                restartScene.scaleMode = .resizeFill
                restartScene.isPreStart = false
                scene.self.view?.presentScene(restartScene, transition: reveal)
            }
        case 2:
            if let restartScene = SeaScene2(fileNamed: "seaScene2"){
                restartScene.scaleMode = .resizeFill
                restartScene.isPreStart = false
                scene.self.view?.presentScene(restartScene, transition: reveal)
            }
        default: //case 3 or not set
            if let restartScene = SeaScene3(fileNamed: "seaScene3"){
                restartScene.scaleMode = .resizeFill
                restartScene.isPreStart = false
                scene.self.view?.presentScene(restartScene, transition: reveal)
            }
        }

        
    }
    
}
