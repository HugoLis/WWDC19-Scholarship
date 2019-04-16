//
//  Paths.swift
//  Wind
//
//  Created by Hugo Lispector on 02/03/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import Foundation
import SpriteKit

public class Paths {
    let shape = UIBezierPath()
    let boat = UIBezierPath()
    
    public init(lakeNumber: Int) {
        
        boat.move(to: CGPoint(x: 48, y: 5)) //18
        boat.addLine(to: CGPoint(x: 82.4, y: 62.52))
        boat.addLine(to: CGPoint(x: 90.9, y: 162.56))
        boat.addLine(to: CGPoint(x: 67.09, y: 242.79))
        boat.addLine(to: CGPoint(x: 28.91, y: 242.79))
        boat.addLine(to: CGPoint(x: 5.1, y: 162.56))
        boat.addLine(to: CGPoint(x: 13.6, y: 62.52))
        boat.close()
        
        let translateTransform = CGAffineTransform(translationX: -96.933/2, y: -254.308) //x: -96.933/2, y: -254.308/2
        let yInverseTransform = CGAffineTransform(scaleX: 0.15, y: -0.15) //1, -1
        boat.apply(translateTransform)
        boat.apply(yInverseTransform)
        
        
        switch lakeNumber {
            
        case 1:
            shape.move(to: CGPoint(x: 710.26, y: 98.11))
            shape.addCurve(to: CGPoint(x: 448.55, y: 25), controlPoint1: CGPoint(x: 657.52, y: 3.89), controlPoint2: CGPoint(x: 541.76, y: -26.78))
            shape.addCurve(to: CGPoint(x: 371, y: 110.45), controlPoint1: CGPoint(x: 414.07, y: 44.18), controlPoint2: CGPoint(x: 388.43, y: 75.56))
            shape.addCurve(to: CGPoint(x: 166.75, y: 320.03), controlPoint1: CGPoint(x: 371, y: 110.82), controlPoint2: CGPoint(x: 290.29, y: 269.16))
            shape.addCurve(to: CGPoint(x: 166.75, y: 320.03), controlPoint1: CGPoint(x: 166.75, y: 320.03), controlPoint2: CGPoint(x: 166.75, y: 320.08))
            shape.addCurve(to: CGPoint(x: 111.49, y: 351.03), controlPoint1: CGPoint(x: 147.09, y: 328.89), controlPoint2: CGPoint(x: 128.98, y: 338.44))
            shape.addCurve(to: CGPoint(x: 36, y: 686.2), controlPoint1: CGPoint(x: 2.78, y: 429), controlPoint2: CGPoint(x: -34.56, y: 569.54))
            shape.addCurve(to: CGPoint(x: 40.65, y: 693.69), controlPoint1: CGPoint(x: 37.62, y: 688.87), controlPoint2: CGPoint(x: 39.75, y: 692.2))
            shape.addCurve(to: CGPoint(x: 93.77, y: 973.53), controlPoint1: CGPoint(x: 116.26, y: 805.44), controlPoint2: CGPoint(x: 121.75, y: 878.18))
            shape.addCurve(to: CGPoint(x: 120.32, y: 1146.75), controlPoint1: CGPoint(x: 76.77, y: 1042.18), controlPoint2: CGPoint(x: 90.27, y: 1091.53))
            shape.addCurve(to: CGPoint(x: 497.92, y: 1259.43), controlPoint1: CGPoint(x: 194.09, y: 1282.32), controlPoint2: CGPoint(x: 359.72, y: 1334.75))
            shape.addCurve(to: CGPoint(x: 612.52, y: 877.78), controlPoint1: CGPoint(x: 636.12, y: 1184.11), controlPoint2: CGPoint(x: 687.28, y: 1020.38))
            shape.addCurve(to: CGPoint(x: 648.44, y: 352.21), controlPoint1: CGPoint(x: 537.76, y: 735.18), controlPoint2: CGPoint(x: 463.12, y: 498.25))
            shape.addCurve(to: CGPoint(x: 710.26, y: 98.11), controlPoint1: CGPoint(x: 749.76, y: 272.18), controlPoint2: CGPoint(x: 760.45, y: 187.75))
            shape.close()
            
            let translateTransform = CGAffineTransform(translationX: -739.472/2, y: -1293.966/2)
            let yInverseTransform = CGAffineTransform(scaleX: 1, y: -1)
            shape.apply(translateTransform)
            shape.apply(yInverseTransform)
            
        case 2:
            shape.move(to: CGPoint(x: 1150.85, y: 338.62))
            shape.addCurve(to: CGPoint(x: 1188.73, y: 280.11), controlPoint1: CGPoint(x: 1162.85, y: 323.46), controlPoint2: CGPoint(x: 1179.18, y: 300.49))
            shape.addCurve(to: CGPoint(x: 1112.22, y: 23.28), controlPoint1: CGPoint(x: 1233.99, y: 183.57), controlPoint2: CGPoint(x: 1215.52, y: 75.11))
            shape.addCurve(to: CGPoint(x: 837.22, y: 99.28), controlPoint1: CGPoint(x: 1008.92, y: -28.55), controlPoint2: CGPoint(x: 896.34, y: 10.28))
            shape.addCurve(to: CGPoint(x: 810.45, y: 182.95), controlPoint1: CGPoint(x: 820.03, y: 125.15), controlPoint2: CGPoint(x: 813.75, y: 153.44))
            shape.addCurve(to: CGPoint(x: 357.14, y: 543.89), controlPoint1: CGPoint(x: 789.67, y: 390.45), controlPoint2: CGPoint(x: 572.15, y: 546.82))
            shape.addCurve(to: CGPoint(x: 163.83, y: 642.33), controlPoint1: CGPoint(x: 278.2, y: 541.27), controlPoint2: CGPoint(x: 204.66, y: 577.36))
            shape.addCurve(to: CGPoint(x: 170.03, y: 865.2), controlPoint1: CGPoint(x: 120.34, y: 711.52), controlPoint2: CGPoint(x: 125.41, y: 797.51))
            shape.addCurve(to: CGPoint(x: 100.19, y: 1146.31), controlPoint1: CGPoint(x: 240.78, y: 975.6), controlPoint2: CGPoint(x: 191.14, y: 1066.1))
            shape.addCurve(to: CGPoint(x: 33.47, y: 1224.31), controlPoint1: CGPoint(x: 74.19, y: 1168.31), controlPoint2: CGPoint(x: 49.86, y: 1195.31))
            shape.addCurve(to: CGPoint(x: 123.78, y: 1545.19), controlPoint1: CGPoint(x: -32.78, y: 1341.84), controlPoint2: CGPoint(x: 0.47, y: 1478.73))
            shape.addCurve(to: CGPoint(x: 456.67, y: 1457.03), controlPoint1: CGPoint(x: 247.09, y: 1611.65), controlPoint2: CGPoint(x: 387.21, y: 1570.19))
            shape.addCurve(to: CGPoint(x: 490.59, y: 1321.03), controlPoint1: CGPoint(x: 481.82, y: 1416.03), controlPoint2: CGPoint(x: 490.91, y: 1367.61))
            shape.addCurve(to: CGPoint(x: 908.09, y: 867.22), controlPoint1: CGPoint(x: 497.16, y: 1096.57), controlPoint2: CGPoint(x: 651.97, y: 873.56))
            shape.addCurve(to: CGPoint(x: 1086.66, y: 785.22), controlPoint1: CGPoint(x: 977.49, y: 867.31), controlPoint2: CGPoint(x: 1044.97, y: 837.44))
            shape.addCurve(to: CGPoint(x: 1112.37, y: 590.51), controlPoint1: CGPoint(x: 1132.2, y: 728.22), controlPoint2: CGPoint(x: 1140.51, y: 655.65))
            shape.addCurve(to: CGPoint(x: 1150.85, y: 338.62), controlPoint1: CGPoint(x: 1076.13, y: 507.32), controlPoint2: CGPoint(x: 1092.83, y: 411.87))
            shape.close()
            
            let translateTransform = CGAffineTransform(translationX: -1211.967/2, y: -1577.048/2)
            let yInverseTransform = CGAffineTransform(scaleX: 1, y: -1)
            shape.apply(translateTransform)
            shape.apply(yInverseTransform)
            
            
        case 3:
            shape.move(to: CGPoint(x: 1541.79, y: 523.55))
            shape.addCurve(to: CGPoint(x: 1641.98, y: 353.91), controlPoint1: CGPoint(x: 1587.24, y: 434.18), controlPoint2: CGPoint(x: 1590.33, y: 430.25))
            shape.addLine(to: CGPoint(x: 1641.03, y: 355.27))
            shape.addCurve(to: CGPoint(x: 1681.7, y: 226.29), controlPoint1: CGPoint(x: 1667.5, y: 317.47), controlPoint2: CGPoint(x: 1681.7, y: 272.44))
            shape.addCurve(to: CGPoint(x: 1455.76, y: 0), controlPoint1: CGPoint(x: 1681.7, y: 101.16), controlPoint2: CGPoint(x: 1580.54, y: 0))
            shape.addLine(to: CGPoint(x: 1455.47, y: -0))
            shape.addCurve(to: CGPoint(x: 1296.21, y: 65.97), controlPoint1: CGPoint(x: 1395.73, y: -0), controlPoint2: CGPoint(x: 1338.44, y: 23.73))
            shape.addLine(to: CGPoint(x: 1295.18, y: 67))
            shape.addCurve(to: CGPoint(x: 1141.42, y: 203.93), controlPoint1: CGPoint(x: 1227.66, y: 135.22), controlPoint2: CGPoint(x: 1226.3, y: 137.25))
            shape.addCurve(to: CGPoint(x: 826.28, y: 190.19), controlPoint1: CGPoint(x: 1022.25, y: 287.4), controlPoint2: CGPoint(x: 960.73, y: 289.93))
            shape.addLine(to: CGPoint(x: 826.32, y: 190.22))
            shape.addCurve(to: CGPoint(x: 646.34, y: 130), controlPoint1: CGPoint(x: 774.46, y: 151.14), controlPoint2: CGPoint(x: 711.28, y: 130))
            shape.addCurve(to: CGPoint(x: 350.09, y: 377.67), controlPoint1: CGPoint(x: 498, y: 130), controlPoint2: CGPoint(x: 375, y: 236.91))
            shape.addCurve(to: CGPoint(x: 145.78, y: 672.86), controlPoint1: CGPoint(x: 315.75, y: 552.17), controlPoint2: CGPoint(x: 297.23, y: 578.8))
            shape.addCurve(to: CGPoint(x: 0, y: 930.44), controlPoint1: CGPoint(x: 58.44, y: 725.4), controlPoint2: CGPoint(x: 0, y: 821.09))
            shape.addCurve(to: CGPoint(x: 300.39, y: 1230.83), controlPoint1: CGPoint(x: 0, y: 1096.34), controlPoint2: CGPoint(x: 134.49, y: 1230.83))
            shape.addCurve(to: CGPoint(x: 557.82, y: 1085.3), controlPoint1: CGPoint(x: 409.63, y: 1230.83), controlPoint2: CGPoint(x: 505.24, y: 1172.5))
            shape.addCurve(to: CGPoint(x: 1109.18, y: 946.14), controlPoint1: CGPoint(x: 714.77, y: 833.37), controlPoint2: CGPoint(x: 894.53, y: 814.3))
            shape.addLine(to: CGPoint(x: 1110.25, y: 946.82))
            shape.addCurve(to: CGPoint(x: 1244.4, y: 985.28), controlPoint1: CGPoint(x: 1150.48, y: 971.95), controlPoint2: CGPoint(x: 1196.96, y: 985.28))
            shape.addCurve(to: CGPoint(x: 1498.85, y: 741.55), controlPoint1: CGPoint(x: 1381.68, y: 985.28), controlPoint2: CGPoint(x: 1493.3, y: 877.1))
            shape.addLine(to: CGPoint(x: 1498.85, y: 741.55))
            shape.addCurve(to: CGPoint(x: 1541.79, y: 523.55), controlPoint1: CGPoint(x: 1503.49, y: 630.66), controlPoint2: CGPoint(x: 1503.93, y: 623.34))
            shape.close()
            
            let translateTransform = CGAffineTransform(translationX: -1679/2, y: -1245.827/2) //-1681.7/2  ,   -1230.827/2
            let yInverseTransform = CGAffineTransform(scaleX: 1, y: -1)
            shape.apply(translateTransform)
            shape.apply(yInverseTransform)
        default:
            print("no lake")
        }
        
    }
    
}
