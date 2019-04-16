//
//  SoundOffMenu.swift
//  Wind
//
//  Created by Hugo on 17/03/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import SpriteKit

public class SoundOffMenu: Button {
    
    public let soundOnNormalTexture = SKTexture(imageNamed: "soundOnButton")
    public let soundOnPressedTexture = SKTexture(imageNamed: "pressedSoundOnButton")
    public let soundOffNormalTexture = SKTexture(imageNamed: "soundOffButton")
    public let soundOffPressedTexture = SKTexture(imageNamed: "pressedSoundOffButton")
    
    override public func buttonAction() {
        
        if self.parent != nil {
            let scene = self.parent as! MenuScene
            
            scene.audioEngine.mainMixerNode.outputVolume = 1
            scene.soundOffButton.alpha = 0
            scene.soundOnButton.alpha = 1
            soundIsOn = true
        }
        
    }
    
    
}
