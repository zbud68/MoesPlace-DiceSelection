//
//  Window_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func setupButtonWindow() {
        if let ButtonWindow = background.childNode(withName: "ButtonsWindow") as? SKSpriteNode {
            buttonWindow = ButtonWindow
        } else {
            print("Button window not found")
        }
        setupButtonWindowButtons()
    }

    func setupScoresWindow() {
        if let ScoresWindow = background.childNode(withName: "ScoresWindow") as? SKSpriteNode {
            scoresWindow = ScoresWindow
        } else {
            print("scores windows not found")
        }
    }
}
