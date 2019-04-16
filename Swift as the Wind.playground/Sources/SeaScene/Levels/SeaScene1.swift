//
//  SeaScene1.swift
//  Wind
//
//  Created by Hugo on 16/03/2019.
//  Copyright © 2018 Hugo. All rights reserved.
//

import SpriteKit
import AVFoundation

public class SeaScene1: SeaScene {
    
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
        
        apparentWind = wind
        
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
        
        //boat start rotation in rad
        boat?.zRotation = -CGFloat.pi/4
        sail?.zRotation = CGFloat.pi/4
        
        //boat physics texture
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
        shipWheel?.physicsBody?.angularDamping = 12 //20
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
        lakeIn?.texture = SKTexture(imageNamed: "Lakes/lakeIn1")
        lakeIn?.setScale(2/3)
        lakeIn?.position = CGPoint(x: -33.988/1.5, y: 18.39/1.5)
        lakeOut = self.childNode(withName: "lakeOut") as? SKSpriteNode
        lakeOut?.texture = SKTexture(imageNamed: "Lakes/lakeOut1")
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
        
        let lake1 = Paths(lakeNumber: 1)
        lakeIn?.physicsBody = SKPhysicsBody(edgeLoopFrom: lake1.shape.cgPath)
        lakeIn?.physicsBody?.categoryBitMask = PhysicsCategory.edge
        lakeIn?.physicsBody?.collisionBitMask = PhysicsCategory.boat
        lakeIn?.physicsBody?.contactTestBitMask = PhysicsCategory.boat
        lakeIn?.physicsBody?.restitution = 1
        
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
        restartButton.level = 1
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
        
    }
    
    override public func update(_ currentTime: TimeInterval) {
        
        //positions update to enable auto layout
        width = self.view?.window?.frame.size.width
        height = self.view?.window?.frame.size.height
        
        if 3.5 * (shipWheel?.size.width)! > width! {
            wheelsXOffset = 110
        }
        else {
            wheelsXOffset = 150
        }

        shipWheel?.position = CGPoint(x: -(width!/2) + wheelsXOffset , y: -(height!/4))
        sailWheel?.position = CGPoint(x: (width!/2) - wheelsXOffset , y: -(height!/4))
    
        coinHolder1!.position = CGPoint(x: (shipWheel?.position.x)! - 1.25 * coinHolder1!.size.width , y: height!/2 - topItemsYOffset * pauseButtonScale * coinHolder1!.size.height)
        coinHolder2!.position = CGPoint(x: (shipWheel?.position.x)!, y: height!/2 - topItemsYOffset * pauseButtonScale * coinHolder2!.size.height)
        coinHolder3!.position = CGPoint(x: (shipWheel?.position.x)! + 1.25 * coinHolder3!.size.width , y: height!/2 - topItemsYOffset * pauseButtonScale * coinHolder3!.size.height)
        
        pauseButton.position = CGPoint(x: (sailWheel?.position.x)!, y: height!/2 - topItemsYOffset * pauseButtonScale * (coinHolder1?.size.height)!)
        playAfterPauseButton.position =  pauseButton.position
        
        if isGamePaused == true {
            self.run(SKAction.wait(forDuration: 0.2)){
                if self.isGamePaused == true {
                    self.restartButton.position = CGPoint(x: (self.sailWheel?.position.x)! - 1.35 * self.restartButton.size.width, y: self.height!/2 - self.topItemsYOffset * self.pauseButtonScale * (self.coinHolder1?.size.height)!)
                    
                    self.soundOnButton.position = CGPoint(x: (self.sailWheel?.position.x)! - 2 * 1.35 * self.restartButton.size.width, y: self.height!/2 - self.topItemsYOffset * self.pauseButtonScale * (self.coinHolder1?.size.height)!)
                    
                    self.soundOffButton.position = CGPoint(x: (self.sailWheel?.position.x)! - 2 * 1.35 * self.restartButton.size.width, y: self.height!/2 - self.topItemsYOffset * self.pauseButtonScale * (self.coinHolder1?.size.height)!)
                    
                    self.homeButton.position = CGPoint(x: (self.sailWheel?.position.x)! - 3 * 1.35 * self.restartButton.size.width, y: self.height!/2 - self.topItemsYOffset * self.pauseButtonScale * (self.coinHolder1?.size.height)!)
                    
                }
            }
        }
        else{
            self.run(SKAction.wait(forDuration: 0.2)){
                if self.isGamePaused == false {
                    
                    self.restartButton.position = self.pauseButton.position
                    self.restartButton.position =  self.pauseButton.position
                    self.soundOnButton.position =  self.pauseButton.position
                    self.soundOffButton.position =  self.pauseButton.position
                    self.homeButton.position =  self.pauseButton.position
                }
            }
        }
        
        if isPreStart == false && isGamePaused == false {
            
            let boatNoseCenter = CGPoint(x:(boat?.position.x)! - (boat?.size.height)! * sin((boat?.zRotation)!), y:(boat?.position.y)! + (boat?.size.height)! * cos((boat?.zRotation)!))
            
            let boatNoseCenterPlusVelocity = CGPoint(x: boatNoseCenter.x + (boat?.physicsBody?.velocity.dx)!/1.25, y: boatNoseCenter.y + (boat?.physicsBody?.velocity.dy)!/1.25 )
            if boatNoseCenterPlusVelocity.x - (self.camera?.position.x)! > cameraBoundBoxSize {
                self.camera?.position.x = boatNoseCenterPlusVelocity.x - cameraBoundBoxSize
            }
            if boatNoseCenterPlusVelocity.x - (self.camera?.position.x)! < -cameraBoundBoxSize {
                self.camera?.position.x = boatNoseCenterPlusVelocity.x + cameraBoundBoxSize
            }
            if boatNoseCenterPlusVelocity.y - (self.camera?.position.y)! > cameraBoundBoxSize {
                self.camera?.position.y = boatNoseCenterPlusVelocity.y - cameraBoundBoxSize
            }
            if boatNoseCenterPlusVelocity.y - (self.camera?.position.y)! < -cameraBoundBoxSize {
                self.camera?.position.y = boatNoseCenterPlusVelocity.y + cameraBoundBoxSize
            }
            
            let moveCamera = SKAction.move(to: boatNoseCenterPlusVelocity, duration: 0.5)
            camera?.run(moveCamera)
            
            dThetaShipWheel()
            dThetaSailWheel()
            
            //Rotate boat based on shipWheel and boat's speed
            boat?.zRotation = (boat?.zRotation)! + (shipWheel?.physicsBody?.angularVelocity)! * (boat?.physicsBody?.velocity)!.length() / 24000
            boat?.zRotation = (boat?.zRotation)! + (shipWheel?.physicsBody?.angularVelocity)!/300
            
            //Rotate sail based on sailWheel
            let newSailRotation = (sail?.zRotation)! + (sailWheel?.physicsBody?.angularVelocity)!/100
            
            lastSailReachedLimit = sailReachedLimit
            sailWheelVelocity = 72 //92
            sailReachedLimit = false
            
            //Limiting sail rotation
            if newSailRotation > CGFloat.pi/2 - 0.000001 || newSailRotation < -CGFloat.pi/2 + 0.000001 {
                //in limit
                if newSailRotation > CGFloat.pi/2 - 0.000001 {
                    sail?.zRotation = CGFloat.pi/2
                }
                else if newSailRotation < -CGFloat.pi/2 + 0.000001{
                    sail?.zRotation = -CGFloat.pi/2
                }
                
                sailWheelVelocity = 30
                sailReachedLimit = true
                //new before
                if lastSailReachedLimit == false{ //just reached limit
                    
                    self.sailWheelAngleBeforeLimit = (self.sailWheel?.zRotation)! //setting angleBeforeLimit
                    
                    if fingerOnSailWheel == false{ //if finger is OFF
                        //bounceback no finger
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) { // delay to let sailwheel travel a bit before bounceback
                            if (self.fingerOnSailWheel == false){
                                //wait a moment here
                                let rotateBackAction = SKAction.rotate(toAngle: self.sailWheelAngleBeforeLimit, duration: 0.2, shortestUnitArc: true)
                                self.sailWheel?.run(rotateBackAction, completion: {
                                    return
                                } )
                            }
                        }
                    }
                }
            }
            else {
                //not in limit
                sail?.zRotation = newSailRotation
                sailWheelVelocity = 72
                sailReachedLimit = false
            }
            ///
            
            //Determining if boat is moving forward by checking if boat's angle matches boat's velocity angle (considering offsets)
            if abs( asinToSimpleAngle(vector: (boat?.physicsBody?.velocity)!) - simpleAngleOff(angle: (boat?.zRotation)!) ) < 2 ||
                abs( asinToSimpleAngle(vector: (boat?.physicsBody?.velocity)!) - simpleAngleOff(angle: (boat?.zRotation)!) ) > 4  {
                boatIsMovingForward = true
            }
            else {
                boatIsMovingForward = false
            }
            
            if ((boat?.physicsBody?.velocity)?.length())! < CGFloat(0.1) {
                boatTrail?.particleBirthRate = 0
                boatTrail?.particleLifetime = 0
                boatTrail?.particleScaleSpeed = 0
                boatTrail?.particleScaleRange = 0
            }
            else {
                boatTrail?.particleBirthRate = (boat?.physicsBody?.velocity)!.length()/2
                if (boatTrail?.particleBirthRate)! > 45 {boatTrail?.particleBirthRate = 45}
                
                boatTrail?.particleLifetime = (boat?.physicsBody?.velocity)!.length()/10
                if (boatTrail?.particleLifetime)! > 5 {boatTrail?.particleLifetime = 5}
                boatTrail?.particleLifetimeRange = (boatTrail?.particleLifetime)!/2
                
                boatTrail?.particleScaleSpeed = (boat?.physicsBody?.velocity)!.length()/150
                if (boatTrail?.particleScaleSpeed)! > 0.5 {boatTrail?.particleScaleSpeed = 0.5}
                boatTrail?.particleScaleRange = (boatTrail?.particleScaleSpeed)!/5
            }
            
            boatWind = (boat?.physicsBody?.velocity)! * CGFloat(-1)
            apparentWind = boatWind! + wind
            
            apparentWindAngle = asinToSimpleAngle(vector: apparentWind!)
            trueSailAngle = (sail?.zRotation)! + (boat?.zRotation)! - CGFloat.pi/2
            
            //Boat forces: calculates push and lift
            pushForce()
            liftForce()
            
            //sailWarping
            sailWarping()
            
            //finalForce: uses the push and lift forces to generate a final force to be applied on the boat
            finalForce()
            
            //Velocity Parallel to Boat. Boat only moves forwards or backwards. Never sideways.
            if driftIsEnabled == false {
                keelForce()
                self.boat?.physicsBody?.angularDamping = 20
            }
            else{
                self.boat?.physicsBody?.applyTorque(swirlTorque * swirlDirection)
                self.boat?.physicsBody?.linearDamping = 1.5
                self.boat?.physicsBody?.angularDamping = 10
            }
            
            lastTimeRecord = Date().timeIntervalSinceReferenceDate
            
        }
        
    }
    
}

