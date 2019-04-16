//
//  Pause.swift
//  Wind
//
//  Created by Hugo Lispector on 14/03/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import SpriteKit

public class PauseButton: Button {
    
    public var buttonWasPressed = false
    public var buttonIsReady = true
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if buttonWasPressed != true && buttonIsReady == true{
            buttonWasPressed = true
            self.buttonAction()
        }
    }
    
    override public func buttonAction() {
        let cameraNode = self.parent as! SKCameraNode
        let scene = cameraNode.parent as! SeaScene
        
        scene.camera?.removeAllActions()
        
        scene.isGamePaused = true
        scene.physicsWorld.speed = 0
        scene.boat?.isPaused = true
        scene.windParticle?.isPaused = true
        
        scene.camera?.addChild(scene.pauseCurtain!)
        scene.playAfterPauseButton.isSelected = false
        scene.playAfterPauseButton.buttonWasPressed = false
        scene.restartButton.isSelected = false
        
        scene.camera?.addChild(scene.playAfterPauseButton)
        
        scene.camera?.addChild(scene.restartButton)
        scene.camera?.addChild(scene.soundOnButton)
        scene.camera?.addChild(scene.soundOffButton)
        scene.camera?.addChild(scene.homeButton)
        
        scene.playAfterPauseButton.alpha = 1
        scene.playAfterPauseButton.buttonIsReady = false
        scene.pauseCurtain?.run(SKAction.fadeIn(withDuration: 0.2))
        
        scene.backgroundMusic.run(SKAction.changeVolume(to: 0, duration: 0.2))
        scene.pausedMusic.run(SKAction.changeVolume(to: 1, duration: 0.2))
        
        scene.restartButton.run(SKAction.move(to: CGPoint(x: (scene.sailWheel?.position.x)! - 1.35 * scene.restartButton.size.width, y: scene.height!/2 - scene.topItemsYOffset * scene.pauseButtonScale * (scene.coinHolder1?.size.height)!), duration: 0.2 * 1/3))
        scene.restartButton.run(SKAction.fadeIn(withDuration: 0.2 * 1/3))

        scene.soundOnButton.run(SKAction.move(to: CGPoint(x: (scene.sailWheel?.position.x)! - 2 * 1.35 * scene.restartButton.size.width, y: scene.height!/2 - scene.topItemsYOffset * scene.pauseButtonScale * (scene.coinHolder1?.size.height)!), duration: 0.2 * 2/3))
        scene.soundOffButton.run(SKAction.move(to: CGPoint(x: (scene.sailWheel?.position.x)! - 2 * 1.35 * scene.restartButton.size.width, y: scene.height!/2 - scene.topItemsYOffset * scene.pauseButtonScale * (scene.coinHolder1?.size.height)!), duration: 0.2 * 2/3))
        
        scene.run(SKAction.wait(forDuration: 0.2 * 1/3)){
            if soundIsOn == true{
                scene.soundOnButton.run(SKAction.fadeIn(withDuration: 0.2 * 1/3))
            }
            else{
                scene.soundOffButton.run(SKAction.fadeIn(withDuration: 0.2 * 1/3))
            }
        }
        
        scene.homeButton.run(SKAction.move(to: CGPoint(x: (scene.sailWheel?.position.x)! - 3 * 1.35 * scene.restartButton.size.width, y: scene.height!/2 - scene.topItemsYOffset * scene.pauseButtonScale * (scene.coinHolder1?.size.height)!), duration: 0.2))
        scene.run(SKAction.wait(forDuration: 0.2 * 2/3)){
            scene.homeButton.run(SKAction.fadeIn(withDuration: 0.2 * 1/3))
        }
        
        self.run(SKAction.wait(forDuration: 0.2)){
            scene.playAfterPauseButton.buttonIsReady = true
            scene.playAfterPauseButton.isSelected = false
            self.removeFromParent()
        }
        
        
        
    }
    
}
