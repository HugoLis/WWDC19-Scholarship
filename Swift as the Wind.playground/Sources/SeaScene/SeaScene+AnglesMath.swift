//
//  SeaScene+AnglesMath.swift
//  Wind
//
//  Created by Hugo Lispector on 02/03/19.
//  Copyright © 2018 Hugo. All rights reserved.
//

import SpriteKit

public extension SeaScene {
    
    public func velocityParallelToBoat() {
        let velocityAngle = asinToSimpleAngle(vector: (boat?.physicsBody?.velocity)!)
        
        //beta is the angle between velocity and boat
        //beta is either aprox 0 (boat is moving forward) or aprox (pi or -pi) (boat is moving backwards).
        let beta = boatAngle! - velocityAngle
        
        let velocityLength = boat?.physicsBody?.velocity.length()
        let finalVelocityLength = velocityLength! * cos(beta)
        let finalVelocityX = finalVelocityLength * -sin((boat?.zRotation)!)//
        let finalVelocityY = finalVelocityLength * cos((boat?.zRotation)!)//
        let finalVelocity = CGVector(dx: finalVelocityX, dy: finalVelocityY)
        boat?.physicsBody?.velocity = finalVelocity//
        boat?.physicsBody?.angularVelocity = 0
    } //velocityParallelToBoat
    
    //rad angle mod 2*pi
    public func simpleAngle(angle: CGFloat) -> CGFloat {
        var newAngle = angle.truncatingRemainder(dividingBy: 2*CGFloat.pi)
        if newAngle < 0 {
            newAngle = newAngle + 2*CGFloat.pi
        }
        return newAngle
    }
    
    //rad angle with pi/2 offset mod 2*pi
    public func simpleAngleOff(angle: CGFloat) -> CGFloat {
        var newAngle = (angle + CGFloat.pi/2).truncatingRemainder(dividingBy: 2*CGFloat.pi)
        if newAngle < 0 {
            newAngle = newAngle + 2*CGFloat.pi
        }
        return newAngle
    }
    
    public func asinToSimpleAngle(vector: CGVector) -> CGFloat {
        
        var angle = asin((vector.dy)/vector.length())
        
        if angle >= 0 { //&& velAngle < pi/2
            //if boat?.physicsBody?.velocity.dx > 0 { do nothing }
            if vector.dx < 0 {
                angle = CGFloat.pi - angle
            }
        }
        else {
            if angle < 0 {
                if vector.dx < 0 {
                    angle = abs(angle) + CGFloat.pi
                }
                else {
                    if vector.dx > 0 {
                        angle = 2*CGFloat.pi + angle
                    }
                }
            }
        }
        return angle
    }
    
    public func angleBetween(origin: CGPoint, pointB: CGPoint) -> CGFloat {
        
        let slope = (pointB.y - origin.y)/(pointB.x - origin.x)
        var theta = atan(slope)
        if theta < 0 {
            theta = CGFloat.pi + theta
        }
        
        if pointB.y < origin.y {
            theta = theta + CGFloat.pi
        }
        
        return theta
    }
    
}
