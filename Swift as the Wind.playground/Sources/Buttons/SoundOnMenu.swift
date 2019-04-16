//
//  SoundOnMenu.swift
//  Wind
//
//  Created by Hugo on 14/03/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import SpriteKit

public class SoundOnMenu: Button {
    
    public let soundOnNormalTexture = SKTexture(imageNamed: "soundOnButton")
    public let soundOnPressedTexture = SKTexture(imageNamed: "pressedSoundOnButton")
    public let soundOffNormalTexture = SKTexture(imageNamed: "soundOffButton")
    public let soundOffPressedTexture = SKTexture(imageNamed: "pressedSoundOffButton")
    
    override public func buttonAction() {
        
        if self.parent != nil {
            let scene = self.parent as! MenuScene
            
            scene.audioEngine.mainMixerNode.outputVolume = 0
            scene.soundOnButton.alpha = 0
            scene.soundOffButton.alpha = 1
            soundIsOn = false
        }
        
    }
    
    
}
