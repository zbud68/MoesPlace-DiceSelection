//
//  ResetMethods.swift
//  MoesPlace
//
//  Created by Mark Davis on 5/9/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

extension GameScene {
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

    func resetDice() {
        die1.texture = GameConstants.Textures.Die1
        die2.texture = GameConstants.Textures.Die2
        die3.texture = GameConstants.Textures.Die3
        die4.texture = GameConstants.Textures.Die4
        die5.texture = GameConstants.Textures.Die5
        if numDice == 6 {
            die6.texture = GameConstants.Textures.Die6
            die6.dieFace = dieFace6
        }

        die1.dieFace = dieFace1
        die2.dieFace = dieFace2
        die3.dieFace = dieFace3
        die4.dieFace = dieFace4
        die5.dieFace = dieFace5

        diceArray = [die1, die2, die3, die4, die5]

        if numDice == 6 {
            diceArray.append(die6)
        }
        for die in diceArray {
            die.zPosition = gameTable.zPosition + 5
        }
        currentDiceArray = diceArray
        positionDice()
        resetDiePhysics()
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
            die.zPosition = GameConstants.ZPositions.Dice
        }
    }

    func resetPlaceHoldersArray() {
        currentPlaceHoldersArray = placeHoldersArray
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
        for die in selectedDieArray {
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
