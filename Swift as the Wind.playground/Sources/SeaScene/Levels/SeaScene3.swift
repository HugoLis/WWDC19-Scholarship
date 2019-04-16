//
//  SeaScene.swift
//  Wind
//
//  Created by Hugo on 16/03/2019.
//  Copyright © 2018 Hugo. All rights reserved.
//

import SpriteKit

var isFirstEnd = true

public class SeaScene3: SeaScene {
    
    override public func boatDidCollideWithFinishLine(boat: SKSpriteNode, finishLineSon: SKSpriteNode) {
        
        if (finishLineSon.parent != nil) {
            
            finishLineSon.removeFromParent()
            
            if soundIsOn == true {
                fireworksSound.autoplayLooped = false
                self.addChild(fireworksSound)
                fireworksSound.run(SKAction.play())
                if isFirstEnd == false {
                    self.run(SKAction.wait(forDuration: 2)){
                        self.fireworksSound.run(SKAction.changeVolume(to: 0, duration: 1))
                    }
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
            
            //final congratulations

            congratsRectangle = SKShapeNode(rect: CGRect(x:-512/2, y: -300/2, width: 512, height: 300), cornerRadius: CGFloat(55))
            congratsRectangle?.position = CGPoint(x: 0, y: height!/10)
            congratsRectangle?.fillColor = #colorLiteral(red: 1, green: 0.9607843137, blue: 0.9019607843, alpha: 1)
            congratsRectangle?.alpha = 0
            congratsRectangle?.zPosition = 300
            
            if wheelsXOffset < 120 { //narrow vs wide mode
                congratsRectangle?.setScale(0.75)
            }
            else {
                congratsRectangle?.setScale(1)
            }
            
            let cfURL = Bundle.main.url(forResource: "Fonts/BalooChettan-Regular", withExtension: "ttf")! as CFURL
            CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
            
            let cfURL2 = Bundle.main.url(forResource: "Fonts/VarelaRound-Regular", withExtension: "ttf")! as CFURL
            CTFontManagerRegisterFontsForURL(cfURL2, CTFontManagerScope.process, nil)
            
            congratsLabel = SKLabelNode(text: "Congratulations!")
            congratsLabel?.fontName = "BalooChettan-Regular"
            congratsLabel?.fontColor = #colorLiteral(red: 0.5411764706, green: 0.3294117647, blue: 0.1490196078, alpha: 1)
            congratsLabel?.fontSize = 40
            congratsLabel?.alpha = 0
            congratsLabel?.zPosition = 301
            
            playAgainLabel1 = SKLabelNode(text: "You've collected all the coins!")
            playAgainLabel1?.fontName = "VarelaRound-Regular"
            playAgainLabel1?.fontColor = #colorLiteral(red: 0.5411764706, green: 0.3294117647, blue: 0.1490196078, alpha: 1)
            playAgainLabel1?.fontSize = 30
            playAgainLabel1?.alpha = 0
            playAgainLabel1?.zPosition = 301
            
            playAgainLabel2 = SKLabelNode(text: "Feel free to play again")
            playAgainLabel2?.fontName = "VarelaRound-Regular"
            playAgainLabel2?.fontColor = #colorLiteral(red: 0.5411764706, green: 0.3294117647, blue: 0.1490196078, alpha: 1)
            playAgainLabel2?.fontSize = 30
            playAgainLabel2?.alpha = 0
            playAgainLabel2?.zPosition = 301
            
            let localLevel3BestScore = coinCounter > level3BestScore ? coinCounter : level3BestScore
            let totalCoins = level1BestScore + level2BestScore + localLevel3BestScore
            
            print (totalCoins)
            if totalCoins < 9 {
                playAgainLabel1?.text = "Let's play again and try"
                playAgainLabel2?.text = "to collect all coins!"
            }
            
            congratsLabel?.position = CGPoint(x: 0, y: height!/10 + (congratsRectangle?.frame.size.height)!/4.5)
            playAgainLabel1?.position = CGPoint(x: 0, y: height!/10 + (congratsRectangle?.frame.size.height)!/20)
            playAgainLabel2?.position = CGPoint(x: 0, y: height!/10 - (congratsRectangle?.frame.size.height)!/15)
            finalHomeButton.position = CGPoint(x: 0, y: height!/10 - (congratsRectangle?.frame.size.height)!/3.5)
            
            
            finalHomeButton = FinalHomeButton(normalTexture: SKTexture(imageNamed: "Buttons/homeButton"), selectedTexture: SKTexture(imageNamed: "Buttons/pressedHomeButton"), disabledTexture: SKTexture(imageNamed: "Buttons/pressedHomeButton"))
            finalHomeButton.position = CGPoint(x: 0, y: -0.2 * width!)
            finalHomeButton.alpha = 0
            finalHomeButton.setScale(pauseButtonScale * coinScale)
            finalHomeButton.zPosition = 302
            
            camera?.addChild(congratsRectangle!)
            camera?.addChild(congratsLabel!)
            camera?.addChild(playAgainLabel1!)
            camera?.addChild(playAgainLabel2!)
            camera?.addChild(finalHomeButton)
            shouldCalculateCongratsScreen = true
            
            if self.pauseCurtain?.parent == nil {
                self.camera?.addChild(pauseCurtain!)
            }
            
            if isFirstEnd == true {
                isFirstEnd = false
                self.run(SKAction.wait(forDuration: 2)){
                    self.congratsRectangle?.run(SKAction.fadeIn(withDuration: 0.2))
                    self.congratsLabel?.run(SKAction.fadeIn(withDuration: 0.2))
                    self.playAgainLabel1?.run(SKAction.fadeIn(withDuration: 0.2))
                    self.playAgainLabel2?.run(SKAction.fadeIn(withDuration: 0.2))
                    self.finalHomeButton.run(SKAction.fadeIn(withDuration: 0.2))
                    self.pauseCurtain?.run(SKAction.fadeIn(withDuration: 0.2))
                }
            }            /// ends congratulations
            else {
                self.run(SKAction.wait(forDuration: 2)){
                    //Back To Menu
                    if let menuScene = MenuScene(fileNamed: "menuScene"){
                        menuScene.scaleMode = .resizeFill

                        menuScene.level3LastScore = self.coinCounter
                        if level4IsUnlocked == false {
                            level4WasJustUnlocked = true
                        }
                        level4IsUnlocked = true

                        let reveal = SKTransition.crossFade(withDuration: 1)
                        reveal.pausesOutgoingScene = false
                        reveal.pausesIncomingScene = true
                        self.view?.presentScene(menuScene, transition: reveal)
                    }

                }
            }
            
            
            
        }
    }
    
}

