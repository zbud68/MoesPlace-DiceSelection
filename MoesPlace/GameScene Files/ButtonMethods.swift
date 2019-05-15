//
//  ButtonMethods.swift
//  MoesPlace
//
//  Created by Mark Davis on 5/9/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

extension GameScene {
    func newGameButtonTouched() {
        if gameState == .InProgress {
            gameInProgressMessage(on: scene!, title: "Game In Progress", message: GameConstants.Messages.GameInProgress)
        } else {
            hideMenu(menu: mainMenu)
            setupNewGame()
        }
    }

    func resumeGameButtonTouched() {
        if gameState == .NewGame {
            noGameInProgessMessage(on: scene!, title: "No Game In Progess", message: GameConstants.Messages.NoGameInProgress)
        } else {
            hideMenu(menu: mainMenu)
        }
    }

    func settingsButtonTouched() {
        if gameState == .InProgress {
            settingsMessage(on: scene!, title: "Game in Progress", message: GameConstants.Messages.Settings)
        } else {
            hideMenu(menu: mainMenu)
            showMenu(menu: settingsMenu)
        }
    }

    func exitButtonTouched() {
        if gameState == .InProgress {
            gameInProgressMessage(on: scene!, title: "Game in Progress", message: GameConstants.Messages.GameInProgress)
        } else {
            gameOverMessage(on: scene!, title: "Game Over", message: GameConstants.Messages.GameOver)
            exit(0)
        }
    }

    func infoButtonTouched() {
        hideMenu(menu: mainMenu)
        showMenu(menu: helpMenu)
    }

    func soundButtonTouched() {

    }

    func backButtonTouched() {
        resetGameSettings()
        hideMenu(menu: helpMenu)
        hideMenu(menu: settingsMenu)
        showMenu(menu: mainMenu)
    }

    func pauseButtonTouched() {
        showMenu(menu: mainMenu)
    }

    func keepScoreButtonTouched() {
        if dieSelected == false {
            selectScoringDieMessage(on: scene!, title: "Select a Scoring Die", message: GameConstants.Messages.NoScoringDieSelected)
        } else {
            displayPlayerScore(playerName: currentPlayer.name)
            print("\(currentPlayer.name): \(currentPlayer.score)")
            dieSelected = false
        }
        resetDice()
        nextPlayer()
    }
}
