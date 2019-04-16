//
//  SeaScene+BoatForces.swift
//  Wind
//
//  Created by Hugo Lispector on 02/03/19.
//  Copyright © 2018 Hugo. All rights reserved.
//

import SpriteKit

public extension SeaScene {
    
    func finalForce() {
        var finalForce = finalPush! + finalLift!

        if (boatIsPushedForward! == false && boatIsMovingForward! == false){ //only case of backward resistance
            boat?.physicsBody?.linearDamping = 1
        }
        else{ //normal free moving
            boat?.physicsBody?.linearDamping = 0.1
        }
        
        if isSailWiggling {
            finalForce = CGVector(dx: 0, dy: 0)
        }
        
        boat?.physicsBody?.applyForce(finalForce)
    } //finalForce
    
    func pushForce() {
        let pushLength = (apparentWind?.length())! * sin(apparentWindAngle! - trueSailAngle!)
        //let pushX = pushLength * -sin(trueSailAngle)
        //let pushY = pushLength * cos(trueSailAngle)
        //let pushForce = CGVector(dx: pushX, dy: pushY)
        
        //alpha is the angle between pushForce and boat direction
        let alpha = (boat?.zRotation)! - trueSailAngle! // - CGFloat.pi/2
        
        let finalPushLength = pushLength * cos(alpha)
        let finalPushX = finalPushLength * -sin((boat?.zRotation)!)
        let finalPushY = finalPushLength * cos((boat?.zRotation)!)
        finalPush = CGVector(dx: finalPushX, dy: finalPushY)
        
        // push multiplier from -1 to 1 sin(apparentWindAngle! - trueSailAngle!))
        
    } //pushForce

    func liftForce() {
        let liftLength = (apparentWind?.length())! * cos(apparentWindAngle! - trueSailAngle!)
        //let liftX = liftLength * -sin(trueSailAngle)
        //let liftY = liftLength * cos(trueSailAngle)
        //let liftForce = CGVector(dx: liftX, dy: liftY)
        
        let finalLiftLength = liftLength * cos(alpha)
        var finalLiftX = finalLiftLength * -sin((boat?.zRotation)!)
        var finalLiftY = finalLiftLength * cos((boat?.zRotation)!)
        
        
        boatAngle = simpleAngleOff(angle: (boat?.zRotation)!)
        
        var simpleApparentWind = simpleAngle(angle: apparentWindAngle!)
        let simpleSailAngle =  simpleAngle(angle: trueSailAngle!)
        
        if simpleApparentWind < simpleSailAngle {
            simpleApparentWind = simpleApparentWind + 2*CGFloat.pi
        }
        
        // if the apparentwind is behind the sail lift is forward, else it's backwards
        
        boatIsPushedForward = true
        //print (apparentWindAngle, simpleSailAngle)
        //print (sail?.zRotation)
        if simpleApparentWind < (simpleSailAngle + CGFloat.pi){
            //boatIsMovingForward = true
            //segue o barco
            if (boatAngle! >= 0 && boatAngle! < CGFloat.pi/2) {
                finalLiftX = abs(finalLiftX)
                finalLiftY = abs(finalLiftY)
            }
            else if (boatAngle! >= CGFloat.pi/2 && boatAngle! < CGFloat.pi){
                finalLiftX = -abs(finalLiftX)
                finalLiftY = abs(finalLiftY)
            }
            else if (boatAngle! >= CGFloat.pi && boatAngle! < 3/2*CGFloat.pi){
                finalLiftX = -abs(finalLiftX)
                finalLiftY = -abs(finalLiftY)
            }
            else if (boatAngle! >= 3/2*CGFloat.pi && boatAngle! < 2*CGFloat.pi){
                finalLiftX = abs(finalLiftX)
                finalLiftY = -abs(finalLiftY)
            }
            if (sail?.zRotation)! < 0 {
                finalLiftX = -finalLiftX
                finalLiftY = -finalLiftY
                boatIsPushedForward = false
            }
        }
        else{
            boatIsPushedForward = false
            if (boatAngle! >= 0 && boatAngle! < CGFloat.pi/2) {
                finalLiftX = -abs(finalLiftX)
                finalLiftY = -abs(finalLiftY)
            }
            else if (boatAngle! >= CGFloat.pi/2 - 0.000001 && boatAngle! < CGFloat.pi){
                finalLiftX = abs(finalLiftX)
                finalLiftY = -abs(finalLiftY)
            }
            else if (boatAngle! >= CGFloat.pi && boatAngle! < 3/2*CGFloat.pi){
                finalLiftX = abs(finalLiftX)
                finalLiftY = abs(finalLiftY)
            }
            else if (boatAngle! >= 3/2*CGFloat.pi && boatAngle! < 2*CGFloat.pi){
                finalLiftX = -abs(finalLiftX)
                finalLiftY = abs(finalLiftY)
            }
            if (sail?.zRotation)! < 0 {
                finalLiftX = -finalLiftX
                finalLiftY = -finalLiftY
                boatIsPushedForward = true
            }
        }
        finalLift = CGVector(dx: finalLiftX, dy: finalLiftY)
    } //liftForce
    
    func keelForce() {
        let velocityAngle = asinToSimpleAngle(vector: (boat?.physicsBody?.velocity)!)
        
        //beta is the angle between velocity and boat
        //beta is either aprox 0 (boat is moving forward) or aprox (pi or -pi) (boat is moving backwards).
        let beta = boatAngle! - velocityAngle
        
        let velocityLength = boat?.physicsBody?.velocity.length()
        //        let parallelVelocityLength = velocityLength! * cos(beta)
        //        let parallelVelocityX = parallelVelocityLength * -sin((boat?.zRotation)!)//
        //        let parallelVelocityY = parallelVelocityLength * cos((boat?.zRotation)!)//
        //        let parallelVelocity = CGVector(dx: parallelVelocityX, dy: parallelVelocityY)
        //boat?.physicsBody?.velocity = finalVelocity//
        
        let perpendicularVelocityLength = velocityLength! * sin(beta)
        //        let perpendicularVelocityX = perpendicularVelocityLength * cos((boat?.zRotation)!)//
        //        let perpendicularVelocityY = perpendicularVelocityLength * sin((boat?.zRotation)!)//
        //        let perpendicularVelocity = CGVector(dx: perpendicularVelocityX, dy: perpendicularVelocityY)
        
//++        let deltaTime = Date().timeIntervalSinceReferenceDate - lastTimeRecord
        let deltaTime: Double = 1/60
        
        let keelForceLength = perpendicularVelocityLength * (boat?.physicsBody?.mass)! / CGFloat(deltaTime) //
        let keelForceX = -keelForceLength * cos((boat?.zRotation)!)
        let keelForceY = -keelForceLength * sin((boat?.zRotation)!)
        let keelForce = CGVector(dx: keelForceX, dy: keelForceY)
        boat?.physicsBody?.applyForce(keelForce/14)
        
        //boat?.physicsBody?.velocity = parallelVelocity + perpendicularVelocity //
        
    } //velocityParallelToBoat
    
}
