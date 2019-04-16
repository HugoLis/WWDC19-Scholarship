//
//  SeaScene+Touches.swift
//  Wind
//
//  Created by Hugo Lispector on 14/03/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import SpriteKit

extension SeaScene {
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        for touch in touches{
            
            for (index,finger)  in fingers.enumerated() {
                if finger == nil {
                    fingers[index] = String(format: "%p", touch)
                    // top 100p of screen is 0 for buttons
                    if touch.location(in: self.camera!).y > 0 { // 0 is the center
                        touchBeganPosition[index] = 0
                    }
                    else {
                        
                        if touch.location(in: self.camera!).x < 0 {
                            touchBeganPosition[index] = 1
                        }
                        else {
                            touchBeganPosition[index] = 2
                            fingerOnSailWheel = true
                        }
                    }
                    break
                }
            }
        }
    } //touchesBegan
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesMoved(touches, with: event)
        
        for touch in touches {
            for (index,finger) in fingers.enumerated() {
                if let finger = finger, finger == String(format: "%p", touch) {
                    if touchBeganPosition[index] == 1 {
                       self.shipWheelTouchLocation = touch.location(in: self.camera!)
                    }
                    else {
                        if touchBeganPosition[index] == 2 {
                           self.sailWheelTouchLocation = touch.location(in: self.camera!)
                        }
                        
                    }
                    
                    break
                }
            }
        }
    } //touchesMoved
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            for (index,finger) in fingers.enumerated() {
                if let finger = finger, finger == String(format: "%p", touch) {
                    
                    if touchBeganPosition[index] == 1 {
                        shipWheelTouchLocation = nil
                        previousShipWheelTouchLocation = nil
                    }
                    
                    if  touchBeganPosition[index] == 2 {
                        sailWheelTouchLocation = nil
                        previousSailWheelTouchLocation = nil
                        
                        if sailReachedLimit == true{
                            let rotateBackAction = SKAction.rotate(toAngle: sailWheelAngleBeforeLimit, duration: 0.2, shortestUnitArc: true)
                            sailWheel?.run(rotateBackAction, completion: {
                                self.sailReachedLimit = false
                                return
                            } )
                        }
                        
                        fingerOnSailWheel = false
                    }
                    
                    fingers[index] = nil
                    touchBeganPosition[index] = 0
                    break
                }
            }
        }
    } //touchesEnded
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        touchesEnded(touches, with: event)
    } //touchesCanceled
    
    public func dThetaShipWheel() {
        
        let origin = CGPoint(x: (shipWheel?.position.x)!, y: (shipWheel?.position.y)! - wheelsOriginOffset)
        
        if let touchLocation = self.shipWheelTouchLocation {
            if let previousTouchLocation = self.previousShipWheelTouchLocation {
                let theta1 = angleBetween(origin: origin, pointB: touchLocation)
                let theta2 = angleBetween(origin: origin, pointB: previousTouchLocation)
                var dTheta = theta2 - theta1
                if dTheta < -5 {
                    dTheta = dTheta + 2*CGFloat.pi
                }
                else if dTheta > 5 {
                    dTheta = dTheta - 2*CGFloat.pi
                }
                else if dTheta < -2 {
                    dTheta = dTheta + CGFloat.pi
                }
                else if dTheta > 2 {
                    dTheta = dTheta - CGFloat.pi
                }
                if dTheta > dThetaLimit {dTheta = dThetaLimit}
                if dTheta < -dThetaLimit {dTheta = -dThetaLimit}

                shipWheel?.physicsBody?.angularVelocity = -dTheta * shipWheelVelocity
            }
        }
        self.previousShipWheelTouchLocation = self.shipWheelTouchLocation
    }
    
    public func dThetaSailWheel() {
        
        let origin = CGPoint(x: (sailWheel?.position.x)!, y: (sailWheel?.position.y)! - wheelsOriginOffset)
        
        if let touchLocation = self.sailWheelTouchLocation {
            if let previousTouchLocation = self.previousSailWheelTouchLocation {
                let theta1 = angleBetween(origin: origin, pointB: touchLocation)
                let theta2 = angleBetween(origin: origin, pointB: previousTouchLocation)
                var dTheta = theta2 - theta1
                if dTheta < -5 {
                    dTheta = dTheta + 2*CGFloat.pi
                }
                else if dTheta > 5 {
                    dTheta = dTheta - 2*CGFloat.pi
                }
                else if dTheta < -2 {
                    dTheta = dTheta + CGFloat.pi
                }
                else if dTheta > 2 {
                    dTheta = dTheta - CGFloat.pi
                }
                if dTheta > dThetaLimit {dTheta = dThetaLimit}
                if dTheta < -dThetaLimit {dTheta = -dThetaLimit}
                
                sailWheel?.physicsBody?.angularVelocity = -dTheta * sailWheelVelocity
            }
        }
        self.previousSailWheelTouchLocation = self.sailWheelTouchLocation
    }


    
}
