//
//  target.swift
//  Challenge6
//
//  Created by Daniel Ziper on 8/1/20.
//  Copyright © 2020 Daniel Ziper. All rights reserved.
//

import Foundation
import SpriteKit

class Target: SKSpriteNode{
    var isHit = false
    var resetPoint: CGPoint!
    var score = 1
    var right = false
    var isGood = false
    
    func hit(){
        isHit = true
        self.removeAllActions()
        
        let scale = SKAction.scale(by: 0.8, duration: 0.25)
        let wait = SKAction.wait(forDuration: 0.25)
        let dissapear = SKAction.fadeAlpha(to: 0, duration: 0.25)
        
        let sequence = SKAction.sequence([scale, wait, dissapear])
        self.run(sequence)
    }
    
    func slide(_ direction: Int){
        let newScale = CGFloat.random(in: 0.4...1.5)
        
        let scoreMult = isGood ? -1 : 1
        score = Int(5.0/newScale) * scoreMult
        
        let alpha = SKAction.fadeAlpha(to: 1, duration: 0)
        let scale = SKAction.scale(to: newScale, duration: 0)
        let invDirection = right ? 0 : 1
        let move = SKAction.move(to: CGPoint(x: invDirection * 1500 - 300, y: 0), duration: Double.random(in: 0.5...3))
        self.run(SKAction.sequence([alpha,scale,move]))
        
    }
    
    func reset(){
        if !self.hasActions() || isHit{
            self.position = resetPoint
            self.removeAllActions()
            isHit = false
            
            let newGoodness = Bool.random()
            if newGoodness != isGood{
                isGood = newGoodness
                let nameEnd = isGood ? "Good" : "Bad"
                self.texture = SKTexture(imageNamed: "Target\(nameEnd)")
                self.name = "target\(nameEnd)"
            }
            
        }
    }
}

class TargetRow: SKNode{
    var targets = [Target]()
    var numTargets = 0
    var counter = 0
    
    
    func configure(at position: CGPoint, numTargets: Int, right: Bool){
        self.position = position
        self.numTargets = numTargets
        let direction = right ? 1 : 0
        
        for _ in 0..<numTargets{
            let isGood = Bool.random()
            let nameEnd = isGood ? "Good" : "Bad"
            let target = Target(imageNamed: "Target\(nameEnd)")
            let resetPoint = CGPoint(x: direction * 1500 - 300, y: 0)
            target.position = resetPoint
            target.resetPoint = resetPoint
            target.name = "target\(nameEnd)"
            target.right = right
            target.isGood = isGood
            targets.append(target)
            self.addChild(target)
        }
    }
    
    func slide(right: Bool){
        if counter >= numTargets{
            print("resetting")
            for target in targets{
                target.reset()
            }
            counter = 0
        }
        let direction = right ? 1 : 0
        
        targets[counter].slide(direction)
        counter += 1
    }
    
    
}
