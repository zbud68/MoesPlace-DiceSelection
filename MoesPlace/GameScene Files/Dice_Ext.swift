//
//  Dice_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func setupDieFacesArray() {
        dieFacesArray = [dieFace1.faceValue, dieFace2.faceValue, dieFace3.faceValue, dieFace4.faceValue, dieFace5.faceValue, dieFace6.faceValue]
    }

    func setupPlaceHolders() {
        if let Die1PlaceHolder = gameTable.childNode(withName: "Die1PlaceHolder") as? SKSpriteNode {
            die1PlaceHolder = Die1PlaceHolder
        } else {
            print("die1PlayerHolder no found")
        }
        if let Die2PlaceHolder = gameTable.childNode(withName: "Die2PlaceHolder") as? SKSpriteNode {
            die2PlaceHolder = Die2PlaceHolder
        } else {
            print("die2PlayerHolder no found")
        }
        if let Die3PlaceHolder = gameTable.childNode(withName: "Die3PlaceHolder") as? SKSpriteNode {
            die3PlaceHolder = Die3PlaceHolder
        } else {
            print("die3PlayerHolder no found")
        }
        if let Die4PlaceHolder = gameTable.childNode(withName: "Die4PlaceHolder") as? SKSpriteNode {
            die4PlaceHolder = Die4PlaceHolder
        } else {
            print("die4PlayerHolder no found")
        }
        if let Die5PlaceHolder = gameTable.childNode(withName: "Die5PlaceHolder") as? SKSpriteNode {
            die5PlaceHolder = Die5PlaceHolder
        } else {
            print("die5PlayerHolder no found")
        }
        setupPlaceHoldersArray()
        setupPlaceHolderPositionsArray()
    }

    func setupPlaceHoldersArray() {
        placeHoldersArray.removeAll()
        if currentGame.numDice == 6 {
            if let Die6PlaceHolder = gameTable.childNode(withName: "Die6PlaceHolder") as? SKSpriteNode {
                die6PlaceHolder = Die6PlaceHolder
            } else {
                print("die6PlayerHolder not found")
            }
            die6PlaceHolder.position = CGPoint(x: -250, y: -120)
        }
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

    func setupPlaceHolderPositionsArray() {
        for placeHolder in currentPlaceHoldersArray {
            placeHolderPositionsArray.append(placeHolder.position)
        }
    }

    func setupDice() {
        if let Die1 = gameTable.childNode(withName: "Die1") as? Die {
            die1 = Die1
        } else {
            print("die1 not found")
        }
        if let Die2 = gameTable.childNode(withName: "Die2") as? Die {
            die2 = Die2
        } else {
            print("die2 not found")
        }
        if let Die3 = gameTable.childNode(withName: "Die3") as? Die {
            die3 = Die3
        } else {
            print("die3 not found")
        }
        if let Die4 = gameTable.childNode(withName: "Die4") as? Die {
            die4 = Die4
        } else {
            print("die4 not found")
        }
        if let Die5 = gameTable.childNode(withName: "Die5") as? Die {
            die5 = Die5
        } else {
            print("die5 not found")
        }

        if numDice == 6 {
            if let Die6 = gameTable.childNode(withName: "Die6") as? Die {
                die6 = Die6
            } else {
                print("die6 not found")
            }
        }

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

        diceArray = [die1, die2, die3, die4, die5]
        for die in diceArray {
            die.zPosition = gameTable.zPosition + 20
        }
        currentDiceArray = diceArray
        positionDice(isComplete: handlerBlock)
    }

    func positionDice(isComplete: (Bool) -> Void) {
        resetPlaceHoldersArray(isComplete: handlerBlock)
        for die in currentDiceArray {
            removeDiePhysics(die: die)
            die.position = getFirstPlaceHolderPosiition()
        }
        resetDiePhysics()
        isComplete(true)
    }

    func setDieSides(die: Die) {
        die.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        switch die.dieFace?.faceValue {
        case 1:
            die.texture = GameConstants.Textures.Die1
        case 2:
            die.texture = GameConstants.Textures.Die2
        case 3:
            die.texture = GameConstants.Textures.Die3
        case 4:
            die.texture = GameConstants.Textures.Die4
        case 5:
            die.texture = GameConstants.Textures.Die5
        case 6:
            die.texture = GameConstants.Textures.Die6
        default:
            break
        }
        resetDiePhysics()
    }

    func rollDice() {
        if currentDiceArray.isEmpty {
            startNewRoll()
        } else {
            resetDiePhysics()
            hasScoringDice = false
            if firstRoll {
                currentDiceArray = diceArray
                setupPlaceHoldersArray()
                resetDieVariables()
                resetDieCount()
                rollDiceAction()
                countDice()
                dieSelected = true
                firstRoll = false
            } else {
                if dieSelected {
                    resetDieVariables()
                    resetDieCount()
                    rollDiceAction()
                    countDice()
                } else {
                    selectScoringDieMessage(on: scene!, title: "Select a Scoring Die", message: GameConstants.Messages.NoScoringDieSelected)
                }
            }
            getScore()
            displayScore()
            if hasScoringDice {
                displayScore()
                firstRoll = false
                dieSelected = false
                hasScoringDice = false
            } else {
                for die in currentDiceArray {
                    print("die: \(die.dieFace!.faceValue)")
                }
                runFarkleAction(isComplete: handlerBlock)
                //nextPlayer()
            }
            currentDiceArray.removeAll(where: {$0.selected})
        }
    }

    func addSixthDie() {
        if let Die6 = gameTable.childNode(withName: "Die6") as? Die {
            die6 = Die6
            die5.selected = false
            die6.texture = GameConstants.Textures.Die6
            die6.dieFace = dieFace6
            die6PlaceHolder.position = GameConstants.Positions.Die6PlaceHolder
            die6.position = die6PlaceHolder.position
            diceArray.append(die6)
            currentDiceArray = diceArray
            placeHoldersArray.append(die6PlaceHolder)
            currentPlaceHoldersArray = placeHoldersArray
        } else {
            print("die6 not found")
        }
    }

    func removeSixthDie() {
        if numDice == 5 {
            die6.position = GameConstants.Positions.Die6OffScreen
            die6PlaceHolder.position = GameConstants.Positions.Die6OffScreen
            placeHolderIndex = 0
            placeHoldersArray.removeLast()
            diceArray.removeLast()
            currentDiceArray = diceArray
            positionDice(isComplete: handlerBlock)
            currentPlaceHoldersArray = placeHoldersArray
        } else {
            print("Only 5 dice available")
        }
        currentPlaceHoldersArray = placeHoldersArray
    }

    func removeDiePhysics(die: Die) {
        die.physicsBody = nil
        die.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        die.physicsBody?.affectedByGravity = false
        die.physicsBody?.isDynamic = false
        die.physicsBody?.allowsRotation = false
        die.physicsBody?.categoryBitMask = 0
        die.physicsBody?.contactTestBitMask = 0
        die.physicsBody?.collisionBitMask = 0
        die.physicsBody?.restitution = 0
        die.physicsBody?.linearDamping = 0
        die.physicsBody?.angularDamping = 0
    }
}
