//
//  Buttons_Ext.swift
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

    func setupSettingsMenuButtons() {
        if let SoundButton = settingsMenu.childNode(withName: "SoundButton") as? SKSpriteNode {
            soundButton = SoundButton
        } else {
            print("sound button not found")
        }

        if let BackButton = settingsMenu.childNode(withName: "BackButton") as? SKSpriteNode {
            backButton = BackButton
        } else {
            print("back button not found")
        }

        if let FiveDiceButton = settingsMenu.childNode(withName: "FiveDiceButton") as? SKSpriteNode {
            fiveDiceButton = FiveDiceButton
        } else {
            print("five dice button not found")
        }

        if let SixDiceButton = settingsMenu.childNode(withName: "SixDiceButton") as? SKSpriteNode {
            sixDiceButton = SixDiceButton
        } else {
            print("six dice button not found")
        }

        if let NumPlayersPlusButton = settingsMenu.childNode(withName: "NumPlayersPlus") as? SKSpriteNode {
            numPlayersPlusButton = NumPlayersPlusButton
        } else {
            print("num players plus button not found")
        }

        if let NumPlayersMinusButton = settingsMenu.childNode(withName: "NumPlayersMinus") as? SKSpriteNode {
            numPlayersMinusButton = NumPlayersMinusButton
        } else {
            print("num players minus button not found")
        }

        if let TargetScorePlusButton = settingsMenu.childNode(withName: "TargetScorePlus") as? SKSpriteNode {
            targetScorePlusButton = TargetScorePlusButton
        } else {
            print("target score plus button not found")
        }

        if let TargetScoreMinusButton = settingsMenu.childNode(withName: "TargetScoreMinus") as? SKSpriteNode {
            targetScoreMinusButton = TargetScoreMinusButton
        } else {
            print("target score minus button not found")
        }

        if let MatchScoreOnButton = settingsMenu.childNode(withName: "MatchScoreOn") as? SKSpriteNode {
            matchScoreOnButton = MatchScoreOnButton
            matchScoreButtonPosition = matchScoreOnButton.position
        } else {
            print("match score on button not found")
        }

        if let MatchScoreOffButton = settingsMenu.childNode(withName: "MatchScoreOff") as? SKSpriteNode {
            matchScoreOffButton = MatchScoreOffButton
            matchScoreButtonPosition = matchScoreOffButton.position
        } else {
            print("match score off button not found")
        }
        setupButtonArrays()
    }

    func setupButtonArrays() {
        mainMenuButtonsArray = [newGameButton, resumeGameButton, settingsButton, exitButton, infoButton]
        settingsMenuButtonsArray = [soundButton, backButton, numPlayersMinusButton, numPlayersPlusButton, targetScorePlusButton, targetScoreMinusButton, matchScoreOnButton, matchScoreOffButton, fiveDiceButton, sixDiceButton]
        buttonWindowButtonsArray = [pauseButton, rollDiceButton, keepScoreButton]
    }
}
