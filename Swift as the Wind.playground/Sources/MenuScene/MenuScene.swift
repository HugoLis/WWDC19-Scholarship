//
//  MenuScene.swift
//  Wind
//
//  Created by Hugo on 15/03/2019.
//  Copyright © 2018 Hugo. All rights reserved.
//

import SpriteKit

var level1BestScore: Int = 0
var level2BestScore: Int = 0
var level3BestScore: Int = 0

var level2IsUnlocked = false
var level3IsUnlocked = false
var level4IsUnlocked = false

var level2WasJustUnlocked = false
var level3WasJustUnlocked = false
var level4WasJustUnlocked = false

var usualLaunch = false

public class MenuScene: SKScene {
    
    var selectLevelLabel: SKLabelNode?
    
    var level1Button = Level1Button()
    var level2Button = Level2Button()
    var level3Button = Level3Button()
    
    var level2Locker: SKSpriteNode?
    var level3Locker: SKSpriteNode?
    var level2LockerWait: CGFloat = 0.5
    var level3LockerWait: CGFloat = 0.5
    
    var level1LastScore: Int = 0
    var level2LastScore: Int = 0
    var level3LastScore: Int = 0

    let menuMusic = SKAudioNode(fileNamed: "Sounds/menu.m4a")
    let backgroundMusic = SKAudioNode(fileNamed: "Sounds/theme.m4a")
    let pausedMusic = SKAudioNode(fileNamed: "Sounds/paused.m4a")
    
    var level1Coins: [SKSpriteNode?] = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode()]
    var level2Coins: [SKSpriteNode?] = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode()]
    var level3Coins: [SKSpriteNode?] = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode()]
    
    let coinsXOffset: CGFloat = 1.25
    let coinsYoffset: CGFloat = 0.72
    let coinsScaleDivider: CGFloat = 1.7
    let coinScale: CGFloat = 0.25
    let pauseButtonScale: CGFloat = 1.3
    
    var soundOnButton = SoundOnMenu()
    var soundOffButton = SoundOffMenu()
    
    var width: CGFloat?
    var height: CGFloat?
    var buttonScale: CGFloat = 0.3

    override public func didMove(to view: SKView) {
    
        self.view?.isMultipleTouchEnabled = false
        //self.view?.showsFPS = true
        self.view?.scene?.scaleMode = .resizeFill

        self.backgroundColor = #colorLiteral(red: 1, green: 0.9607843137, blue: 0.9019607843, alpha: 1)

        width = UIScreen.main.bounds.maxX
        height = UIScreen.main.bounds.maxY

        buttonScale = width!/2500

        let cfURL = Bundle.main.url(forResource: "Fonts/BalooChettan-Regular", withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        

        //Select Level Label
        selectLevelLabel = SKLabelNode(text: "Select a Level")
        selectLevelLabel?.fontName = "BalooChettan-Regular"
        selectLevelLabel?.fontColor = #colorLiteral(red: 0.5411764706, green: 0.3294117647, blue: 0.1490196078, alpha: 1)
        selectLevelLabel?.fontSize = 180 * buttonScale//65
        selectLevelLabel?.position = CGPoint(x: 0, y: height!/5)
        if buttonScale < 0.35 {
            selectLevelLabel?.fontSize = 50
        }
        else {
            selectLevelLabel?.fontSize = 180*buttonScale
        }
        self.addChild(selectLevelLabel!)

        //Level Buttons
        level1Button = Level1Button(normalTexture: SKTexture(imageNamed: "Menu/level1Button"), selectedTexture: SKTexture(imageNamed: "Menu/pressedLevel1Button"), disabledTexture: SKTexture(imageNamed: "Menu/pressedLevel1Button"))
        level1Button.position = CGPoint(x: -width!/3.5, y: -height!/12)
        level1Button.setScale(buttonScale)
        self.addChild(level1Button)

        level2Button = Level2Button(normalTexture: SKTexture(imageNamed: "Menu/level2Button"), selectedTexture: SKTexture(imageNamed: "Menu/pressedLevel2Button"), disabledTexture: SKTexture(imageNamed: "Menu/pressedLevel2Button"))
        level2Button.position = CGPoint(x: 0, y: -height!/12)
        level2Button.setScale(buttonScale)
        self.addChild(level2Button)

        level3Button = Level3Button(normalTexture: SKTexture(imageNamed: "Menu/level3Button"), selectedTexture: SKTexture(imageNamed: "Menu/pressedLevel3Button"), disabledTexture: SKTexture(imageNamed: "Menu/pressedLevel3Button"))
        level3Button.position = CGPoint(x: width!/3.5, y: -height!/12)
        level3Button.setScale(buttonScale)
        self.addChild(level3Button)

        level1Button.buttonIsReady = false
        level2Button.buttonIsReady = false
        level3Button.buttonIsReady = false

        self.run(SKAction.wait(forDuration: 0.2)){
            self.level1Button.buttonIsReady = true
            self.level2Button.buttonIsReady = true
            self.level3Button.buttonIsReady = true
            self.level1Button.isEnabled = true
            self.level2Button.isEnabled = true
            self.level3Button.isEnabled = true
        }

        //Level Coins
        level1Coins[0] = SKSpriteNode(imageNamed: "Coins/emptyCoin")
        level1Coins[0]?.setScale(buttonScale/coinsScaleDivider)
        self.addChild(level1Coins[0]!)
        level1Coins[1] = SKSpriteNode(imageNamed: "Coins/emptyCoin")
        level1Coins[1]?.setScale(buttonScale/coinsScaleDivider)
        self.addChild(level1Coins[1]!)
        level1Coins[2] = SKSpriteNode(imageNamed: "Coins/emptyCoin")
        level1Coins[2]?.setScale(buttonScale/coinsScaleDivider)
        self.addChild(level1Coins[2]!)

        level1Coins[0]?.position = CGPoint(x: level1Button.position.x - coinsXOffset * (level1Coins[0]?.size.width)!, y: level1Button.position.y - level1Button.size.height * coinsYoffset)
        level1Coins[1]?.position = CGPoint(x: level1Button.position.x, y: level1Button.position.y - level1Button.size.height * coinsYoffset)
        level1Coins[2]?.position = CGPoint(x: level1Button.position.x + coinsXOffset * (level1Coins[2]?.size.width)!, y: level1Button.position.y - level1Button.size.height * coinsYoffset)

        level2Coins[0] = SKSpriteNode(imageNamed: "Coins/emptyCoin")
        level2Coins[0]?.setScale(buttonScale/coinsScaleDivider)
        self.addChild(level2Coins[0]!)
        level2Coins[1] = SKSpriteNode(imageNamed: "Coins/emptyCoin")
        level2Coins[1]?.setScale(buttonScale/coinsScaleDivider)
        self.addChild(level2Coins[1]!)
        level2Coins[2] = SKSpriteNode(imageNamed: "Coins/emptyCoin")
        level2Coins[2]?.setScale(buttonScale/coinsScaleDivider)
        self.addChild(level2Coins[2]!)

        level2Coins[0]?.position = CGPoint(x: level2Button.position.x - coinsXOffset * (level2Coins[0]?.size.width)!, y: level2Button.position.y - level2Button.size.height * coinsYoffset)
        level2Coins[1]?.position = CGPoint(x: level2Button.position.x, y: level2Button.position.y - level2Button.size.height * coinsYoffset)
        level2Coins[2]?.position = CGPoint(x: level2Button.position.x + coinsXOffset * (level2Coins[2]?.size.width)!, y: level2Button.position.y - level2Button.size.height * coinsYoffset)

        level3Coins[0] = SKSpriteNode(imageNamed: "Coins/emptyCoin")
        level3Coins[0]?.setScale(buttonScale/coinsScaleDivider)
        self.addChild(level3Coins[0]!)
        level3Coins[1] = SKSpriteNode(imageNamed: "Coins/emptyCoin")
        level3Coins[1]?.setScale(buttonScale/coinsScaleDivider)
        self.addChild(level3Coins[1]!)
        level3Coins[2] = SKSpriteNode(imageNamed: "Coins/emptyCoin")
        level3Coins[2]?.setScale(buttonScale/coinsScaleDivider)
        self.addChild(level3Coins[2]!)

        level3Coins[0]?.position = CGPoint(x: level3Button.position.x - coinsXOffset * (level3Coins[0]?.size.width)!, y: level3Button.position.y - level3Button.size.height * coinsYoffset)
        level3Coins[1]?.position = CGPoint(x: level3Button.position.x, y: level3Button.position.y - level3Button.size.height * coinsYoffset)
        level3Coins[2]?.position = CGPoint(x: level3Button.position.x + coinsXOffset * (level3Coins[2]?.size.width)!, y: level3Button.position.y - level3Button.size.height * coinsYoffset)

        //Sound Button
        soundOnButton = SoundOnMenu(normalTexture: SKTexture(imageNamed: "Buttons/soundOnButton"), selectedTexture: SKTexture(imageNamed: "Buttons/pressedSoundOnButton"), disabledTexture: SKTexture(imageNamed: "Buttons/pressedSoundOnButton"))
        soundOnButton.setScale(pauseButtonScale * coinScale)
        soundOnButton.position = CGPoint(x: (level3Coins[2]?.position.x)!, y: 3 * height!/8)
        soundOnButton.zPosition = 298
        soundOnButton.alpha = 0
        self.addChild(soundOnButton)

        soundOffButton = SoundOffMenu(normalTexture: SKTexture(imageNamed: "Buttons/soundOffButton"), selectedTexture: SKTexture(imageNamed: "Buttons/pressedSoundOffButton"), disabledTexture: SKTexture(imageNamed: "Buttons/pressedSoundOffButton"))
        soundOffButton.setScale(pauseButtonScale * coinScale)
        soundOffButton.position = CGPoint(x: (level3Coins[2]?.position.x)!, y: 3 * height!/8)
        soundOffButton.zPosition = 297
        soundOffButton.alpha = 0
        self.addChild(soundOffButton)

        if soundIsOn == true{
            soundOnButton.alpha = 1
        }
        else{
            soundOffButton.alpha = 1
        }

        manageCoinsAndLockers()

        //Adding Music
        self.audioEngine.mainMixerNode.outputVolume = 0
        self.addChild(self.menuMusic)
        if soundIsOn == true {
            self.audioEngine.mainMixerNode.outputVolume = 1
        }
        
        //Preloading level1 textures
        if usualLaunch == false {
            SKTexture.preload([SKTexture(imageNamed: "Lakes/lakeIn1"), SKTexture(imageNamed: "Lakes/lakeOut1"), SKTexture(imageNamed: "Menu/pressedLevel1Button"), SKTexture(imageNamed: "Lakes/finishLine"), SKTexture(imageNamed: "Coins/fishCoin"), SKTexture(imageNamed: "Coins/Boost"), SKTexture(imageNamed: "Coins/emptyCoin"), SKTexture(imageNamed: "spark"), SKTexture(imageNamed: "Boat/boat"), SKTexture(imageNamed: "Boat/Sail"), SKTexture(imageNamed: "Buttons/pauseButton"), SKTexture(imageNamed: "Wheels/sailWheel"), SKTexture(imageNamed: "Wheels/shipWheel")], withCompletionHandler: {
                //print("complete")
            } )
            usualLaunch = true
        }
        
    } //didMove
    
    override public func update(_ currentTime: TimeInterval) {
        
        width = self.view?.window?.frame.size.width
        height = self.view?.window?.frame.size.height
        buttonScale = width!/2500

        selectLevelLabel?.position = CGPoint(x: 0, y: height!/5)
        if buttonScale < 0.35 {
            selectLevelLabel?.fontSize = 50
        }
        else {
            selectLevelLabel?.fontSize = 180*buttonScale
        }

        level1Button.position = CGPoint(x: -width!/3.5, y: -height!/12)
        level2Button.position = CGPoint(x: 0, y: -height!/12)
        level3Button.position = CGPoint(x: width!/3.5, y: -height!/12)

        level2Locker?.position = level2Button.position
        level2Locker?.setScale(buttonScale)
        level3Locker?.position = level3Button.position
        level3Locker?.setScale(buttonScale)

        level1Button.setScale(buttonScale)
        level2Button.setScale(buttonScale)
        level3Button.setScale(buttonScale)

        level1Coins[0]?.setScale(buttonScale/coinsScaleDivider)
        level1Coins[1]?.setScale(buttonScale/coinsScaleDivider)
        level1Coins[2]?.setScale(buttonScale/coinsScaleDivider)

        level1Coins[0]?.position = CGPoint(x: level1Button.position.x - coinsXOffset * (level1Coins[0]?.size.width)!, y: level1Button.position.y - level1Button.size.height * coinsYoffset)
        level1Coins[1]?.position = CGPoint(x: level1Button.position.x, y: level1Button.position.y - level1Button.size.height * coinsYoffset)
        level1Coins[2]?.position = CGPoint(x: level1Button.position.x + coinsXOffset * (level1Coins[2]?.size.width)!, y: level1Button.position.y - level1Button.size.height * coinsYoffset)

        level2Coins[0]?.setScale(buttonScale/coinsScaleDivider)
        level2Coins[1]?.setScale(buttonScale/coinsScaleDivider)
        level2Coins[2]?.setScale(buttonScale/coinsScaleDivider)

        level2Coins[0]?.position = CGPoint(x: level2Button.position.x - coinsXOffset * (level2Coins[0]?.size.width)!, y: level2Button.position.y - level2Button.size.height * coinsYoffset)
        level2Coins[1]?.position = CGPoint(x: level2Button.position.x, y: level2Button.position.y - level2Button.size.height * coinsYoffset)
        level2Coins[2]?.position = CGPoint(x: level2Button.position.x + coinsXOffset * (level2Coins[2]?.size.width)!, y: level2Button.position.y - level2Button.size.height * coinsYoffset)

        level3Coins[0]?.setScale(buttonScale/coinsScaleDivider)
        level3Coins[1]?.setScale(buttonScale/coinsScaleDivider)
        level3Coins[2]?.setScale(buttonScale/coinsScaleDivider)

        level3Coins[0]?.position = CGPoint(x: level3Button.position.x - coinsXOffset * (level3Coins[0]?.size.width)!, y: level3Button.position.y - level3Button.size.height * coinsYoffset)
        level3Coins[1]?.position = CGPoint(x: level3Button.position.x, y: level3Button.position.y - level3Button.size.height * coinsYoffset)
        level3Coins[2]?.position = CGPoint(x: level3Button.position.x + coinsXOffset * (level3Coins[2]?.size.width)!, y: level3Button.position.y - level3Button.size.height * coinsYoffset)

        soundOnButton.position = CGPoint(x: (level3Coins[2]?.position.x)!, y: 3 * height!/8)
        soundOffButton.position = CGPoint(x: (level3Coins[2]?.position.x)!, y: 3 * height!/8)

    }
    
    public func menuCoinAnimation (coin: SKSpriteNode) {
        let coinToFade = SKSpriteNode(imageNamed: "Coins/emptyCoin")
        coinToFade.setScale(coin.xScale)
        coinToFade.position = (coin.position)
        coinToFade.zPosition = coin.zPosition + 1
        self.addChild(coinToFade)
        
        coinToFade.run(SKAction.scale(to: (self.buttonScale/self.coinsScaleDivider) * 1.1 , duration: 0.1))
        coin.run(SKAction.scale(to: (self.buttonScale/self.coinsScaleDivider) * 1.1 , duration: 0.1))
        
        self.run(SKAction.wait(forDuration: 0.1)){
            coinToFade.run(SKAction.scale(to: (self.buttonScale/self.coinsScaleDivider) / 1.1 , duration: 0.1))
            coin.run(SKAction.scale(to: (self.buttonScale/self.coinsScaleDivider) / 1.1 , duration: 0.1))
            coinToFade.run(SKAction.fadeOut(withDuration: 0.2))
        }

    }
    
}

