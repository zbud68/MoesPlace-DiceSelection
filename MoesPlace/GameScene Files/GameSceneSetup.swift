//
//  GameSceneSetup.swift
//  MoesPlace
//
//  Created by Mark Davis on 5/9/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

extension GameScene {
    func setupNewGame() {
        gameState = .NewGame
        resetDice()
        resetCurrentScoreVariables()
        resetArrays()
        resetScoringCombosArray()
        resetDiePhysics()
        resetDieVariables()
    }

    func displayPlayerScore(playerName: String) {
        currentRollScore += currentScore
        score = currentRollScore
        
        switch playerName {
        case "Player 1":
            player1.score += score
            player1.scoreLabel.text = String(player1.score)
        case "Player 2":
            player2.score += score
            player2.scoreLabel.text = String(player2.score)
        case "Player 3":
            player3.score += score
            player3.scoreLabel.text = String(player3.score)
        case "Player 4":
            player4.score += score
            player4.scoreLabel.text = String(player4.score)
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
        logo.zPosition = gameTable.zPosition + 1

        logo2.fontName = GameConstants.StringConstants.FontName
        logo2.fontColor = maroonFontColor
        logo2.fontSize = GameConstants.Sizes.Logo2Font
        logo2.alpha = 0.35
        logo2.zRotation = 75

        logo2.zPosition = logo.zPosition
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
        playerNameLabel.zPosition = GameConstants.ZPositions.NameLabel
        playerNameLabel.alpha = 0.65

        currentRollScoreLabel.fontName = GameConstants.StringConstants.FontName
        currentRollScoreLabel.fontColor = maroonFontColor
        currentRollScoreLabel.fontSize = GameConstants.Sizes.PlayerScoreLabelFont
        currentRollScoreLabel.position = CGPoint(x: playerNameLabel.position.x + 110, y: playerNameLabel.position.y)
        currentRollScoreLabel.zPosition = GameConstants.ZPositions.ScoreLabel
        currentRollScoreLabel.alpha = 0.65

        gameTable.addChild(currentRollScoreLabel)
        gameTable.addChild(playerNameLabel)
    }

    func setupScoreLabel() {
        currentPlayerNameLabel = SKLabelNode(fontNamed: "Marker Felt Wide")
        currentPlayerNameLabel.zPosition = gameTable.zPosition + 5
        currentPlayerNameLabel.fontSize = 22
        currentPlayerNameLabel.fontColor = maroonFontColor
        currentPlayerNameLabel.alpha = 0.65
        currentPlayerNameLabel.text = "\(currentPlayer.name): "
        currentPlayerNameLabel.horizontalAlignmentMode = .right
        currentPlayerNameLabel.position = CGPoint(x: 0, y: (gameTable.frame.midY + (gameTable.size.height / 4)))

        currentPlayerScoreLabel = SKLabelNode(fontNamed: "Marker Felt Wide")
        currentPlayerScoreLabel.text = "\(score)"
        currentPlayerScoreLabel.zPosition = gameTable.zPosition + 5
        currentPlayerScoreLabel.fontSize = 22
        currentPlayerScoreLabel.fontColor = UIColor.black
        currentPlayerScoreLabel.alpha = 0.65
        currentPlayerScoreLabel.horizontalAlignmentMode = .left
        currentPlayerScoreLabel.position = CGPoint(x: 10, y: currentPlayerNameLabel.position.y)
            //CGPoint(x: currentPlayerNameLabel.position.x + (currentPlayerNameLabel.position.x + 11), y: (gameTable.frame.midY + (gameTable.size.height / 4)))

        gameTable.addChild(currentPlayerNameLabel)
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
        mainMenuLabel.zPosition = GameConstants.ZPositions.MenuLabel
        mainMenuLabel.position = CGPoint(x: 0, y: mainMenu.frame.maxY - (mainMenuLabel.fontSize + (mainMenuLabel.fontSize / 3)))

        newGameButtonLabel.text = "New Game"
        newGameButtonLabel.fontName = GameConstants.StringConstants.FontName
        newGameButtonLabel.fontSize = GameConstants.Sizes.ButtonLabelFont
        newGameButtonLabel.fontColor = maroonFontColor
        newGameButtonLabel.zPosition = GameConstants.ZPositions.ButtonLabel
        newGameButtonLabel.position = CGPoint(x: 65, y: -8)

        resumeButtonLabel.text = "Continue"
        resumeButtonLabel.fontName = GameConstants.StringConstants.FontName
        resumeButtonLabel.fontSize = GameConstants.Sizes.ButtonLabelFont
        resumeButtonLabel.fontColor = maroonFontColor
        resumeButtonLabel.zPosition = GameConstants.ZPositions.ButtonLabel
        resumeButtonLabel.position = CGPoint(x: 59, y: -8)

        settingsButtonLabel.text = "Settings"
        settingsButtonLabel.fontName = GameConstants.StringConstants.FontName
        settingsButtonLabel.fontSize = GameConstants.Sizes.ButtonLabelFont
        settingsButtonLabel.fontColor = maroonFontColor
        settingsButtonLabel.zPosition = GameConstants.ZPositions.ButtonLabel
        settingsButtonLabel.position = CGPoint(x: 58, y: -8)

        exitButtonLabel.text = "Exit Game"
        exitButtonLabel.fontName = GameConstants.StringConstants.FontName
        exitButtonLabel.fontSize = GameConstants.Sizes.ButtonLabelFont
        exitButtonLabel.fontColor = maroonFontColor
        exitButtonLabel.zPosition = GameConstants.ZPositions.ButtonLabel
        exitButtonLabel.position = CGPoint(x: 67, y: -8)
    }

    func setupSettingsMenuLabels() {
        settingsMenuLabel.text = "Settings Menu"
        settingsMenuLabel.fontName = GameConstants.StringConstants.FontName
        settingsMenuLabel.fontSize = GameConstants.Sizes.MainMenuFont
        settingsMenuLabel.fontColor = maroonFontColor
        settingsMenuLabel.zPosition = GameConstants.ZPositions.MenuLabel
        settingsMenuLabel.position = CGPoint(x: 0, y: settingsMenu.frame.maxY - (settingsMenuLabel.fontSize + (settingsMenuLabel.fontSize / 3)))

        soundButtonLabel.text = "Sound"
        soundButtonLabel.fontName = GameConstants.StringConstants.FontName
        soundButtonLabel.fontSize = GameConstants.Sizes.ButtonLabelFont
        soundButtonLabel.fontColor = maroonFontColor
        soundButtonLabel.zPosition = GameConstants.ZPositions.ButtonLabel
        soundButtonLabel.position = CGPoint(x: 65, y: -8)

        backButtonLabel.text = "Back"
        backButtonLabel.fontName = GameConstants.StringConstants.FontName
        backButtonLabel.fontSize = GameConstants.Sizes.ButtonLabelFont
        backButtonLabel.fontColor = maroonFontColor
        backButtonLabel.zPosition = GameConstants.ZPositions.ButtonLabel
        backButtonLabel.position = CGPoint(x: 59, y: -8)

        numPlayersLabel.text = "Number of Players: \(numPlayers)"
        numPlayersLabel.fontSize = 12
        numPlayersLabel.fontColor = maroonFontColor
        numPlayersLabel.horizontalAlignmentMode = .center
        numPlayersLabel.verticalAlignmentMode = .center
        numPlayersLabel.position = CGPoint(x: -17, y: -32)
        numPlayersLabel.zPosition = 50

        targetScoreLabel = SKLabelNode(fontNamed: "Marker Felt Wide")
        //targetScoreLabel.text = "Target Score:  \(targetScore)"
        targetScoreLabel.fontSize = 22
        targetScoreLabel.fontColor = maroonFontColor
        targetScoreLabel.horizontalAlignmentMode = .center
        targetScoreLabel.verticalAlignmentMode = .center
        targetScoreLabel.position = CGPoint(x: -17, y: -13)
        targetScoreLabel.zPosition = 50

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
