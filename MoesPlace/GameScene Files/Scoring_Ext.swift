//
//  Scoring_Ext.swift
//  MoesPlace
//
//  Created by Mark Davis on 5/3/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

extension GameScene {

    func setupScoringCombosArray() {
        scoringCombosArray = ["Straight":straight, "FullHouse":fullHouse, "ThreeOAK":threeOAK, "FourOAK":fourOAK, "FiveOAK":fiveOAK, "Singles":singles]
        if currentGame.numDice == 6 {
            scoringCombosArray["ThreePair"] = threePair
            scoringCombosArray["SixOAK"] = sixOAK
        }
    }

    func rollDice() {
        /*
        if previousRollScore == currentPlayer.currentRollScore {
            selectScoringDieMessage(on: scene!, title: "Select a Scoring Die", message: GameConstants.Messages.NoScoringDieSelected)
        }
        */
        currentScore = 0
        currentPlayer.hasScoringDice = false
        resetDiePhysics()
        if currentDiceArray.isEmpty {
            startNewRoll()
        }
        getDieSides()
        displayScore()
    }

    func getDieSides() {
        resetCounters()
        resetScoringCombos()
        dieFacesArray.removeAll()
        countDice(isComplete: handlerBlock)
        if currentPlayer.firstRoll {
            checkForStraight()
            //currentPlayer.firstRoll = false
        }
        //checkForFarkle()
        getScoringCombos(isComplete: handlerBlock)
    }

    func countDice(isComplete: (Bool) -> Void) {
        resetDieCount()
        rollDiceAction(isComplete: handlerBlock)
        var value = Int()
        for die in currentDiceArray {
            value = Int(arc4random_uniform(6)+1)
            switch value {
            case 1:
                dieFace1.countThisRoll += 1
                die.dieFace = dieFace1
            case 2:
                dieFace2.countThisRoll += 1
                die.dieFace = dieFace2
            case 3:
                dieFace3.countThisRoll += 1
                die.dieFace = dieFace3
            case 4:
                dieFace4.countThisRoll += 1
                die.dieFace = dieFace4
            case 5:
                dieFace5.countThisRoll += 1
                die.dieFace = dieFace5
            case 6:
                dieFace6.countThisRoll += 1
                die.dieFace = dieFace6
            default:
                break
            }
            dieFacesArray.append(die.dieFace!.faceValue)
        }
        isComplete(true)
    }

    func checkForStraight() {
        dieFacesArray = dieFacesArray.sorted()
        if dieFacesArray == [1,2,3,4,5] || dieFacesArray == [2,3,4,5,6] || dieFacesArray == [1,2,3,4,5,6] {
            for die in dieFacesArray {
                print("dieFacesArray: \(die)")
            }
            for die in currentDiceArray {
                print("currentDiceArray: \(die.dieFace!.faceValue)")
            }

            straight = true
            currentPlayer.hasScoringDice = true
            dieFacesArray.removeAll()
            scoreDice(key: "Straight", isComplete: handlerBlock)
        }
        dieFacesArray.removeAll()
    }

    func checkForFarkle() {
        var farkle = true
        currentDieValuesArray.removeAll()
        for die in currentDiceArray {
            currentDieValuesArray.append(die.dieFace!.faceValue)
        }
        currentDieValuesArray = currentDieValuesArray.sorted()
        if currentDieValuesArray == [1,2,3,4,5] {
            farkle = false
        } else if currentDieValuesArray == [2,3,4,5,6] {
            farkle = false
        } else if currentDieValuesArray == [1,2,3,4,5,6] {
            farkle = false
        }
        currentDieValuesArray.removeAll()

        for die in currentDiceArray {
            switch die.dieFace!.faceValue {
            case 1,5:
                farkle = false
            case 2,3,4,6:
                if die.dieFace!.countThisRoll >= 3 {
                    farkle = false
                }
            default:
                break
            }
        }

        if farkle {
            runFarkleAction(isComplete: handlerBlock)
        }
    }

    func getScoringCombos(isComplete: (Bool) -> Void) {
        for die in currentDiceArray where die.selected {
            let count = die.dieFace!.countThisRoll
            switch count {
            case 1:
                if die.dieFace!.faceValue == 1 || die.dieFace!.faceValue == 5 {
                    currentPlayer.hasScoringDice = true
                    singles = true
                    scoreDice(key: "Singles", isComplete: handlerBlock)
                }
            case 2:
                if die.dieFace!.faceValue == 1 || die.dieFace!.faceValue == 5 {
                    currentPlayer.hasScoringDice = true
                    singles = true
                    scoreDice(key: "Singles", isComplete: handlerBlock)
                }
                pairs += 1
            case 3:
                threeOAK = true
                if pairs == 1 {
                    fullHouse = true
                    threeOAK = false
                    pairs = 0
                    scoreDice(key: "FullHouse", isComplete: handlerBlock)
                } else {
                    scoreDice(key: "ThreeOAK", isComplete: handlerBlock)
                    die.dieFace!.countThisRoll = 0
                }
                currentPlayer.hasScoringDice = true
            case 4:
                fourOAK = true
                currentPlayer.hasScoringDice = true
                scoreDice(key: "FourOAK", isComplete: handlerBlock)
                die.dieFace!.countThisRoll = 0
            case 5:
                fiveOAK = true
                currentPlayer.hasScoringDice = true
                scoreDice(key: "FiveOAK", isComplete: handlerBlock)
                die.dieFace!.countThisRoll = 0
            case 6:
                sixOAK = true
                currentPlayer.hasScoringDice = true
                scoreDice(key: "SixOAK", isComplete: handlerBlock)
                die.dieFace!.countThisRoll = 0
            default:
                break
            }
        }
        if pairs == 3 {
            threePair = true
            pairs = 0
            currentPlayer.hasScoringDice = true
            scoreDice(key: "ThreePair", isComplete: handlerBlock)
        }

        currentDiceArray.removeAll(where: { $0.selected })
        isComplete(true)
    }

    func scoreDice(key: String, isComplete: (Bool) -> Void) {
        for combo in scoringCombosArray.keys where combo == key {
            switch combo {
            case "FullHouse":
                print("FullHouse found")
                currentScore = 1250
                positionDice()
                startNewRoll()
            case "Straight":
                print("Straight found")
                currentScore = 1500
                positionDice()
                startNewRoll()
            case "ThreePair":
                currentScore = 500
                pairs = 0
                positionDice()
                startNewRoll()
            case "ThreeOAK":
                currentScore = calcMultiDieScore(count: 3)
            case "FourOAK":
                currentScore = calcMultiDieScore(count: 4)
            case "FiveOAK":
                currentScore = calcMultiDieScore(count: 5)
            case "SixOAK":
                currentScore = calcMultiDieScore(count: 6)
            case "Singles":
                if currentPlayer.hasScoringDice {
                    currentScore = calcSingleDice()
                }
            default:
                break
            }
            scoreTally.append(currentScore)
        }
        displayScore()
        scoreTally.removeAll()
        resetScoringCombosArray()
        isComplete(true)
    }

    func displayScore() {
        currentPlayer.currentRollScore += currentScore
        currentRollScoreLabel.text = String(currentPlayer.currentRollScore)
        currentScore = 0
        previousRollScore = currentPlayer.currentRollScore
    }

    func moveSelectedDice(count: Int, isComplete: (Bool) -> Void) {
        print("count: \(count)")
        if count >= 3 {
            for die in currentDiceArray where die.dieFace!.countThisRoll == count {
                die.selected = true
                die.counted = true
                die.zRotation = 0
                die.physicsBody?.collisionBitMask = 2
                die.physicsBody?.isDynamic = false
                die.physicsBody?.allowsRotation = false
                let firstPlaceHolderPosition = getFirstPlaceHolderPosition()
                print("placeHolderPostion: \(firstPlaceHolderPosition)")
                die.position = firstPlaceHolderPosition
            }
            resetDiePhysics()
            currentDiceArray.removeAll(where: { $0.selected })
        }
        isComplete(true)
    }

    func getFirstPlaceHolderPosition() -> CGPoint {
        var firstPlaceHolderPosition = CGPoint()
        if placeHoldersArray.first != nil {
            firstPlaceHolderPosition = placeHoldersArray.first!.position
        } else {
            resetPlaceHoldersArray()
            firstPlaceHolderPosition = placeHoldersArray.first!.position
        }
        placeHoldersArray.removeFirst()
        return firstPlaceHolderPosition
    }

    func calcMultiDieScore(count: Int) -> Int {
        var result = 0
        for die in selectedDieArray where die.dieFace!.countThisRoll == count {
            if die.dieFace!.faceValue == 1 {
                result = (1000 * (count - 2))
            } else {
                result = ((die.dieFace!.faceValue * 100) * (count - 2))
            }
            die.counted = true
        }
        return result
    }

    func calcSingleDice() -> Int {
        var result = 0
        for die in currentDiceArray where die.dieFace!.countThisRoll < 3 && die.selected {
            if die.dieFace!.faceValue == 1 {
                result += 100
            } else if die.dieFace!.faceValue == 5 {
                result += 50
            }
            die.counted = true
        }
        return result
    }

    func runFarkleAction(isComplete: (Bool) -> Void) {
        let wait = SKAction.wait(forDuration: 0.25)
        let fadeOut = SKAction.fadeOut(withDuration: 0.25)
        let changeColorToRed = SKAction.run {
            self.logo.zPosition = GameConstants.ZPositions.Dice + 0.5
            self.logo.fontColor = UIColor.red
            self.logo2.zPosition = self.logo.zPosition
            self.logo2.fontColor = UIColor.red
        }
        let changeColorBack = SKAction.run {
            self.logo.zPosition = GameConstants.ZPositions.Logo
            self.logo.fontColor = GameConstants.Colors.LogoFont
            self.logo2.fontColor = GameConstants.Colors.LogoFont
            self.logo2.zPosition = GameConstants.ZPositions.Logo
        }

        let moveDie1 = SKAction.move(to: getFirstPlaceHolderPosition(), duration: 0.05)
        let moveDie2 = SKAction.move(to: getFirstPlaceHolderPosition(), duration: 0.05)
        let moveDie3 = SKAction.move(to: getFirstPlaceHolderPosition(), duration: 0.05)
        let moveDie4 = SKAction.move(to: getFirstPlaceHolderPosition(), duration: 0.05)
        let moveDie5 = SKAction.move(to: getFirstPlaceHolderPosition(), duration: 0.05)
        let moveDie6 = SKAction.move(to: getFirstPlaceHolderPosition(), duration: 0.05)

        let nextPlayer = SKAction.run {
            self.nextPlayer()
        }

        let rotateDice = SKAction.run {
            self.die1.zRotation = 0
            self.die2.zRotation = 0
            self.die3.zRotation = 0
            self.die4.zRotation = 0
            self.die5.zRotation = 0
            self.die6.zRotation = 0
            for die in self.currentDiceArray {
                die.physicsBody?.allowsRotation = false
            }
        }

        let moveDice1 = SKAction.run {
            for die in self.currentDiceArray {
                die.run(rotateDice)
            }
            self.die1.run(moveDie1)
            self.die2.run(moveDie2)
            self.die3.run(moveDie3)
            self.die4.run(moveDie4)
            self.die5.run(moveDie5)
        }

        let moveDice2 = SKAction.run {
            self.die1.run(moveDie1)
            self.die2.run(moveDie2)
            self.die3.run(moveDie3)
            self.die4.run(moveDie4)
            self.die5.run(moveDie5)
            self.die6.run(moveDie6)
        }

        let fadeIn = SKAction.fadeIn(withDuration: 0.25)
        let fadeTo = SKAction.fadeAlpha(to: 0.65, duration: 0.25)

        let seq1 = SKAction.sequence([wait, fadeOut, changeColorToRed, fadeIn, fadeOut, fadeIn, fadeOut, changeColorBack, fadeTo, wait, moveDice1, nextPlayer])

        let seq2 = SKAction.sequence([wait, fadeOut, changeColorToRed, fadeIn, fadeOut, fadeIn, fadeOut, changeColorBack, fadeTo, wait, moveDice2, nextPlayer])

        if currentGame.numDice == 5 {
            logo.run(seq1)
        } else {
            logo.run(seq2)
        }
        resetDice()
        resetPlaceHoldersArray()
        isComplete(true)
    }

    func resetScoringCombos() {
        for (key, _) in scoringCombosArray {
            scoringCombosArray[key] = false
        }
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

    func resetCounters() {
        pairs = 0
        for die in currentDiceArray {
            die.selected = false
            die.counted = false
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
}
