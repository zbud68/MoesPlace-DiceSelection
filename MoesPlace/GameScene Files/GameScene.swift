//
//  GameScene.swift
//  Moe's Place
//
//  Created by Mark Davis on 1/29/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit
import UIKit

//let gameVC: GameViewController = GameViewController()

// MARK: ********** Global Variables Section **********
enum GameState {
    case NewGame, Rolling, InProgress, NewRound, GameOver
}

let handlerBlock: (Bool) -> Void = {
    if $0 {
        return
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var currentPlayerNameLabel: SKLabelNode!
    var currentPlayerScoreLabel: SKLabelNode!
    var currentPlayerName = String() {

        didSet {
            currentPlayerNameLabel = SKLabelNode(fontNamed: "Marker Felt Wide")
            currentPlayerNameLabel.text = currentPlayerName
        }
    }

    var currentPlayerscoreLabel = SKLabelNode(fontNamed: "Marker Felt Wide")
    var score = 0 {
        didSet {
            currentPlayerScoreLabel = SKLabelNode(fontNamed: "Marker Felt Wide")
            currentPlayerScoreLabel.text = "\(score)"
        }
    }

    var numPlayersLabel = SKLabelNode(fontNamed: "Marker Felt Wide")
    var currentNumPlayers = Int()
    var numPlayers = 2 {
        didSet {
            currentNumPlayers = numPlayers
            numPlayersLabel = SKLabelNode(fontNamed: "Marker Felt Wide")
            numPlayersLabel.text = "Number of Players: \(numPlayers)"
            print("numPlayers: \(numPlayers), currentNumPlayers: \(currentNumPlayers)")

        }
    }

    var numDiceLabel: SKLabelNode!
    var numDice = 5 {
        didSet {
            numDiceLabel = SKLabelNode(fontNamed: "Marker Felt Wide")
            numDiceLabel.text = "Number of Dice:  \(numDice)"
        }
    }

    var targetScoreLabel: SKLabelNode!
    var targetScore = 10000 {
        didSet {
            targetScoreLabel = SKLabelNode(fontNamed: "Marker Felt Wide")
            targetScoreLabel.text = "Target Score: \(targetScore)"
        }
    }

    var matchTargetScoreSwitch: Bool!
    var matchTargetScore = true {
        didSet {
            matchTargetScoreSwitch = true
        }
    }

    // MARK: ********** Class Variables Section **********
    let physicsContactDelegate = self

    // MARK: ********** Game Variables **********
    var currentGame: Game!

    var rolling = false
    var gameState = GameState.NewGame {
        willSet {
            switch newValue {
            case .NewGame:
                print("New Game Started")
            case .Rolling:
                print("Current Player Rolling the Dice")
                rolling = true
                rollDice()
            case .InProgress:
                print("Game in Progress")
            case .NewRound:
                print("Starting a New Round")
                startNewRound()
            case .GameOver:
                print("Game Over")
                gameOverMessage(on: scene!, title: "Game Over", message: "\(currentPlayer.name) Is The Winner!!!\nPress Okay to Exit")
            }
        }
    }

    // MARK: ********** Player Variables **********\
    var currentPlayer: Player!

    var player1 = Player(name: "Player 1", score: 0, nameLabel: SKLabelNode(fontNamed: "Marker Felt Wide"))
    var player2 = Player(name: "Player 2", score: 0, nameLabel: SKLabelNode(fontNamed: "Marker Felt Wide"))
    var player3 = Player(name: "Player 3", score: 0, nameLabel: SKLabelNode(fontNamed: "Marker Felt Wide"))
    var player4 = Player(name: "Player 4", score: 0, nameLabel: SKLabelNode(fontNamed: "Marker Felt Wide"))

    let maxNumPlayers = 4
    var currentPlayerID: Int = 0
    var playersArray: [Player]!
    var playerNameLabel: SKLabelNode = SKLabelNode(fontNamed: "Marker Felt Wide")

    // MARK: ********** Dice Variables **********
    let maxNumDice = 6
    let minNumDice = 5

    var die1: Die = Die()
    var die2: Die = Die()
    var die3: Die = Die()
    var die4: Die = Die()
    var die5: Die = Die()
    var die6: Die = Die()

    var diceArray: [Die] = [Die]()
    var currentDiceArray: [Die] = [Die]()

    var die1PlaceHolder = SKSpriteNode()
    var die2PlaceHolder = SKSpriteNode()
    var die3PlaceHolder = SKSpriteNode()
    var die4PlaceHolder = SKSpriteNode()
    var die5PlaceHolder = SKSpriteNode()
    var die6PlaceHolder = SKSpriteNode()

    var placeHoldersArray: [SKSpriteNode] = [SKSpriteNode]()
    var currentPlaceHoldersArray: [SKSpriteNode] = [SKSpriteNode]()
    var placeHolderIndexArray: [Int] = [Int]()
    var currentIndexes: [Int] = [Int]()
    var placeHolderIndex = 0

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
    var dieFaceValue = Int()
    var dieFaceCount = Int()

    // MARK: ********** Scoring Variables **********
    let minTargetScore = 1000
    let maxTargetScore = 50000

    var currentScore: Int = 0
    var currentRollScore: Int = 0
    var matchTargetScoreOnButton: SKSpriteNode!
    var matchTargetScoreOffButton: SKSpriteNode!

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
    var currentRollScoreLabel: SKLabelNode = SKLabelNode()

    // MARK: ********** User Interface Variables **********
    var menuArray = [SKSpriteNode]()
    var menuVisible = true

    let maroonFontColor = UIColor(red: 0.502, green: 0, blue: 0, alpha: 1)

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
    var hasScoringDice = false
    var firstRoll = true
    var currentDie = Die()
    var numRounds: Int = 0

    // MARK: ********** didMove Section **********
    override func didMove(to view: SKView) {
        getSettings()
        gameSetup(isComplete: handlerBlock)
    }

    func getSettings() {
        let numPlayers = 3
        let numDice = 6
        let targetScore = 1000
        let matchTargetScore = false
        let targetScoreLabel = SKLabelNode(fontNamed: "Marker Felt Wide")
        targetScoreLabel.text = "Target Score: \(targetScore)"

        currentGame = Game(numPlayers: numPlayers, numDice: numDice, targetScore: targetScore, matchTargetScore: matchTargetScore, numRounds: numRounds)
        currentPlayer = Player(name: "Player 1", score: 0, nameLabel: SKLabelNode(fontNamed: "Marker Felt Wide"))
    }

    func gameSetup(isComplete: (Bool) -> Void) {
        setupBackGround()
        setupGameTable()
        setupPlayers()
        setupPlaceHolders()
        setupDice()
        setupButtonWindow()
        setupScoresWindow()
        setupLogo()
        setupMainMenu()
        setupSettingsMenu()
        setupHelpMenu()
        setupSettingsMenuLabels()
        setupGameArrays()
        showMenu(menu: mainMenu)
        setupScoreLabel()

        isComplete(true)
    }

    func setupGameArrays() {
        scoringCombosArray = ["Straight":false, "FullHouse":false, "ThreeOAK":false, "FourOAK":false, "FiveOAK":false, "Singles":false]
        if numDice == 6 {
            scoringCombosArray["ThreePair"] = false
            scoringCombosArray["SixOAK"] = false
        }
        menuArray = [mainMenu, settingsMenu, helpMenu]
    }

    func prepareForNextPlayer() {
        currentDiceArray = diceArray
        for die in currentDiceArray {
            die.selected = false
        }
        resetPlaceHoldersArray()
        resetCurrentScoreVariables()
        resetDice()
        resetDieVariables()
        resetArrays()
        positionDice()
    }

    func nextPlayer() {
        print("next Player")
        currentRollScore = 0
        if currentPlayerID < playersArray.count - 1 {
            currentPlayerID += 1
        } else {
            currentPlayerID = 0
        }
        currentPlayer = playersArray[currentPlayerID]
        firstRoll = true
        hasScoringDice = false
        playerNameLabel.text = "\(currentPlayer!.name):"
    }

    func startNewRoll() {
        print("starting new roll")
        resetPlaceHoldersArray()
        resetDice()
        resetDieVariables()
        firstRoll = true
        hasScoringDice = false
        rollDice()
    }

    func startNewRound() {
        //currentPlayerID = 0
        resetDice()
        resetCurrentRollVariables()
        currentGame.numRounds += 1
        firstRoll = true
    }

   // MARK: ********** Updates Section **********

    override func update(_ currentTime: TimeInterval) {
        displayScore()
    }
}
