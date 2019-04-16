//
//  MenuScene+Coins.swift
//  Wind
//
//  Created by Hugo on 15/03/2019.
//  Copyright © 2018 Hugo. All rights reserved.
//

import SpriteKit

public extension MenuScene{
    
    public func manageCoinsAndLockers() {
        
        //Level Locks
        
        level2Locker = SKSpriteNode(imageNamed: "Menu/levelLocker")
        level2Locker?.position = level2Button.position
        level2Locker?.setScale(buttonScale)
        self.addChild(level2Locker!)
        
        //animation Level 1
        let waitAction = SKAction.wait(forDuration: 0.2)
        let longWait = SKAction.wait(forDuration: 0.5)
        let addCoin1 = SKAction.run {
            self.menuCoinAnimation(coin: self.level1Coins[0]!)
            self.level1Coins[0]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        }
        let addCoin2 = SKAction.run {
            self.menuCoinAnimation(coin: self.level1Coins[1]!)
            self.level1Coins[1]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        }
        let addCoin3 = SKAction.run {
            self.menuCoinAnimation(coin: self.level1Coins[2]!)
            self.level1Coins[2]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        }
        
        //no animation Level1
        let addCoin1NoAnimation = SKAction.run {
            self.level1Coins[0]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        }
        let addCoin2NoAnimation = SKAction.run {
            self.level1Coins[1]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        }
        let addCoin3NoAnimation = SKAction.run {
            self.level1Coins[2]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        }
        let removeLevel2LockNoAnimation = SKAction.run {
            self.level2Locker?.alpha = 0
        }
        
        //Coins Logic
        if level2WasJustUnlocked == false && level2IsUnlocked == false {
            level2Locker?.alpha = 1
            //coins remain the same
        }
        else if level2WasJustUnlocked == true && level2IsUnlocked == true{
            level2WasJustUnlocked = false
            level1BestScore = level1LastScore
            
            SKTexture.preload([SKTexture(imageNamed: "Lakes/lakeIn2"), SKTexture(imageNamed: "Lakes/lakeOut2")], withCompletionHandler: {
                //print("complete")
            } )
            
            let removeLevel2Lock = SKAction.run {
                self.level2Locker?.run(SKAction.fadeOut(withDuration: 0.2))
            }
            switch level1LastScore {
                
            case 1:
                self.run(SKAction.sequence([longWait, addCoin1, waitAction, removeLevel2Lock]))
            case 2:
                self.run(SKAction.sequence([longWait, addCoin1, waitAction, addCoin2, waitAction, removeLevel2Lock]))
            case 3:
                self.run(SKAction.sequence([longWait, addCoin1, waitAction, addCoin2, waitAction, addCoin3, waitAction, removeLevel2Lock]))
            default: //case 0
                self.run(SKAction.sequence([longWait, removeLevel2Lock]))
            }
            
        }
        else if level2WasJustUnlocked == false && level2IsUnlocked == true {
            level2Locker?.alpha = 0
            
            if level1LastScore > level1BestScore { //score changed
                let level1LastBestScore = level1BestScore
                level1BestScore = level1LastScore
                
                //last coins persist
                switch level1LastBestScore {
                    
                case 1:
                    self.run(SKAction.sequence([addCoin1NoAnimation, removeLevel2LockNoAnimation]))
                case 2:
                    self.run(addCoin1NoAnimation)
                    self.run(addCoin2NoAnimation)
                    self.run(removeLevel2LockNoAnimation)
                case 3:
                    self.run(SKAction.sequence([addCoin1NoAnimation, addCoin2NoAnimation, addCoin3NoAnimation, removeLevel2LockNoAnimation]))
                default: //case 0
                    if level1LastBestScore == 0 {}//do nothing
                }
                //new coins appear
                let numberOfNewCoins = level1BestScore - level1LastBestScore
                if numberOfNewCoins == 1 {
                    switch level1BestScore {
                    case 1:
                        self.run(SKAction.sequence([longWait, addCoin1]))
                    case 2:
                        self.run(SKAction.sequence([longWait, addCoin2]))
                    case 3:
                        self.run(SKAction.sequence([longWait, addCoin3]))
                    default:
                        if level1BestScore == 0 {}
                    }
                }
                else if
                    numberOfNewCoins == 2 {
                    switch level1BestScore {
                    case 2:
                        self.run(SKAction.sequence([longWait, addCoin1, waitAction, addCoin2]))
                    case 3:
                        self.run(SKAction.sequence([longWait, addCoin2, waitAction, addCoin3]))
                    default:
                        if level1BestScore == 0 {}
                    }
                }
                else if numberOfNewCoins == 3 {
                    self.run(SKAction.sequence([longWait, addCoin1, waitAction, addCoin2, waitAction, addCoin3]))
                }
                
            }
            else{ //score remains
                
                var coinPersistIndex = 0
                while coinPersistIndex < level1BestScore {
                    self.level1Coins[coinPersistIndex]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
                    coinPersistIndex = coinPersistIndex + 1
                }
            }
            
        }
        
        //*//*//*//
        
        level3Locker = SKSpriteNode(imageNamed: "Menu/levelLocker")
        level3Locker?.position = level3Button.position
        level3Locker?.setScale(buttonScale)
        self.addChild(level3Locker!)
        
        //animation Level 2
        let addLevel2Coin1 = SKAction.run {
            self.menuCoinAnimation(coin: self.level2Coins[0]!)
            self.level2Coins[0]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        }
        let addLevel2Coin2 = SKAction.run {
            self.menuCoinAnimation(coin: self.level2Coins[1]!)
            self.level2Coins[1]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        }
        let addLevel2Coin3 = SKAction.run {
            self.menuCoinAnimation(coin: self.level2Coins[2]!)
            self.level2Coins[2]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        }
        
        //no animation Level2
        let addLevel2Coin1NoAnimation = SKAction.run {
            self.level2Coins[0]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        }
        let addLevel2Coin2NoAnimation = SKAction.run {
            self.level2Coins[1]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        }
        let addLevel2Coin3NoAnimation = SKAction.run {
            self.level2Coins[2]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        }
        let removeLevel3LockNoAnimation = SKAction.run {
            self.level3Locker?.alpha = 0
        }

        //Coins Logic
        if level3WasJustUnlocked == false && level3IsUnlocked == false {
            level3Locker?.alpha = 1
            //coins remain the same
        }
        else if level3WasJustUnlocked == true && level3IsUnlocked == true{
            level3WasJustUnlocked = false
            level2BestScore = level2LastScore
            
            SKTexture.preload([SKTexture(imageNamed: "Lakes/lakeIn3"), SKTexture(imageNamed: "Lakes/lakeOut3")], withCompletionHandler: {
                //print("complete")
            } )

            
            let removeLevel3Lock = SKAction.run {
                self.level3Locker?.run(SKAction.fadeOut(withDuration: 0.2))
            }
            switch level2LastScore {
                
            case 1:
                self.run(SKAction.sequence([longWait, addLevel2Coin1, waitAction, removeLevel3Lock]))
            case 2:
                self.run(SKAction.sequence([longWait, addLevel2Coin1, waitAction, addLevel2Coin2, waitAction, removeLevel3Lock]))
            case 3:
                self.run(SKAction.sequence([longWait, addLevel2Coin1, waitAction, addLevel2Coin2, waitAction, addLevel2Coin3, waitAction, removeLevel3Lock]))
            default: //case 0
                self.run(SKAction.sequence([longWait, removeLevel3Lock]))
            }
        }
        else if level3WasJustUnlocked == false && level3IsUnlocked == true {
            level3Locker?.alpha = 0
                
            if level2LastScore > level2BestScore { //score changed
                let level2LastBestScore = level2BestScore
                level2BestScore = level2LastScore
                
                //last coins persist
                switch level2LastBestScore {

                case 1:
                    self.run(SKAction.sequence([addLevel2Coin1NoAnimation, removeLevel3LockNoAnimation]))
                case 2:
                    self.run(addLevel2Coin1NoAnimation)
                    self.run(addLevel2Coin2NoAnimation)
                    self.run(removeLevel3LockNoAnimation)
                case 3:
                    self.run(SKAction.sequence([addLevel2Coin1NoAnimation, addLevel2Coin2NoAnimation, addLevel2Coin3NoAnimation, removeLevel3LockNoAnimation]))
                default: //case 0
                    if level2LastBestScore == 0 {}//do nothing
                }
                //new coins appear
                let numberOfNewCoins = level2BestScore - level2LastBestScore
                if numberOfNewCoins == 1 {
                    switch level2BestScore {
                    case 1:
                        self.run(SKAction.sequence([longWait, addLevel2Coin1]))
                    case 2:
                        self.run(SKAction.sequence([longWait, addLevel2Coin2]))
                    case 3:
                        self.run(SKAction.sequence([longWait, addLevel2Coin3]))
                    default:
                        if level2BestScore == 0 {}
                    }
                }
                else if
                    numberOfNewCoins == 2 {
                    switch level2BestScore {
                    case 2:
                        self.run(SKAction.sequence([longWait, addLevel2Coin1, waitAction, addLevel2Coin2]))
                    case 3:
                        self.run(SKAction.sequence([longWait, addLevel2Coin2, waitAction, addLevel2Coin3]))
                    default:
                        if level2BestScore == 0 {}
                    }
                }
                else if numberOfNewCoins == 3 {
                    self.run(SKAction.sequence([longWait, addLevel2Coin1, waitAction, addLevel2Coin2, waitAction, addLevel2Coin3]))
                }
            }
            else{ //score remains
                
                var coinPersistIndex = 0
                while coinPersistIndex < level2BestScore {
                    self.level2Coins[coinPersistIndex]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
                    coinPersistIndex = coinPersistIndex + 1
                }
            }
        }
        
        //**//**//**//
        
        //animation Level 3
        let addLevel3Coin1 = SKAction.run {
            self.menuCoinAnimation(coin: self.level3Coins[0]!)
            self.level3Coins[0]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        }
        let addLevel3Coin2 = SKAction.run {
            self.menuCoinAnimation(coin: self.level3Coins[1]!)
            self.level3Coins[1]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        }
        let addLevel3Coin3 = SKAction.run {
            self.menuCoinAnimation(coin: self.level3Coins[2]!)
            self.level3Coins[2]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        }
        
        //no animation Level3
        let addLevel3Coin1NoAnimation = SKAction.run {
            self.level3Coins[0]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        }
        let addLevel3Coin2NoAnimation = SKAction.run {
            self.level3Coins[1]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        }
        let addLevel3Coin3NoAnimation = SKAction.run {
            self.level3Coins[2]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
        }
        
        if level4WasJustUnlocked == false && level4IsUnlocked == false {
        //nothing
        }
        else if level4WasJustUnlocked == true && level4IsUnlocked == true{
            level4WasJustUnlocked = false
            level3BestScore = level3LastScore
        
            switch level3LastScore {
                
            case 1:
                self.run(SKAction.sequence([longWait, addLevel3Coin1]))
            case 2:
                self.run(SKAction.sequence([longWait, addLevel3Coin1, waitAction, addLevel3Coin2]))
            case 3:
                self.run(SKAction.sequence([longWait, addLevel3Coin1, waitAction, addLevel3Coin2, waitAction, addLevel3Coin3]))
            default: //case 0
                if level3LastScore == 0 {}
            }
        }
        else if level4WasJustUnlocked == false && level4IsUnlocked == true {
            if level3LastScore > level3BestScore { //score changed
                let level3LastBestScore = level3BestScore
                level3BestScore = level3LastScore

                //last coins persist
                switch level3LastBestScore {
                    
                case 1:
                    self.run(addLevel3Coin1NoAnimation)
                case 2:
                    self.run(addLevel3Coin1NoAnimation)
                    self.run(addLevel3Coin2NoAnimation)
                case 3:
                    self.run(SKAction.sequence([addLevel3Coin1NoAnimation, addLevel3Coin2NoAnimation, addLevel3Coin3NoAnimation]))
                default: //case 0
                    if level3LastBestScore == 0 {}//do nothing
                }
                //new coins appear
                let numberOfNewCoins = level3BestScore - level3LastBestScore
                if numberOfNewCoins == 1 {
                    switch level3BestScore {
                    case 1:
                        self.run(SKAction.sequence([longWait, addLevel3Coin1]))
                    case 2:
                        self.run(SKAction.sequence([longWait, addLevel3Coin2]))
                    case 3:
                        self.run(SKAction.sequence([longWait, addLevel3Coin3]))
                    default:
                        if level3BestScore == 0 {}
                    }
                }
                else if
                    numberOfNewCoins == 2 {
                    switch level3BestScore {
                    case 2:
                        self.run(SKAction.sequence([longWait, addLevel3Coin1, waitAction, addLevel3Coin2]))
                    case 3:
                        self.run(SKAction.sequence([longWait, addLevel3Coin2, waitAction, addLevel3Coin3]))
                    default:
                        if level3BestScore == 0 {}
                    }
                }
                else if numberOfNewCoins == 3 {
                    self.run(SKAction.sequence([longWait, addLevel3Coin1, waitAction, addLevel3Coin2, waitAction, addLevel3Coin3]))
                }
            }
            else{ //score remains
                
                var coinPersistIndex = 0
                while coinPersistIndex < level3BestScore {
                    self.level3Coins[coinPersistIndex]?.texture = SKTexture(imageNamed: "Coins/fishCoin")
                    coinPersistIndex = coinPersistIndex + 1
                }
            }
        }
    }//manageCoinsAndLockers
    
    
    
}

