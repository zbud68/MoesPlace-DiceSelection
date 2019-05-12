//
//  ResetMethods.swift
//  MoesPlace
//
//  Created by Mark Davis on 5/9/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

extension GameScene {
    func resetGameSettings() {
        currentGame = Game(numPlayers: numPlayers, numDice: numDice, targetScore: targetScore, matchTargetScore: matchTargetScore, numRounds: 0)
        
        resetDice()
        resetDieFaces()
        resetPlaceHolders()
        resetPlayers()

        print("numPlayers: \(currentGame.numPlayers!), numDice: \(currentGame.numDice!), targetScore: \(currentGame.targetScore!), matchTargetScore: \(currentGame.matchTargetScore!), numRounds: \(currentGame.numRounds!)")
    }

    func resetPlaceHolders() {
        placeHoldersArray.removeAll()
        currentPlaceHoldersArray.removeAll()
        placeHolderIndexArray.removeAll()

        placeHoldersArray = [ die1PlaceHolder, die2PlaceHolder, die3PlaceHolder, die4PlaceHolder, die5PlaceHolder]
        if currentGame.numDice == 6 {
            placeHoldersArray.append(die6PlaceHolder)
        }
        for (index, _) in placeHoldersArray.enumerated() {
            placeHolderIndexArray.append(index)
        }
        currentPlaceHoldersArray = placeHoldersArray
        placeHolderIndex = 0
    }

    func resetPlayers() {
        playersArray.removeAll()
        switch currentGame.numPlayers {
        case 1:
            playersArray = [player1]
        case 2:
            playersArray = [player1, player2]
        case 3:
            playersArray = [player1, player2, player3]
        case 4:
            playersArray = [player1, player2, player3, player4]
        default:
        break
        }
    }

    func resetDieFaces() {
         die1.texture = GameConstants.Textures.Die1
         die2.texture = GameConstants.Textures.Die2
         die3.texture = GameConstants.Textures.Die3
         die4.texture = GameConstants.Textures.Die4
         die5.texture = GameConstants.Textures.Die5

         die1.dieFace = dieFace1
         die2.dieFace = dieFace2
         die3.dieFace = dieFace3
         die4.dieFace = dieFace4
         die5.dieFace = dieFace5

         if currentGame.numDice == 6 {
         diceArray.append(die6)
         die6.texture = GameConstants.Textures.Die6
         die6.dieFace = dieFace6
         }
    }

    func resetDice() {
        diceArray.removeAll()
        currentDiceArray.removeAll()

        diceArray = [die1, die2, die3, die4, die5]

        for die in diceArray {
            die.zPosition = gameTable.zPosition + 5
        }
        currentDiceArray = diceArray
        resetDiePhysics()
        positionDice()
    }

    func resetForNextPlayer() {
        currentDiceArray = diceArray
        resetPlaceHoldersArray()
        resetCurrentScoreVariables()
        resetDice()
        resetDieVariables()
        resetArrays()
        positionDice()
        firstRoll = true
        hasScoringDice = false
        dieSelected = false
    }

    func resetCurrentScoreVariables() {
        currentRollScore = 0
        currentScore = 0
    }

    func resetPlayerScoreVariables() {
        for player in playersArray {
            currentPlayer = player
            currentPlayer.score = 0
            currentPlayer.scoreLabel.text = String(0)
        }
        hasScoringDice = false
        firstRoll = true
    }

    func resetArrays() {
        currentDieValuesArray.removeAll()
        selectedDieArray.removeAll()
    }

    func resetDiePhysics() {
        for die in currentDiceArray {
            die.physicsBody = SKPhysicsBody(texture: die.texture!, size: die.size)
            die.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            die.physicsBody?.affectedByGravity = false
            die.physicsBody?.isDynamic = true
            die.physicsBody?.allowsRotation = true
            die.physicsBody?.categoryBitMask = 1
            die.physicsBody?.contactTestBitMask = 1
            die.physicsBody?.collisionBitMask = 1
            die.physicsBody?.restitution = 0.5
            die.physicsBody?.linearDamping = 4
            die.physicsBody?.angularDamping = 5
        }
    }

    func resetPlaceHoldersArray() {
        placeHoldersArray.removeAll()
        placeHoldersArray = [die1PlaceHolder, die2PlaceHolder, die3PlaceHolder, die4PlaceHolder, die5PlaceHolder]
        if numDice == 6 {
            placeHoldersArray.append(die6PlaceHolder)
        }
        placeHolderIndexArray.removeAll()
        for (index, _) in placeHoldersArray.enumerated() {
            placeHolderIndexArray.append(index)
        }
        currentPlaceHoldersArray = placeHoldersArray
        currentIndexes = placeHolderIndexArray
        placeHolderIndex = 0
    }

    func resetScoringCombosArray() {
        for (key,_) in scoringCombosArray {
            scoringCombosArray[key] = false
        }
    }

    func resetDieCount() {
        for die in currentDiceArray {
            die.dieFace?.countThisRoll = 0
        }
        for die in selectedDieArray {
            die.dieFace?.countThisRoll = 0
        }
    }

    func resetDieVariables() {
        for die in currentDiceArray {
            die.selected = false
            die.counted = false
        }
    }

    func resetCurrentRollVariables() {
        hasScoringDice = false
        currentRollScore = 0
        firstRoll = false
    }
}
