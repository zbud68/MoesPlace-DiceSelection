//
//  Game.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/14/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

struct Game {

    var numDice: Int!
    var numPlayers: Int!
    var targetScore: Int!
    var matchTargetScore: Bool!
    var numRounds: Int!

    init(numPlayers: Int, numDice: Int, targetScore: Int, matchTargetScore: Bool, numRounds: Int) {

        self.numPlayers = numPlayers
        self.numDice = numDice
        self.targetScore = targetScore
        self.matchTargetScore = matchTargetScore
        self.numRounds = numRounds
    }
}


