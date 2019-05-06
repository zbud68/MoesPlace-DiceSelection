//
//  BackGround_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func setupBackGround() {

        if let Background = self.childNode(withName: "Background") as? SKSpriteNode {
            background = Background
        }
    }
}
