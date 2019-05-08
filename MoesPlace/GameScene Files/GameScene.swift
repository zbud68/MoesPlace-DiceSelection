//
//  GameScene.swift
//  Moe's Place
//
//  Created by Mark Davis on 1/29/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit
import UIKit

let gameVC: GameViewController = GameViewController()

// MARK: ********** Global Variables Section **********
enum DieSides {
    case One(Int)
    case Two(Int)
    case Three(Int)
    case Four(Int)
    case Five(Int)
    case Sixe(Int)
}

enum GameState {
    case NewGame, Rolling, InProgress, NewRound, GameOver
}

let handlerBlock: (Bool) -> Void = {
    if $0 {
        return
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {

    var scoreLabel: SKLabelNode!

    var score = 0 {
        didSet {
            scoreLabel.text = "\(currentPlayer.name):  \(score)"
        }
    }

    var targetScoreLabel: SKLabelNode!

    var targetScore = 10000 {
        didSet {
            targetScoreLabel.text = "  \(targetScore)"
        }
    }

    var numPlayersLabel: SKLabelNode!

    var numPlayers = 2 {
        didSet {
            numPlayersLabel.text = "  \(numPlayers)"
        }
    }


    // MARK: ********** Class Variables Section **********

    let physicsContactDelegate = self

    // MARK: ********** Game Variables **********

    var rolling = false
    var gameState = GameState.NewGame {
        willSet {
            switch newValue {
            case .NewGame:
                setupNewGame()
            case .Rolling:
                rolling = true
                rollDice()
            case .InProgress:
                print("game in progress")
            case .NewRound:
                startNewRound()
            case .GameOver:
                exit(0)
            }
        }
    }

    var currentGame: Game = Game()
    // MARK: ********** Player Variables **********

    var player1 = Player(name: "Player1", score: 0, currentRollScore: 0, hasScoringDice: false)
    var player2 = Player(name: "Player2", score: 0, currentRollScore: 0, hasScoringDice: false)
    var player3 = Player(name: "Player3", score: 0, currentRollScore: 0, hasScoringDice: false)
    var player4 = Player(name: "Player4", score: 0, currentRollScore: 0, hasScoringDice: false)

    var currentPlayer: Player!
    var currentPlayerID: Int = 0
    var playersArray: [Player]!
    var playerNameLabel: SKLabelNode = SKLabelNode()

    // MARK: ********** Dice Variables **********

    var die1: Die = Die()
    var die2: Die = Die()
    var die3: Die = Die()
    var die4: Die = Die()
    var die5: Die = Die()
    var die6: Die = Die()

    var diceArray: [Die] = [Die]()
    var currentDiceArray: [Die] = [Die]()
    var scoringDiceArray: [Die] = [Die]()

    var die1PlaceHolder = SKSpriteNode()
    var die2PlaceHolder = SKSpriteNode()
    var die3PlaceHolder = SKSpriteNode()
    var die4PlaceHolder = SKSpriteNode()
    var die5PlaceHolder = SKSpriteNode()
    var die6PlaceHolder = SKSpriteNode()

    var diePosition1: CGPoint = CGPoint()
    var diePosition2: CGPoint = CGPoint()
    var diePosition3: CGPoint = CGPoint()
    var diePosition4: CGPoint = CGPoint()
    var diePosition5: CGPoint = CGPoint()
    var diePosition6: CGPoint = CGPoint()

    var dieSelected: Bool = false

    // MARK: ********** DieFace Variables **********

    var dieFace1: DieFace = DieFace(faceValue: 1)
    var dieFace2: DieFace = DieFace(faceValue: 2)
    var dieFace3: DieFace = DieFace(faceValue: 3)
    var dieFace4: DieFace = DieFace(faceValue: 4)
    var dieFace5: DieFace = DieFace(faceValue: 5)
    var dieFace6: DieFace = DieFace(faceValue: 6)
    var dieFacesArray: [Int] = [Int]()

    var currentDieValuesArray: [Int] = [Int]()
    var selectedDieArray: [Die] = [Die]()
    var placeHoldersArray: [SKSpriteNode] = [SKSpriteNode]()
    var placeHoldersIndex = 0
    var dieFaceValue = Int()
    var dieFaceCount = Int()

    // MARK: ********** Scoring Variables **********

    var straight = false
    var fullHouse = false
    var threePair = false
    var threeOAK = false
    var fourOAK = false
    var fiveOAK = false
    var sixOAK = false
    var singles = false
    var pairs = 0

    var scoringCombosArray = [String:Bool]()
    var currentScore: Int = 0
    var currentRollScoreLabel: SKLabelNode = SKLabelNode()

    //var previousRollScore = 0

    // MARK: ********** User Interface Variables **********

    var menuArray = [SKSpriteNode]()
    var menuVisible = true

    let logo = SKLabelNode(text: "Farkle")
    let logo2 = SKLabelNode(text: "Plus")
    var mainMenuHolder: SKNode = SKNode()
    var settingsMenuHolder: SKNode = SKNode()
    var buttonWindowbuttonsHolder: SKNode = SKNode()
    var gameTableHolder: SKNode = SKNode()
    var gameTable = SKSpriteNode()
    var background = SKSpriteNode()
    var mainMenu: SKSpriteNode = SKSpriteNode()
    var settingsMenu: SKSpriteNode = SKSpriteNode()
    var helpMenu: SKSpriteNode = SKSpriteNode()
    var mainMenuLabel: SKLabelNode = SKLabelNode()
    var settingsMenuLabel: SKLabelNode = SKLabelNode()
    var soundButtonLabel: SKLabelNode = SKLabelNode()
    var backButtonLabel: SKLabelNode = SKLabelNode()
    var newGameButtonLabel: SKLabelNode = SKLabelNode()
    var settingsButtonLabel: SKLabelNode = SKLabelNode()
    var resumeButtonLabel: SKLabelNode = SKLabelNode()
    var exitButtonLabel: SKLabelNode = SKLabelNode()
    var rollDiceButtonLabel: SKLabelNode = SKLabelNode()
    var keepScoreButtonLabel: SKLabelNode = SKLabelNode()

    var newGameButton: SKSpriteNode = SKSpriteNode()
    var pauseButton: SKSpriteNode = SKSpriteNode()
    var exitButton: SKSpriteNode = SKSpriteNode()
    var soundButton: SKSpriteNode = SKSpriteNode()
    var infoButton: SKSpriteNode = SKSpriteNode()
    var menuButton: SKSpriteNode = SKSpriteNode()
    var resumeGameButton: SKSpriteNode = SKSpriteNode()
    var settingsButton: SKSpriteNode = SKSpriteNode()
    var homeButton: SKSpriteNode = SKSpriteNode()
    var backButton: SKSpriteNode = SKSpriteNode()
    var buttonTouched: String = String("")
    var rollDiceButton: SKSpriteNode = SKSpriteNode()
    var keepScoreButton: SKSpriteNode = SKSpriteNode()
    var fiveDiceButton: SKSpriteNode = SKSpriteNode()
    var sixDiceButton: SKSpriteNode = SKSpriteNode()
    var numPlayersPlusButton: SKSpriteNode = SKSpriteNode()
    var numPlayersMinusButton: SKSpriteNode = SKSpriteNode()
    var targetScorePlusButton: SKSpriteNode = SKSpriteNode()
    var targetScoreMinusButton: SKSpriteNode = SKSpriteNode()
    var matchScoreOnButton: SKSpriteNode = SKSpriteNode()
    var matchScoreOffButton: SKSpriteNode = SKSpriteNode()
    //var numPlayersLabel: SKLabelNode = SKLabelNode()

    var buttonWindow: SKSpriteNode = SKSpriteNode()
    var scoresWindow: SKSpriteNode = SKSpriteNode()

    var matchScoreButtonPosition: CGPoint = CGPoint()

    var mainMenuButtonsArray = [SKSpriteNode]()
    var settingsMenuButtonsArray = [SKSpriteNode]()
    var buttonWindowButtonsArray = [SKSpriteNode]()

    // MARK: ********** Touches Variables **********

    var touchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var currentTouch: UITouch = UITouch()
    var currentTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var buttonWindowTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var gameTableTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var mainMenuTouchLocation: CGPoint = CGPoint(x: 0, y: 0)
    var settingsMenuTouchLocation: CGPoint = CGPoint(x: 0, y: 0)

    let handlerBlock: (Bool) -> Void = {
        if $0 {
            var finished = false
            finished.toggle()
        }
    }

    var scoreTally = [Int]()

    // MARK: ********** didMove Section **********

    override func didMove(to view: SKView) {
        setupBackGround()
        setupGameTable()
        setupScoreLabel()
        setupLogo()
        setupButtonWindow()
        setupScoresWindow()
        setupMainMenu()
        setupSettingsMenu()
        setupSettingsMenuLabels()
        setupHelpMenu()
        menuArray = [mainMenu, settingsMenu, helpMenu]
        setupPlayers()
        showMenu(menu: mainMenu)
        getPlaceHolders()
        setupDice()
        setupScoringCombosArray()
    }

    // MARK: ********** Touches Section **********

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let positionInScene = touch.location(in: self)
            let touchedNode = atPoint(positionInScene)
            handleTouches(TouchedNode: touchedNode)
            touchLocation = touch.location(in: self)
        }
    }

    func handleTouches(TouchedNode: SKNode) {

        var dieName = ""
        let touchedNode = TouchedNode
        if let name = touchedNode.name {
            dieName = name
            switch name {
            case "NewGameButton":
                newGameButtonTouched()

            case "ResumeGameButton":
                resumeGameButtonTouched()

            case "SettingsButton":
                settingsButtonTouched()

            case "ExitButton":
                exitButtonTouched()

            case "InfoButton":
                infoButtonTouched()

            case "BackButton":
                backButtonTouched()

            case "SoundButton":
                soundButtonTouched()

            case "RollButton":
                if menuVisible {
                    return
                } else {
                    rollDice()
                }

            case "KeepButton":
                if menuVisible {
                    return
                } else {
                    keepScoreButtonTouched()
                }

            case "PauseButton":
                if menuVisible {
                    return
                } else {
                    pauseButtonTouched()
                }

            case "FiveDiceButton":
                currentGame.numDice = 5
                print("numDice: \(currentGame.numDice)")
                setupNewGame()

            case "SixDiceButton":
                currentGame.numDice = 6
                print("numDice: \(currentGame.numDice)")
                setupNewGame()

            case "MatchScoreOff":
                print("match score off touched")
                matchScoreOnButton.zPosition = matchScoreOffButton.zPosition
                matchScoreOffButton.position = CGPoint(x: 2000, y: 0)
                matchScoreOnButton.position = matchScoreButtonPosition
                currentGame.matchTargetScore = true
                setupNewGame()

            case "MatchScoreOn":
                print("match score on touched")
                matchScoreOffButton.zPosition = matchScoreOnButton.zPosition
                matchScoreOnButton.position = CGPoint(x: 2000, y: 0)
                matchScoreOffButton.position = matchScoreButtonPosition
                currentGame.matchTargetScore = false
                setupNewGame()

            case "TargetScorePlus":
               targetScore += 500
               currentGame.targetScore = targetScore
                setupNewGame()

            case "TargetScoreMinus":
                targetScore -= 500
                currentGame.targetScore = targetScore
                setupNewGame()

            case "NumPlayersPlus":
                numPlayers += 1
                currentGame.numPlayers = numPlayers
                setupNewGame()

            case "NumPlayersMinus":
                numPlayers -= 1
                currentGame.numPlayers = numPlayers
                setupNewGame()

            default:
                break
            }

            for die in currentDiceArray {
                if dieName == die.name {
                    handleTouchedDie(TouchedNode: touchedNode, touchedDie: die)
                }
            }
        }
    }

    func handleTouchedDie(TouchedNode: SKNode, touchedDie: Die) {
        dieSelected = true
        let count = touchedDie.dieFace!.countThisRoll
        if touchedDie.dieFace!.countThisRoll >= 3 {
            for die in currentDiceArray where die.dieFace!.countThisRoll == count {
                die.selected = true
                currentPlayer.hasScoringDice = true
                selectedDieArray.append(die)
                switch die.dieFace!.countThisRoll {
                case 3:
                    moveSelectedDice(count: count, isComplete: handlerBlock)
                    scoringCombosArray["ThreeOAK"] = true
                case 4:
                    moveSelectedDice(count: count, isComplete: handlerBlock)
                    scoringCombosArray["FourOAK"] = true
                case 5:
                    moveSelectedDice(count: count, isComplete: handlerBlock)
                    scoringCombosArray["FiveOAK"] = true

                case 6:
                    moveSelectedDice(count: count, isComplete: handlerBlock)
                    scoringCombosArray["SixOAK"] = true
                default:
                    break
                }
            }
        } else if touchedDie.dieFace!.faceValue == 1 || touchedDie.dieFace!.faceValue == 5 {
            scoringCombosArray["Singles"] = true
            touchedDie.physicsBody = nil
            touchedDie.zRotation = 0
            touchedDie.selected = true
            currentPlayer.hasScoringDice = true
            touchedDie.position = getFirstPlaceHolderPosition()
            selectedDieArray.append(touchedDie)
            resetDiePhysics()
        } else {
            selectScoringDieMessage(on: scene!, title: "Select a Scoring Die", message: GameConstants.Messages.NoScoringDieSelected)
        }
        for (key,value) in scoringCombosArray {
            if scoringCombosArray[key] == true {
                scoreDice(key: key, isComplete: handlerBlock)
                print(key)
            }
            print(key,value)
        }
        currentDiceArray.removeAll(where: { $0.selected })
    }

    func newGameButtonTouched() {
        if gameState == .InProgress {
            gameInProgressMessage(on: scene!, title: "Game In Progress", message: GameConstants.Messages.GameInProgress)
        } else {
            hideMenu(menu: mainMenu)
            setupNewGame()
        }
        print("numDice: \(currentGame.numDice), numPlayers: \(currentGame.numPlayers), matchScore: \(currentGame.matchTargetScore), targetScore: \(currentGame.targetScore)")
    }

    func setupNewGame() {
        gameState = .InProgress
        resetDice()
        resetCurrentScoreVariables()
        resetArrays()
        resetScoringCombosArray()
        resetDiePhysics()
        resetDieVariables()
        resetPlayerScoreVariables()
        currentPlayerID = 0
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
        hideMenu(menu: helpMenu)
        hideMenu(menu: settingsMenu)
        showMenu(menu: mainMenu)
    }

    func pauseButtonTouched() {
        showMenu(menu: mainMenu)
    }

    func keepScoreButtonTouched() {
        if currentScore == 0 {
            selectScoringDieMessage(on: scene!, title: "Select a Scoring Die", message: GameConstants.Messages.NoScoringDieSelected)
        } else {
            displayPlayerScore(playerName: currentPlayer.name)
            prepareForNextPlayer()
            nextPlayer()
        }
    }

    func displayPlayerScore(playerName: String) {
        switch playerName {
        case "Player 1":
            player1.score += currentPlayer.currentRollScore
            player1.scoreLabel.text = String(player1.score)
        case "Player 2":
            player2.score += currentPlayer.currentRollScore
            player2.scoreLabel.text = String(player2.score)
        case "Player 3":
            player3.score += currentPlayer.currentRollScore
            player3.scoreLabel.text = String(player3.score)
        case "Player 4":
            player4.score += currentPlayer.currentRollScore
            player4.scoreLabel.text = String(player4.score)
        default:
            break
        }
    }

    func prepareForNextPlayer() {
        currentDiceArray = diceArray
        for die in currentDiceArray {
            die.selected = false
        }
        resetPlaceHoldersArray()
        resetCurrentScoreVariables()
        resetDice()
        resetDiePhysics()
        resetDieVariables()
        resetArrays()
        positionDice()
    }

    func nextPlayer() {
        currentPlayer.currentRollScore = 0
        if currentPlayerID < playersArray.count - 1 {
            currentPlayerID += 1
        } else {
            currentPlayerID = 0
        }
        currentPlayer = playersArray[currentPlayerID]
        currentPlayer.firstRoll = true
        currentPlayer.hasScoringDice = false
        playerNameLabel.text = "\(currentPlayer.name):"
    }

    func startNewRoll() {
        resetPlaceHoldersArray()
        resetDice()
        resetDieVariables()
        currentPlayer.firstRoll = true
        currentPlayer.hasScoringDice = false
        rollDice()
    }

    func startNewRound() {
        currentPlayerID = 0
        resetDice()
        for player in playersArray {
            player.currentRollScore = 0
            player.firstRoll = true
        }
        currentGame.numRounds += 1
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

    func resetCurrentScoreVariables() {
        currentPlayer.currentRollScore = 0
        currentScore = 0
    }

    func resetPlayerScoreVariables() {
        for player in playersArray {
            player.score = 0
            player.scoreLabel.text = String(0)
            player.hasScoringDice = false
        }
        currentPlayer.firstRoll = true
    }

    func resetArrays() {
        currentDieValuesArray.removeAll()
    }

    // MARK: ********** Updates Section **********

    override func update(_ currentTime: TimeInterval) {
        displayScore()
    }
}
