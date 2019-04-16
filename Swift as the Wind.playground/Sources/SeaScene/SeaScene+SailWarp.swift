//
//  SeaScene+SailWarp.swift
//  Wind
//
//  Created by Hugo Lispector on 05/03/19.
//  Copyright © 2018 Hugo. All rights reserved.
//

import SpriteKit

public extension SeaScene {
    
    func distortRight(grid: [vector_float2] ) -> [vector_float2] {
        
        var outputGrid = grid

        //left to right
        outputGrid[0].x = outputGrid[0].x + 0.6
        outputGrid[3].x = outputGrid[3].x + 0.7
        outputGrid[6].x = outputGrid[6].x + 0.6
        //right to right
        outputGrid[2].x = outputGrid[2].x + 0.3
        outputGrid[5].x = outputGrid[5].x + 0.4
        outputGrid[8].x = outputGrid[8].x + 0.3
        //center slightly to right
        outputGrid[4].x = outputGrid[4].x + 0.1

        return outputGrid
    }
    
    func distortleft(grid: [vector_float2] ) -> [vector_float2] {
        
        var outputGrid = grid
        
        //left to left
        outputGrid[0].x = outputGrid[0].x - 0.3
        outputGrid[3].x = outputGrid[3].x - 0.4
        outputGrid[6].x = outputGrid[6].x - 0.3
        //right to left
        outputGrid[2].x = outputGrid[2].x - 0.6
        outputGrid[5].x = outputGrid[5].x - 0.7
        outputGrid[8].x = outputGrid[8].x - 0.6
        //center slightly to left
        outputGrid[4].x = outputGrid[4].x - 0.1
        
        return outputGrid
    }
    
    func shrinkHorizontally(grid: [vector_float2] ) -> [vector_float2] {
        
        var outputGrid = grid
        
        //left to left
        outputGrid[0].x = outputGrid[0].x + 0.2
        outputGrid[3].x = outputGrid[3].x + 0.2
        outputGrid[6].x = outputGrid[6].x + 0.2
        //right to left
        outputGrid[2].x = outputGrid[2].x - 0.2
        outputGrid[5].x = outputGrid[5].x - 0.2
        outputGrid[8].x = outputGrid[8].x - 0.2
        
        return outputGrid
    }
    
    func sailWarping(){
        
        let sourceGrid = [
            // bottom row: left, center, right
            vector_float2(0.0, 0.0),
            vector_float2(0.5, 0.0),
            vector_float2(1.0, 0.0),
            // middle row: left, center, right
            vector_float2(0.0, 0.5),
            vector_float2(0.5, 0.5),
            vector_float2(1.0, 0.5),
            // top row: left, center, right
            vector_float2(0.0, 1.0),
            vector_float2(0.5, 1.0),
            vector_float2(1.0, 1.0)
        ]
        
        let warp = SKWarpGeometryGrid(columns: 2, rows: 2, sourcePositions: sourceGrid, destinationPositions: sourceGrid)
        sail?.warpGeometry = warp
        // take a copy of our source points
        var destinationGrid = sourceGrid
        // pull out the existing warp geometry so we have something to animate back to
        if ((boatIsPushedForward! && (sail?.zRotation)! > 0 && (sail?.zRotation)! <= CGFloat.pi/2 + 0.000001) || (boatIsPushedForward! == false && (sail?.zRotation)! >= -CGFloat.pi/2 - 0.000001 && (sail?.zRotation)! < 0)){
            destinationGrid = distortRight(grid: sourceGrid)
        }
        else {
            if ((boatIsPushedForward! == false && (sail?.zRotation)! > 0 && (sail?.zRotation)! <= CGFloat.pi/2 + 0.000001) || (boatIsPushedForward! && (sail?.zRotation)! >= -CGFloat.pi/2 - 0.000001 && (sail?.zRotation)! < 0)){
                destinationGrid = distortleft(grid: sourceGrid)
            }
        }
        
        //sailLuffing
        sail?.shader = nil
        isSailWiggling = false

        if abs(sin(apparentWindAngle! - trueSailAngle!)) < 0.05 && sail?.shader == nil{
            
            destinationGrid = shrinkHorizontally(grid: sourceGrid)
            
            let wiggleUniforms: [SKUniform] = [
                SKUniform(name: "u_speed", float: 150),
                SKUniform(name: "u_strength", float: 10),
                SKUniform(name: "u_frequency", float: 6)
            ]
            sailShader = SKShader(fileNamed: "Shaders/sailShader")
            sailShader?.uniforms = wiggleUniforms
            sail?.shader = sailShader
            isSailWiggling = true
        }
        
        // create a new warp geometry by mapping from src to dst
        let newWarp = SKWarpGeometryGrid(columns: 2, rows: 2, sourcePositions: sourceGrid, destinationPositions: destinationGrid)
        
        if let action = SKAction.animate(withWarps: [newWarp], times: [0.5]) {
            // run it on the sprite
            sail?.run(action)
        }
    } //sailWarping
    
}
