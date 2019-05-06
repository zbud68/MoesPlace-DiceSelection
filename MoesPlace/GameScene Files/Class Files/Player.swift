//
//  Player.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

class Player {
    let nameLabel: SKLabelNode = SKLabelNode()
    var name: String

    var score: Int
    var currentRollScore: Int
    var scoreLabel: SKLabelNode = SKLabelNode()
    var hasScoringDice: Bool
    var firstRoll: Bool = true
    
    init(name: String, score: Int, currentRollScore: Int, hasScoringDice: Bool)
    {
        self.name = name
        self.score = score
        self.currentRollScore = currentRollScore
        self.hasScoringDice = hasScoringDice
    }
}

