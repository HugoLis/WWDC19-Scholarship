//
//  SeaScene+Collisions.swift
//  Wind
//
//  Created by Hugo Lispector on 02/03/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import SpriteKit

public extension SeaScene {
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask == PhysicsCategory.boat && secondBody.categoryBitMask == PhysicsCategory.coin {
            print ("boat x coin")
            if let boat = firstBody.node as? SKSpriteNode, let
                coin = secondBody.node as? SKSpriteNode {
                
                boatDidCollideWithCoin(boat: boat, coin: coin)
            }
        }
        
        if firstBody.categoryBitMask == PhysicsCategory.boat && secondBody.categoryBitMask == PhysicsCategory.boost {
            print ("boat x boost")
            if let boat = firstBody.node as? SKSpriteNode, let
                boost = secondBody.node as? SKSpriteNode {

                boatDidCollideWithBoost(boat: boat, boost: boost)
            }
        }
        
        if firstBody.categoryBitMask == PhysicsCategory.boat && secondBody.categoryBitMask == PhysicsCategory.swirl {
            print ("boat x swirl")
            if let boat = firstBody.node as? SKSpriteNode, let swirl = secondBody.node as? SKEmitterNode {
                
                boatDidCollideWithSwirl(boat: boat, swirl: swirl)
            }
        }
        
        if firstBody.categoryBitMask == PhysicsCategory.boat && secondBody.categoryBitMask == PhysicsCategory.finishLine {
            print ("boat x finishLine")
            if let boat = firstBody.node as? SKSpriteNode, let
                finishLineSon = secondBody.node as? SKSpriteNode {
                
                boatDidCollideWithFinishLine(boat: boat, finishLineSon: finishLineSon)
            }
        }

        if firstBody.categoryBitMask == PhysicsCategory.boat && secondBody.categoryBitMask == PhysicsCategory.edge {
            print ("boat x edge")
    
        }
        
        
    } //didBegin contact
    
    public func didEnd(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask == PhysicsCategory.boat && secondBody.categoryBitMask == PhysicsCategory.swirl {
            print ("boat x swirl")
            if let boat = firstBody.node as? SKSpriteNode, let swirl = secondBody.node as? SKEmitterNode {
                
                boatEndedCollisionWithSwirl(boat: boat, swirl: swirl)
            }
        }

        if firstBody.categoryBitMask == PhysicsCategory.boat && secondBody.categoryBitMask == PhysicsCategory.edge {
            print ("boat x edge")
            
        }

    } //didEnd contact
    
    public func boatDidCollideWithCoin(boat: SKSpriteNode, coin: SKSpriteNode) {
        
        let coinAction = SKAction.run {

            if (coin.childNode(withName: "coinSon") != nil) {
                coin.removeAllChildren()
                
                if soundIsOn == true {
                    self.run(SKAction.playSoundFileNamed("Sounds/coinSound.wav", waitForCompletion: false))
                }
                
                self.coinCounter = self.coinCounter + 1

                let coinHolderToFade = SKSpriteNode(imageNamed: "Coins/emptyCoin")
                coinHolderToFade.setScale(self.coinScale)
                coinHolderToFade.zPosition = 201

                coin.run(SKAction.scale(to: (self.camera?.xScale)! * (self.coinHolder1?.xScale)!, duration: 0.1))
                coin.move(toParent: (self.camera)!)

                switch self.coinCounter {
                case 1:
                    coinHolderToFade.position = (self.coinHolder1?.position)!
                    self.camera!.addChild(coinHolderToFade)
                    let moveToCoinHolder = SKAction.move(to: (self.coinHolder1?.position)! , duration: 0.5)
                    moveToCoinHolder.timingMode = .easeInEaseOut

                    self.run(SKAction.wait(forDuration: 0.1)){
                        coin.run(moveToCoinHolder)
                    }

                    self.coinHolder1?.texture = SKTexture(imageNamed: "Coins/fishCoin")
                case 2:
                    coinHolderToFade.position = (self.coinHolder2?.position)!
                    self.camera!.addChild(coinHolderToFade)
                    let moveToCoinHolder = SKAction.move(to: (self.coinHolder2?.position)! , duration: 0.5)
                    moveToCoinHolder.timingMode = .easeInEaseOut

                    self.run(SKAction.wait(forDuration: 0.1)){
                        coin.run(moveToCoinHolder)
                    }

                    self.coinHolder2?.texture = SKTexture(imageNamed: "Coins/fishCoin")
                default: //case 3
                    coinHolderToFade.position = (self.coinHolder3?.position)!
                    self.camera!.addChild(coinHolderToFade)
                    let moveToCoinHolder = SKAction.move(to: (self.coinHolder3?.position)! , duration: 0.5)
                    moveToCoinHolder.timingMode = .easeInEaseOut

                    self.run(SKAction.wait(forDuration: 0.1)){
                        coin.run(moveToCoinHolder)
                    }

                    self.coinHolder3?.texture = SKTexture(imageNamed: "Coins/fishCoin")
                }

                self.run(SKAction.wait(forDuration: 0.5)){
                    coin.run(SKAction.scale(to: self.coinScale * 1.1, duration: 0.1))
                    coin.zPosition = (self.coinHolder1?.zPosition)! + 1
                    coinHolderToFade.run(SKAction.scale(to: self.coinScale * 1.1, duration: 0.1))
                }

                self.run(SKAction.wait(forDuration: 0.6)){
                    coin.run(SKAction.scale(to: self.coinScale / 1.1, duration: 0.1))
                    coinHolderToFade.run(SKAction.scale(to: self.coinScale / 1.1, duration: 0.1))
                    coinHolderToFade.run(SKAction.fadeOut(withDuration: 0.2))
                    coin.run(SKAction.fadeOut(withDuration: 0.2))
                }
                self.run(SKAction.wait(forDuration: 0.8)){
                    coinHolderToFade.removeFromParent()
                    coin.removeFromParent()
                }

                print(self.coinCounter)

                self.run(SKAction.wait(forDuration: 4)) {

                }
            }
        }
        self.run(coinAction)
    }
    
    public func boatDidCollideWithBoost(boat: SKSpriteNode, boost: SKSpriteNode) {
        let boostAction = SKAction.run {
            if (boost.childNode(withName: "boostSon") != nil) {
                boost.removeAllChildren()
                
                if soundIsOn == true {
                    self.run(SKAction.playSoundFileNamed("Sounds/boostSound.mp3", waitForCompletion: false))
                }
                boost.move(toParent: (self.camera)!)

                self.run(SKAction.wait(forDuration: 0.1)){
                    boost.run(SKAction.fadeOut(withDuration: 0.1))
                }

                self.boostTrailActive = true

                self.run(SKAction.wait(forDuration: 0.2)) {
                    boost.removeFromParent()
                }

                self.run(SKAction.wait(forDuration: 4)) {
                    self.boostTrailActive = false
                }

                //actual boost
                let boatsDirection = self.boat?.physicsBody?.velocity.normalized()
                let boatsAngle = self.asinToSimpleAngle(vector: boatsDirection!)
                let boostImpulse = CGVector(dx: cos(boatsAngle) * 2500, dy: sin(boatsAngle) * 2500)
                self.boat?.physicsBody?.applyImpulse(boostImpulse)

            }
        }
        self.run(boostAction)
    }
    
    public func boatDidCollideWithSwirl(boat: SKSpriteNode, swirl: SKEmitterNode) {
        self.driftIsEnabled = true
        print("drift enabled")
        self.swirlTorque = CGFloat.random(in: 8...13)
        self.swirlDirection = Bool.random() == true ? 1 : -1
        print(swirlDirection)
        swirl.run(SKAction.wait(forDuration: 2)){
            if self.driftIsEnabled == true {
                self.swirlGravityBoatField.strength = -0.4 * self.swirlBoatGravity
            }
        }
        
    }
    
    public func boatEndedCollisionWithSwirl(boat: SKSpriteNode, swirl: SKEmitterNode) {
        self.driftIsEnabled = false
        print("drift disabled")

        self.swirlGravityBoatField.strength = self.swirlBoatGravity
    }
    
    public func boatDidCollideWithEdge(boat: SKSpriteNode){

    }
    public func boatEndedCollisionWithEdge(boat: SKSpriteNode){

    }

    
}


