//
//  GameScene.swift
//  Challenge6
//
//  Created by Daniel Ziper on 8/1/20.
//  Copyright © 2020 Daniel Ziper. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var score = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    var scoreLabel: SKLabelNode!
    var rows = [TargetRow]()
    
    var gameTimer: Timer?
    let maxAmmo = 10
    var ammo = 0{
        didSet{
            ammoLabel.text = "Ammo: \(ammo)"
        }
    }
    var ammoLabel: SKLabelNode!
    var rounds = 0
    var maxRounds = 100
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        let background = SKSpriteNode(imageNamed: "Background")
        background.zPosition = -1
        background.blendMode = .replace
        background.position = CGPoint(x: 512, y: 384)
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 100, y: 700)
        scoreLabel.fontSize = 44
        scoreLabel.horizontalAlignmentMode = .left
        score = 0
        addChild(scoreLabel)
        
        ammoLabel = SKLabelNode(fontNamed: "Chalkduster")
        ammoLabel.position = CGPoint(x: 1000, y: 700)
        ammoLabel.fontSize = 44
        ammoLabel.horizontalAlignmentMode = .right
        ammo = maxAmmo
        ammoLabel.name = "reload"
        addChild(ammoLabel)
        
        var right = true
        
        for i in 0...2{
            let targetRow = TargetRow()
            targetRow.configure(at: CGPoint(x: 0, y: 400 - i * 160), numTargets: 5, right: right)
            right = !right
            addChild(targetRow)
            rows.append(targetRow)
        }
       
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(slide), userInfo: nil, repeats: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        
        let nodeList = nodes(at: touch.location(in: self))
        if ammo > 0{
            ammo -= 1
        }

        for node in nodeList{
            if node.name?.contains("target") ?? false{
                if ammo > 0{
                    guard let target = node as? Target else {return}
                    target.hit()
                    score += target.score

                }
                
            }else if node.name == "reload"{
                ammo = maxAmmo
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    @objc func slide(){
        if rounds < maxRounds{
            rounds += 1
            for row in rows{
                row.slide(right: true)
            }
        }else {
            gameTimer?.invalidate()
        }
        
    }
}
