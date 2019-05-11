//
//  Player.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

struct Player {
    var name: String = ""
    var score: Int = Int()
    var scoreLabel: SKLabelNode = SKLabelNode(fontNamed: "Marker Felt Wide")
    var nameLabel: SKLabelNode

    init(name: String, score: Int, nameLabel: SKLabelNode) {
        self.name = name
        self.score = score
        self.nameLabel = nameLabel
    }
}

