//
//  GameSceneSetup.swift
//  MoesPlace
//
//  Created by Mark Davis on 5/9/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

extension GameScene {
    func setupPlayerScorePlaceHolders() {
        if let Player1ScorePlaceHolder = scoresWindow.childNode(withName: "Player1ScorePlaceHolder") {
            player1ScorePlaceHolder = Player1ScorePlaceHolder.position
        }

        if let Player2ScorePlaceHolder = scoresWindow.childNode(withName: "Player2ScorePlaceHolder") {
            player2ScorePlaceHolder = Player2ScorePlaceHolder.position
        }

        if let Player3ScorePlaceHolder = scoresWindow.childNode(withName: "Player3ScorePlaceHolder") {
            player3ScorePlaceHolder = Player3ScorePlaceHolder.position
        }

        if let Player4ScorePlaceHolder = scoresWindow.childNode(withName: "Player4ScorePlaceHolder") {
            player4ScorePlaceHolder = Player4ScorePlaceHolder.position
        }
    }

    func setupNewGame() {
        for player in playersArray {
            scoresWindow.addChild(player.scoreLabel)
        }
        gameState = .NewGame
        resetCurrentScoreVariables()
        resetArrays()
        resetScoringCombosArray()
        resetDiePhysics()
        resetDieVariables()
        resetGameSettings()
        resetPlaceHoldersArray(isComplete: handlerBlock)
        firstRoll = true
    }

    func displayPlayerScore(playerName: String) {
        currentPlayerScore = 0
        currentRollScore += currentScore
        score = currentRollScore
        currentPlayerScore += score

        switch playerName {
        case "Player 1":
            player1.score += currentPlayerScore
            player1.scoreLabel.text = "\(player1.score)"
        case "Player 2":
            player2.score += currentPlayerScore
            player2.scoreLabel.text = "\(player2.score)"
        case "Player 3":
            player3.score += currentPlayerScore
            player3.scoreLabel.text = "\(player3.score)"
        case "Player 4":
            player4.score += currentPlayerScore
            player4.scoreLabel.text = "\(player4.score)"
        default:
            break
        }
    }

    func showMenu(menu: SKSpriteNode) {
        menuVisible = true
        let currentMenu = menu
        currentMenu.xScale = 2
        currentMenu.yScale = 2
        currentMenu.position = CGPoint(x: 0, y: 0)
    }

    func hideMenu(menu: SKSpriteNode) {
        menuVisible = false
        let currentMenu = menu
        currentMenu.xScale = 0.25
        currentMenu.yScale = 0.25
        switch currentMenu.name {
        case "MainMenu":
            currentMenu.position = CGPoint(x: 500, y: -150)
        case "SettingsMenu":
            currentMenu.position = CGPoint(x: 500, y: 0)
        case "HelpMenu":
            currentMenu.position = CGPoint(x: 500, y: -150)
        default:
            break
        }
    }

    func setupBackGround() {
        if let Background = self.childNode(withName: "Background") as? SKSpriteNode {
            background = Background
        }
    }

    func setupGameTable() {
        if let GameTable = background.childNode(withName: "GameTable") as? SKSpriteNode {
            gameTable = GameTable
        } else {
            print("game table not found")
        }
    }

    func setupLogo() {
        logo.fontName = GameConstants.StringConstants.FontName
        logo.fontColor = maroonFontColor
        logo.fontSize = GameConstants.Sizes.Logo1Font
        logo.alpha = 0.35
        logo.position = CGPoint(x: 0, y: -50)
        logo.zPosition = gameTable.zPosition + 10

        logo2.fontName = GameConstants.StringConstants.FontName
        logo2.fontColor = maroonFontColor
        logo2.fontSize = GameConstants.Sizes.Logo2Font
        logo2.alpha = 0.35
        logo2.zRotation = 75
        logo2.zPosition = gameTable.zPosition + 10
        logo2.position = CGPoint(x: -185, y: -25)
        gameTable.addChild(logo)
        logo.addChild(logo2)
    }

    func setupCurrentRollScoreLabel() {
        playerNameLabel.text = "\(currentPlayer.name):"
        playerNameLabel.fontName = GameConstants.StringConstants.FontName
        playerNameLabel.fontColor = maroonFontColor
        playerNameLabel.fontSize = GameConstants.Sizes.PlayerNameLabelFont
        playerNameLabel.position = CGPoint(x: (gameTable.frame.minX) + ((gameTable.size.width) / 3), y: (gameTable.frame.maxY) / 2)
        playerNameLabel.zPosition = gameTable.zPosition + 10
        playerNameLabel.alpha = 0.65

        currentRollScoreLabel.fontName = GameConstants.StringConstants.FontName
        currentRollScoreLabel.fontColor = maroonFontColor
        currentRollScoreLabel.fontSize = GameConstants.Sizes.PlayerScoreLabelFont
        currentRollScoreLabel.position = CGPoint(x: playerNameLabel.position.x + 110, y: playerNameLabel.position.y)
        currentRollScoreLabel.zPosition = gameTable.zPosition + 10
        currentRollScoreLabel.alpha = 0.65

        gameTable.addChild(currentRollScoreLabel)
        gameTable.addChild(playerNameLabel)
    }

    func setupScoreLabel() {
        playerNameLabel = SKLabelNode(fontNamed: "Marker Felt Wide")
        playerNameLabel.zPosition = gameTable.zPosition + 10
        playerNameLabel.fontSize = 22
        playerNameLabel.fontColor = maroonFontColor
        playerNameLabel.alpha = 0.65
        playerNameLabel.horizontalAlignmentMode = .left
        playerNameLabel.position = CGPoint(x: 0, y: (gameTable.frame.midY + (gameTable.size.height / 4)))

        currentPlayerScoreLabel = SKLabelNode(fontNamed: "Marker Felt Wide")
        currentPlayerScoreLabel.text = "\(currentPlayer.name):  \(score)"
        currentPlayerScoreLabel.zPosition = gameTable.zPosition + 10
        currentPlayerScoreLabel.fontSize = 22
        currentPlayerScoreLabel.fontColor = maroonFontColor
        currentPlayerScoreLabel.alpha = 0.65
        currentPlayerScoreLabel.horizontalAlignmentMode = .center
        currentPlayerScoreLabel.position = CGPoint(x: 0, y: playerNameLabel.position.y)

        gameTable.addChild(playerNameLabel)
        gameTable.addChild(currentPlayerScoreLabel)
    }

    func setupScoresWindow() {
        if let ScoresWindow = background.childNode(withName: "ScoresWindow") as? SKSpriteNode {
            scoresWindow = ScoresWindow
        } else {
            print("scores windows not found")
        }
    }

    func setupMainMenu() {
        if let MainMenu = gameTable.childNode(withName: "MainMenu") as? SKSpriteNode {
            mainMenu = MainMenu
        } else {
            print("main menu not found")
        }
        mainMenu.position = CGPoint(x: 0, y: 0)
        mainMenu.alpha = 1
    }

    func setupSettingsMenu() {
        if let SettingsMenu = gameTable.childNode(withName: "SettingsMenu") as? SKSpriteNode {
            settingsMenu = SettingsMenu
        } else {
            print("settings menu not found")
        }
        settingsMenu.position = CGPoint(x: 500, y: 0)
        setupSettingsMenuButtons()
    }

    func setupHelpMenu() {
        if let HelpMenu = gameTable.childNode(withName: "HelpMenu") as? SKSpriteNode {
            helpMenu = HelpMenu
        } else {
            print("help menu not found")
        }
        helpMenu.position = CGPoint(x: 500, y: -150)
    }

    func setupMainMenuButtons() {
        if let NewGameButton = mainMenu.childNode(withName: "NewGameButton") as? SKSpriteNode {
            newGameButton = NewGameButton
        } else {
            print("new game button not found")
        }

        if let ResumeGameButton = mainMenu.childNode(withName: "ResumeGameButton") as? SKSpriteNode {
            resumeGameButton = ResumeGameButton
        } else {
            print("resume game button not found")
        }

        if let SettingsButton = mainMenu.childNode(withName: "SettingsButton") as? SKSpriteNode {
            settingsButton = SettingsButton
        } else {
            print("settings button not found")
        }

        if let ExitButton = mainMenu.childNode(withName: "ExitButton") as? SKSpriteNode {
            exitButton = ExitButton
        } else {
            print("exit button not found")
        }

        if let InfoButton = mainMenu.childNode(withName: "InfoButton") as? SKSpriteNode {
            infoButton = InfoButton
        } else {
            print("info button not found")
        }
        setupButtonArrays()
    }

    func setupMainMenuLabels() {
        mainMenuLabel.text = "Main Menu"
        mainMenuLabel.fontName = GameConstants.StringConstants.FontName
        mainMenuLabel.fontSize = GameConstants.Sizes.MainMenuFont
        mainMenuLabel.fontColor = maroonFontColor
        mainMenuLabel.zPosition = mainMenu.zPosition + 10
        mainMenuLabel.position = CGPoint(x: 0, y: mainMenu.frame.maxY - (mainMenuLabel.fontSize + (mainMenuLabel.fontSize / 3)))

        newGameButtonLabel.text = "New Game"
        newGameButtonLabel.fontName = GameConstants.StringConstants.FontName
        newGameButtonLabel.fontSize = GameConstants.Sizes.ButtonLabelFont
        newGameButtonLabel.fontColor = maroonFontColor
        newGameButtonLabel.zPosition = mainMenu.zPosition + 10
        newGameButtonLabel.position = CGPoint(x: 65, y: -8)

        resumeButtonLabel.text = "Continue"
        resumeButtonLabel.fontName = GameConstants.StringConstants.FontName
        resumeButtonLabel.fontSize = GameConstants.Sizes.ButtonLabelFont
        resumeButtonLabel.fontColor = maroonFontColor
        resumeButtonLabel.zPosition = mainMenu.zPosition + 10
        resumeButtonLabel.position = CGPoint(x: 59, y: -8)

        settingsButtonLabel.text = "Settings"
        settingsButtonLabel.fontName = GameConstants.StringConstants.FontName
        settingsButtonLabel.fontSize = GameConstants.Sizes.ButtonLabelFont
        settingsButtonLabel.fontColor = maroonFontColor
        settingsButtonLabel.zPosition = mainMenu.zPosition + 10
        settingsButtonLabel.position = CGPoint(x: 58, y: -8)

        exitButtonLabel.text = "Exit Game"
        exitButtonLabel.fontName = GameConstants.StringConstants.FontName
        exitButtonLabel.fontSize = GameConstants.Sizes.ButtonLabelFont
        exitButtonLabel.fontColor = maroonFontColor
        exitButtonLabel.zPosition = mainMenu.zPosition + 10
        exitButtonLabel.position = CGPoint(x: 67, y: -8)
    }

    func setupSettingsMenuLabels() {
        settingsMenuLabel.text = "Settings Menu"
        settingsMenuLabel.fontName = GameConstants.StringConstants.FontName
        settingsMenuLabel.fontSize = GameConstants.Sizes.MainMenuFont
        settingsMenuLabel.fontColor = maroonFontColor
        settingsMenuLabel.zPosition = settingsMenu.zPosition + 10
        settingsMenuLabel.position = CGPoint(x: 0, y: settingsMenu.frame.maxY - (settingsMenuLabel.fontSize + (settingsMenuLabel.fontSize / 3)))

        soundButtonLabel.text = "Sound"
        soundButtonLabel.fontName = GameConstants.StringConstants.FontName
        soundButtonLabel.fontSize = GameConstants.Sizes.ButtonLabelFont
        soundButtonLabel.fontColor = maroonFontColor
        soundButtonLabel.zPosition = settingsMenu.zPosition + 10
        soundButtonLabel.position = CGPoint(x: 65, y: -8)

        backButtonLabel.text = "Back"
        backButtonLabel.fontName = GameConstants.StringConstants.FontName
        backButtonLabel.fontSize = GameConstants.Sizes.ButtonLabelFont
        backButtonLabel.fontColor = maroonFontColor
        backButtonLabel.zPosition = settingsMenu.zPosition + 10
        backButtonLabel.position = CGPoint(x: 59, y: -8)

        numPlayersLabel = SKLabelNode(fontNamed: "Marker Felt Wide")
        numPlayersLabel.text = "Number of Players:  \(numPlayers)"
        numPlayersLabel.fontSize = 12
        numPlayersLabel.fontColor = maroonFontColor
        numPlayersLabel.horizontalAlignmentMode = .center
        numPlayersLabel.verticalAlignmentMode = .center
        numPlayersLabel.position = CGPoint(x: -17, y: -32)
        numPlayersLabel.zPosition = settingsMenu.zPosition + 10

        targetScoreLabel = SKLabelNode(fontNamed: "Marker Felt Wide")
        targetScoreLabel.text = "Target Score: \(targetScore)"
        targetScoreLabel.fontSize = 12
        targetScoreLabel.fontColor = maroonFontColor
        targetScoreLabel.horizontalAlignmentMode = .center
        targetScoreLabel.verticalAlignmentMode = .center
        targetScoreLabel.position = CGPoint(x: -17, y: -13)
        targetScoreLabel.zPosition = settingsMenu.zPosition + 10

        settingsMenu.addChild(numPlayersLabel)
        settingsMenu.addChild(targetScoreLabel)
    }

    func addMainMenu() {
        self.addChild(mainMenu)
        mainMenu.addChild(newGameButton)
        mainMenu.addChild(resumeGameButton)
        mainMenu.addChild(settingsButton)
        mainMenu.addChild(exitButton)
        mainMenu.addChild(infoButton)
        newGameButton.addChild(newGameButtonLabel)
        resumeGameButton.addChild(resumeButtonLabel)
        settingsButton.addChild(settingsButtonLabel)
        exitButton.addChild(exitButtonLabel)
    }

    func addSettingsMenu() {
        self.addChild(settingsMenu)
        settingsMenu.addChild(soundButton)
        soundButton.addChild(soundButtonLabel)
        settingsMenu.addChild(backButton)
        backButton.addChild(backButtonLabel)
    }
}
