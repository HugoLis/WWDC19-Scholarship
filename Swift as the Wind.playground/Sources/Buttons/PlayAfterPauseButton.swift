//
//  StartPlayButton.swift
//  Wind
//
//  Created by Hugo Lispector on 14/03/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import SpriteKit

public class PlayAfterPauseButton: Button {
    
    public var buttonWasPressed = false
    public var buttonIsReady = false
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if buttonWasPressed != true && buttonIsReady == true{
            buttonWasPressed = true
            self.buttonAction()
        }
    }
    
    override public func buttonAction() {

        let cameraNode = self.parent as! SKCameraNode
        let scene = cameraNode.parent as! SeaScene
        
        scene.pauseCurtain?.run(SKAction.fadeOut(withDuration: 0.2))
        
        scene.backgroundMusic.run(SKAction.changeVolume(to: 1, duration: 0.2))
        scene.pausedMusic.run(SKAction.changeVolume(to: 0, duration: 0.2))
        
        scene.run(SKAction.wait(forDuration: 0.2 * 2/3)){
            scene.restartButton.run(SKAction.move(to: CGPoint(x: (scene.sailWheel?.position.x)!, y: scene.height!/2 - scene.topItemsYOffset * scene.pauseButtonScale * (scene.coinHolder1?.size.height)!), duration: 0.2 * 1/3))
            scene.restartButton.run(SKAction.fadeOut(withDuration: 0.2 * 1/3))
        }
        
        scene.run(SKAction.wait(forDuration: 0.2 * 1/3)){
        
            scene.soundOnButton.run(SKAction.fadeOut(withDuration: 0.2 * 1/3))
            scene.soundOffButton.run(SKAction.fadeOut(withDuration: 0.2 * 1/3))

            scene.soundOnButton.run(SKAction.move(to: CGPoint(x: (scene.sailWheel?.position.x)!, y: scene.height!/2 - scene.topItemsYOffset * scene.pauseButtonScale * (scene.coinHolder1?.size.height)!), duration: 0.2 * 2/3))

            scene.soundOffButton.run(SKAction.move(to: CGPoint(x: (scene.sailWheel?.position.x)!, y: scene.height!/2 - scene.topItemsYOffset * scene.pauseButtonScale * (scene.coinHolder1?.size.height)!), duration: 0.2 * 2/3))
        }
        
        scene.homeButton.run(SKAction.fadeOut(withDuration: 0.2 * 1.3))
        scene.homeButton.run(SKAction.move(to: CGPoint(x: (scene.sailWheel?.position.x)!, y: scene.height!/2 - scene.topItemsYOffset * scene.pauseButtonScale * (scene.coinHolder1?.size.height)!), duration: 0.2))

        scene.pauseButton.isSelected = false
        scene.pauseButton.buttonWasPressed = false
        scene.pauseButton.buttonIsReady = false
        scene.camera?.addChild(scene.pauseButton)

        scene.pauseButton.alpha = 1
        
        self.run(SKAction.fadeOut(withDuration: 0.2))
        self.run(SKAction.wait(forDuration: 0.2)){
            scene.pauseCurtain?.removeFromParent()
            scene.restartButton.removeFromParent()
            scene.soundOnButton.removeFromParent()
            scene.soundOffButton.removeFromParent()
            scene.homeButton.removeFromParent()
            
            scene.isGamePaused = false
            scene.physicsWorld.speed = 1
            scene.boat?.isPaused = false
            scene.windParticle?.isPaused = false
            
            scene.pauseButton.buttonIsReady = true
            scene.pauseButton.isSelected = false
            self.removeFromParent()
        }
        
        
        
    }
    
}
