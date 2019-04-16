//
//  SeaScene2.swift
//  Wind
//
//  Created by Hugo on 16/03/2019.
//  Copyright © 2018 Hugo. All rights reserved.
//

import SpriteKit

public class SeaScene2: SeaScene {
 
    override public func didMove(to view: SKView) {
        
        self.view?.isMultipleTouchEnabled = true
        //self.view?.showsPhysics = true
        self.view?.scene?.scaleMode = .resizeFill
        
        self.physicsWorld.contactDelegate = self
        
        self.backgroundColor = #colorLiteral(red: 0.2705882353, green: 0.5215686275, blue: 0.09411764706, alpha: 1)
        
        width = UIScreen.main.bounds.maxX
        height = UIScreen.main.bounds.maxY
        
        myCamera = self.childNode(withName: "myCamera") as? SKCameraNode
        self.camera = myCamera
        
        apparentWind = wind //just in the first moment
        
        boat = self.childNode(withName: "boat") as? SKSpriteNode
        boat?.texture = SKTexture(imageNamed: "Boat/boat")
        sail = boat?.childNode(withName: "sail") as? SKSpriteNode
        sail?.texture = SKTexture(imageNamed: "Boat/sail")
        
        shipWheel = self.camera!.childNode(withName: "shipWheel") as? SKSpriteNode
        sailWheel = self.camera!.childNode(withName: "sailWheel") as? SKSpriteNode
        shipWheel?.texture = SKTexture(imageNamed: "Wheels/shipWheel")
        sailWheel?.texture = SKTexture(imageNamed: "Wheels/sailWheel")

        shipWheel?.alpha = 0
        sailWheel?.alpha = 0
        
        //boat rotation in rad
        boat?.zRotation = -CGFloat.pi/4
        sail?.zRotation = CGFloat.pi/4
        
        //Boat's physicsBody texture
        let boatPhysicsSmallTexture = SKTexture(imageNamed: "Boat/boatPhysicsTextureOff70")
        boat?.physicsBody = SKPhysicsBody(texture: boatPhysicsSmallTexture, size: CGSize(width: boatPhysicsSmallTexture.size().width * (boat?.xScale)! * 0.7, height:  boatPhysicsSmallTexture.size().height * (boat?.yScale)! * 0.7))

        boat?.physicsBody?.mass = 30
        boat?.physicsBody?.affectedByGravity = false
        boat?.physicsBody?.isDynamic = true
        boat?.physicsBody?.angularDamping = 20
        boat?.physicsBody?.categoryBitMask = PhysicsCategory.boat
        boat?.physicsBody?.collisionBitMask = PhysicsCategory.edge
        boat?.physicsBody?.contactTestBitMask = PhysicsCategory.coin
        boat?.physicsBody?.fieldBitMask = PhysicsCategory.boatField
        boat?.physicsBody?.usesPreciseCollisionDetection = true
        
        shipWheel?.physicsBody = SKPhysicsBody(circleOfRadius: shipWheel!.size.height/2)
        shipWheel?.physicsBody?.angularDamping = 12
        shipWheel?.physicsBody?.affectedByGravity = false
        shipWheel?.physicsBody?.collisionBitMask = PhysicsCategory.none
        shipWheel?.physicsBody?.categoryBitMask = PhysicsCategory.none
        shipWheel?.physicsBody?.fieldBitMask = PhysicsCategory.none
        
        sailWheel?.physicsBody = SKPhysicsBody(circleOfRadius: sailWheel!.size.height/2)
        sailWheel?.physicsBody?.angularDamping = 12
        sailWheel?.physicsBody?.affectedByGravity = false
        sailWheel?.physicsBody?.collisionBitMask = PhysicsCategory.none
        sailWheel?.physicsBody?.categoryBitMask = PhysicsCategory.none
        sailWheel?.physicsBody?.fieldBitMask = PhysicsCategory.none
        
        if 3.5 * (shipWheel?.size.width)! > width! {
            wheelsXOffset = 110
        }
        else {
            wheelsXOffset = 150
        }
        
        shipWheel?.position = CGPoint(x: -(width!/2) + wheelsXOffset , y: -(height!/4) + 2 * wheelsYOffset)
        sailWheel?.position = CGPoint(x: (width!/2) - wheelsXOffset , y: -(height!/4) + 2 * wheelsYOffset)
        coinScale = 0.25
        cameraScale = 0.85
        self.camera!.setScale(cameraScale * cameraScaleAmplifier)
        pauseScreenYDivider = 4
        
        //Adding Music
        self.audioEngine.mainMixerNode.outputVolume = 0
        pausedMusic.run(SKAction.changeVolume(to: 0, duration: 0))
        backgroundMusic.run(SKAction.changeVolume(to: 0, duration: 0))
        
        self.run(SKAction.wait(forDuration: 0.2)){
            self.addChild(self.backgroundMusic)
            self.addChild(self.pausedMusic)
        }
        
        if soundIsOn == true {
            self.audioEngine.mainMixerNode.outputVolume = 1
            self.run(SKAction.wait(forDuration: 0.2)){
                self.backgroundMusic.run(SKAction.changeVolume(to: 1, duration: 0.1))
            }
        }
        
        //Boat trail
        boatTrail?.particleBirthRate = 0
        boatTrail?.position = CGPoint(x: 0, y: 0)
        boatTrail?.zPosition = 10
        boatTrail?.targetNode = self.scene
        boat?.addChild(boatTrail!)
        
        boatBoostTrail?.position = CGPoint(x: 0, y: 0)
        boatBoostTrail?.zPosition = 11
        boatBoostTrail?.targetNode = self.scene
        boatBoostTrail?.particleBirthRate = 0
        boat?.addChild(boatBoostTrail!)
        
        //Wind
        windParticle?.position = CGPoint(x: 0, y: -1.1 * width!)
        windParticle?.particlePositionRange.dx = 2 * width!
        windParticle?.particleSpeed = wind.length()
        windParticle?.particleSpeedRange = wind.length()/10
        windParticle?.zPosition = 150
        windParticle?.targetNode = self.scene
        windParticle?.emissionAngle = CGFloat.pi/2
        self.camera!.addChild(windParticle!)
        
        //lake setup
        lakeIn = self.childNode(withName: "lakeIn") as? SKSpriteNode
        lakeIn?.texture = SKTexture(imageNamed: "Lakes/lakeIn2")
        lakeIn?.setScale(2/3)
        lakeOut = self.childNode(withName: "lakeOut") as? SKSpriteNode
        lakeOut?.texture = SKTexture(imageNamed: "Lakes/lakeOut2")
        lakeOut?.setScale(2/3)
        
        //coins setup
        coin1 = self.childNode(withName: "coin1") as? SKSpriteNode
        coin1?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        coin1?.physicsBody = SKPhysicsBody(circleOfRadius: (coin1?.size.width)!/2)
        coin1?.physicsBody?.isDynamic = false
        coin1?.physicsBody?.categoryBitMask = PhysicsCategory.coin
        coin1?.physicsBody?.collisionBitMask = PhysicsCategory.none
        coin1?.physicsBody?.contactTestBitMask = PhysicsCategory.boat
        
        coin2 = self.childNode(withName: "coin2") as? SKSpriteNode
        coin2?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        coin2?.physicsBody = SKPhysicsBody(circleOfRadius: (coin2?.size.width)!/2)
        coin2?.physicsBody?.isDynamic = false
        coin2?.physicsBody?.categoryBitMask = PhysicsCategory.coin
        coin2?.physicsBody?.collisionBitMask = PhysicsCategory.none
        coin2?.physicsBody?.contactTestBitMask = PhysicsCategory.boat
        
        coin3 = self.childNode(withName: "coin3") as? SKSpriteNode
        coin3?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        coin3?.physicsBody = SKPhysicsBody(circleOfRadius: (coin3?.size.width)!/2)
        coin3?.physicsBody?.isDynamic = false
        coin3?.physicsBody?.categoryBitMask = PhysicsCategory.coin
        coin3?.physicsBody?.collisionBitMask = PhysicsCategory.none
        coin3?.physicsBody?.contactTestBitMask = PhysicsCategory.boat
        
        
        //coinHolder Setup
        coinHolder1 = SKSpriteNode(imageNamed: "Coins/emptyCoin")
        coinHolder2 = SKSpriteNode(imageNamed: "Coins/emptyCoin")
        coinHolder3 = SKSpriteNode(imageNamed: "Coins/emptyCoin")
        
        //center
        coinHolder1!.setScale(coinScale)
        coinHolder1!.zPosition = 200
        
        coinHolder2!.setScale(coinScale)
        coinHolder2!.zPosition = 200
        coinHolder2!.position = CGPoint(x: (shipWheel?.position.x)! - 1.25 * coinHolder1!.size.width , y: height!/2 - coinHolder1!.size.height)
        
        coinHolder3!.setScale(coinScale)
        coinHolder3!.zPosition = 200
        coinHolder3!.position = CGPoint(x: (shipWheel?.position.x)! + 1.25 * coinHolder3!.size.width , y: height!/2 - coinHolder3!.size.height)
        
        coinHolder1!.position = CGPoint(x: (shipWheel?.position.x)! - 1.25 * coinHolder1!.size.width , y: height!/2 - topItemsYOffset * pauseButtonScale * coinHolder1!.size.height)
        coinHolder2!.position = CGPoint(x: (shipWheel?.position.x)!, y: height!/2 - topItemsYOffset * pauseButtonScale * coinHolder2!.size.height)
        coinHolder3!.position = CGPoint(x: (shipWheel?.position.x)! + 1.25 * coinHolder3!.size.width , y: height!/2 - topItemsYOffset * pauseButtonScale * coinHolder3!.size.height)
        
        coinHolder1!.alpha = 0
        coinHolder2!.alpha = 0
        coinHolder3!.alpha = 0
        
        self.camera!.addChild(coinHolder1!)
        self.camera!.addChild(coinHolder2!)
        self.camera!.addChild(coinHolder3!)
        
        //boost setup
        boost = self.childNode(withName: "boost") as? SKSpriteNode
        boost?.texture = SKTexture(imageNamed: "Coins/boost")
        boost?.physicsBody = SKPhysicsBody(circleOfRadius: (boost?.size.width)!/2)
        boost?.physicsBody?.isDynamic = false
        boost?.physicsBody?.categoryBitMask = PhysicsCategory.boost
        boost?.physicsBody?.contactTestBitMask = PhysicsCategory.boat
        
        //Finish Line
        finishLine = self.childNode(withName: "finishLine") as? SKSpriteNode
        finishLine?.texture = SKTexture(imageNamed: "Lakes/finishLine")
        finishLineSon = finishLine?.childNode(withName: "finishLineSon") as? SKSpriteNode
        finishLineSon?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (finishLineSon?.size.width)!, height: (finishLineSon?.size.height)!))
        finishLineSon?.physicsBody?.categoryBitMask = PhysicsCategory.finishLine
        finishLineSon?.physicsBody?.collisionBitMask = PhysicsCategory.none
        finishLineSon?.physicsBody?.contactTestBitMask = PhysicsCategory.boat
        finishLineSon?.physicsBody?.fieldBitMask = PhysicsCategory.none
        finishLineSon?.physicsBody?.isDynamic = false
        
        let lake2 = Paths(lakeNumber: 2)
        lakeIn?.physicsBody = SKPhysicsBody(edgeLoopFrom: lake2.shape.cgPath)
        lakeIn?.physicsBody?.categoryBitMask = PhysicsCategory.edge
        lakeIn?.physicsBody?.collisionBitMask = PhysicsCategory.boat
        
        pauseButton = PauseButton(normalTexture: SKTexture(imageNamed: "Buttons/pauseButton"), selectedTexture: SKTexture(imageNamed: "Buttons/pressedPauseButton"), disabledTexture: SKTexture(imageNamed: "Buttons/pressedPauseButton"))
        pauseButton.setScale(pauseButtonScale * coinScale)
        pauseButton.position = CGPoint(x: (sailWheel?.position.x)!, y: height!/2 - topItemsYOffset * pauseButtonScale * (coinHolder1?.size.height)!)
        pauseButton.zPosition = 300
        pauseButton.alpha = 0
        self.camera!.addChild(pauseButton)
        
        playAfterPauseButton = PlayAfterPauseButton(normalTexture: SKTexture(imageNamed: "Buttons/playButton"), selectedTexture: SKTexture(imageNamed: "Buttons/pressedPlayButton"), disabledTexture: SKTexture(imageNamed: "Buttons/pressedPlayButton"))
        playAfterPauseButton.setScale(pauseButtonScale * coinScale)
        playAfterPauseButton.position = CGPoint(x: (sailWheel?.position.x)!, y: height!/2 - topItemsYOffset * pauseButtonScale * (coinHolder1?.size.height)!)
        playAfterPauseButton.zPosition = 300
        playAfterPauseButton.alpha = 0
        
        restartButton = RestartButton(normalTexture: SKTexture(imageNamed: "Buttons/restartButton"), selectedTexture: SKTexture(imageNamed: "Buttons/pressedRestartButton"), disabledTexture: SKTexture(imageNamed: "Buttons/pressedRestartButton"))
        restartButton.level = 2
        restartButton.setScale(pauseButtonScale * coinScale)
        restartButton.position = CGPoint(x: (sailWheel?.position.x)!, y: height!/2 - topItemsYOffset * pauseButtonScale * (coinHolder1?.size.height)!)
        restartButton.zPosition = 299
        restartButton.alpha = 0
        
        soundOnButton = SoundOnButton(normalTexture: SKTexture(imageNamed: "Buttons/soundOnButton"), selectedTexture: SKTexture(imageNamed: "Buttons/pressedSoundOnButton"), disabledTexture: SKTexture(imageNamed: "Buttons/pressedSoundOnButton"))
        soundOnButton.setScale(pauseButtonScale * coinScale)
        soundOnButton.position = CGPoint(x: (sailWheel?.position.x)!, y: height!/2 - topItemsYOffset * pauseButtonScale * (coinHolder1?.size.height)!)
        soundOnButton.zPosition = 298
        soundOnButton.alpha = 0
        
        soundOffButton = SoundOffButton(normalTexture: SKTexture(imageNamed: "Buttons/soundOffButton"), selectedTexture: SKTexture(imageNamed: "Buttons/pressedSoundOffButton"), disabledTexture: SKTexture(imageNamed: "Buttons/pressedSoundOffButton"))
        soundOffButton.setScale(pauseButtonScale * coinScale)
        soundOffButton.position = CGPoint(x: (sailWheel?.position.x)!, y: height!/2 - topItemsYOffset * pauseButtonScale * (coinHolder1?.size.height)!)
        soundOffButton.zPosition = 297
        soundOffButton.alpha = 0
        
        homeButton = HomeButton(normalTexture: SKTexture(imageNamed: "Buttons/homeButton"), selectedTexture: SKTexture(imageNamed: "Buttons/pressedHomeButton"), disabledTexture: SKTexture(imageNamed: "Buttons/pressedHomeButton"))
        homeButton.setScale(pauseButtonScale * coinScale)
        homeButton.position = CGPoint(x: (sailWheel?.position.x)!, y: height!/2 - topItemsYOffset * pauseButtonScale * (coinHolder1?.size.height)!)
        homeButton.zPosition = 296
        homeButton.alpha = 0
        
        let longerDimension = width! > height! ? width : height
        pauseCurtain = SKSpriteNode(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6), size: CGSize(width: longerDimension!, height: longerDimension!))
        pauseCurtain?.zPosition = 250
        pauseCurtain?.alpha = 0
        
        let boatNose = CGPoint(x:(boat?.position.x)! - (boat?.size.height)! * sin((boat?.zRotation)!), y:(boat?.position.y)! + (boat?.size.height)! * cos((boat?.zRotation)!))
        
        SKTexture.preload([SKTexture(imageNamed: "Coins/coin"), SKTexture(imageNamed: "Coins/boost"), SKTexture(imageNamed: "Boat/boat"), SKTexture(imageNamed: "Boat/sail"), SKTexture(imageNamed: "Boat/boatPhysicsTextureOff70"), SKTexture(imageNamed: "spark")], withCompletionHandler: {
            //print("complete")
        } )
        
        if isPreStart == true {
            self.camera?.position = (self.finishLine?.position)!
            self.camera?.setScale(self.cameraScale * self.cameraScaleAmplifier)
            
            let cameraBackToNormal = SKAction.scale(to: self.cameraScale / self.cameraScaleAmplifier, duration: 1)
            cameraBackToNormal.timingMode = .easeInEaseOut
            
            let preStartAction = SKAction.run {
                self.run(SKAction.wait(forDuration: 1)){
                    let initialCameraOverview = SKAction.move(to: boatNose, duration: 3)
                    initialCameraOverview.timingMode = .easeInEaseOut
                    self.camera?.run(initialCameraOverview)
                }
                self.run(SKAction.wait(forDuration: 2.5)){
                    self.camera?.run(cameraBackToNormal)
                }
                
                self.run(SKAction.wait(forDuration: 4)){
                    self.isPreStart = false
                    self.pauseButton.run(SKAction.fadeIn(withDuration: 0.2))
                    self.shipWheel!.run(SKAction.fadeIn(withDuration: 0.2))
                    self.sailWheel!.run(SKAction.fadeIn(withDuration: 0.2))
                    self.coinHolder1!.run(SKAction.fadeIn(withDuration: 0.2))
                    self.coinHolder2!.run(SKAction.fadeIn(withDuration: 0.2))
                    self.coinHolder3!.run(SKAction.fadeIn(withDuration: 0.2))
                }
                
            }
            self.run(preStartAction)
            
        }
        else {
            pauseButton.alpha = 1
            shipWheel?.alpha = 1
            sailWheel?.alpha = 1
            coinHolder1?.alpha = 1
            coinHolder2?.alpha = 1
            coinHolder3?.alpha = 1
            camera?.setScale(cameraScale / self.cameraScaleAmplifier)
            camera?.position = boatNose
        }
        
    } //didMove
    
    override public func boatDidCollideWithFinishLine(boat: SKSpriteNode, finishLineSon: SKSpriteNode) {
        if (finishLineSon.parent != nil) {
            
            finishLineSon.removeFromParent()
            
            if soundIsOn == true {
                fireworksSound.autoplayLooped = false
                self.addChild(fireworksSound)
                fireworksSound.run(SKAction.play())
                self.run(SKAction.wait(forDuration: 2)){
                    self.fireworksSound.run(SKAction.changeVolume(to: 0, duration: 1))
                }
            }

            
            let fireworksAction = SKAction.run {
                
                let confetti = SKEmitterNode(fileNamed: "Particles/confetti")
                confetti?.position = CGPoint(x: CGFloat.random(in: -150...150), y: CGFloat.random(in: 50...200))
                self.finishLine?.addChild(confetti!)
                
                let confetti2 = SKEmitterNode(fileNamed: "Particles/confetti")
                confetti2?.position = CGPoint(x: CGFloat.random(in: -150...150), y: CGFloat.random(in: 50...200))
                self.run(SKAction.wait(forDuration: Double.random(in: 0...0.4))){
                    self.finishLine?.addChild(confetti2!)
                }
                
                let confetti3 = SKEmitterNode(fileNamed: "Particles/confetti")
                confetti3?.position = CGPoint(x: CGFloat.random(in: -150...150), y: CGFloat.random(in: 50...200))
                self.run(SKAction.wait(forDuration: Double.random(in: 0...0.4))){
                    self.finishLine?.addChild(confetti3!)
                }
                
                self.run(SKAction.wait(forDuration: 2)){
                    confetti?.removeFromParent()
                    confetti2?.removeFromParent()
                    confetti3?.removeFromParent()
                }
                
            }
            
            let waitAction = SKAction.wait(forDuration: Double.random(in: 1.1...1.6))
            
            self.run(SKAction.repeat(SKAction.sequence([fireworksAction, waitAction]), count: 2))
            
            pauseButton.buttonIsReady = false
            pauseButton.run(SKAction.fadeOut(withDuration: 0.2))
            
            SKTexture.preload([SKTexture(imageNamed: "Menu/pressedLevel3Button")], withCompletionHandler: {
                //print("complete")
            } )
            
            self.run(SKAction.wait(forDuration: 2)){
                
                if let menuScene = MenuScene(fileNamed: "menuScene"){
                    menuScene.scaleMode = .resizeFill
                    
                    menuScene.level2LastScore = self.coinCounter
                    if level3IsUnlocked == false{
                        level3WasJustUnlocked = true
                    }
                    level3IsUnlocked = true
                    
                    let reveal = SKTransition.crossFade(withDuration: 1)
                    reveal.pausesOutgoingScene = false
                    reveal.pausesIncomingScene = true
                    self.view?.presentScene(menuScene, transition: reveal)
                }
            }
        }
    } //Boat Did Collide With Finish Line
    
}

