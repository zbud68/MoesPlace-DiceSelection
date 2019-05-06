//
//  Icon_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func setupButtonWindowButtons() {
        if let PauseButton = buttonWindow.childNode(withName: "PauseButton") as? SKSpriteNode {
            pauseButton = PauseButton

        } else {
            print("pause button not found")
        }

        if let RollDiceButton = buttonWindow.childNode(withName: "RollButton") as? SKSpriteNode {
            rollDiceButton = RollDiceButton
        } else {
            print("roll dice button not found")
        }

        if let KeepScoreButton = buttonWindow.childNode(withName: "KeepButton") as? SKSpriteNode {
            keepScoreButton = KeepScoreButton
       } else {
            print("keep button not found")
        }
        setupButtonArrays()
    }

    func setupButtonArrays() {
        mainMenuButtonsArray = [newGameButton, resumeGameButton, settingsButton, exitButton, infoButton]
        settingsMenuButtonsArray = [soundButton, backButton]
        buttonWindowButtonsArray = [pauseButton, rollDiceButton, keepScoreButton]
    }
}
