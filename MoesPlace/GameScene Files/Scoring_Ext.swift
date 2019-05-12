//
//  Scoring_Ext.swift
//  MoesPlace
//
//  Created by Mark Davis on 5/3/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

extension GameScene {

    func countDice() {
        resetDieVariables()
        resetScoringCombosArray()
        dieFacesArray.removeAll()

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
    }

    func getScore() {
        for die in currentDiceArray {
            if die.dieFace!.countThisRoll == 2 {
                pairs += 1
                die.dieFace!.countThisRoll = 0
            }
            if die.dieFace!.faceValue == 1 || die.dieFace!.faceValue == 5 {
                hasScoringDice = true
            }
        }
        for die in currentDiceArray where die.dieFace!.countThisRoll == 3 {
            if pairs == 1 {
                scoringCombosArray["FullHouse"] = true
                scoreDice(key: "FullHouse", isComplete: handlerBlock)
            }
            hasScoringDice = true
        }
        dieFacesArray = dieFacesArray.sorted()

        if dieFacesArray == [1,2,3,4,5] {
            scoringCombosArray["Straight"] = true
            hasScoringDice = true
            dieFacesArray.removeAll()
            scoreDice(key: "Straight", isComplete: handlerBlock)
        } else if dieFacesArray == [2,3,4,5,6] {
            scoringCombosArray["Straight"] = true
            hasScoringDice = true
            dieFacesArray.removeAll()
            scoreDice(key: "Straight", isComplete: handlerBlock)
        } else if dieFacesArray == [1,2,3,4,5,6] {
            scoringCombosArray["Straight"] = true
            hasScoringDice = true
            dieFacesArray.removeAll()
            scoreDice(key: "Straight", isComplete: handlerBlock)
        }
    }

    func checkForStraight() {
        dieFacesArray = dieFacesArray.sorted()
        if dieFacesArray == [1,2,3,4,5] || dieFacesArray == [2,3,4,5,6] || dieFacesArray == [1,2,3,4,5,6] {
            for die in dieFacesArray {
                print("dieFacesArray: \(die)")
            }
            scoringCombosArray["Straight"] = true
            hasScoringDice = true
            dieFacesArray.removeAll()
            scoreDice(key: "Straight", isComplete: handlerBlock)
        }
        dieFacesArray.removeAll()
    }

    func checkForFarkle() -> Bool {
        var result = true
        currentDieValuesArray.removeAll()
        for die in currentDiceArray {
            currentDieValuesArray.append(die.dieFace!.faceValue)
        }
        currentDieValuesArray = currentDieValuesArray.sorted()
        if currentDieValuesArray == [1,2,3,4,5] {
            result = false
        } else if currentDieValuesArray == [2,3,4,5,6] {
            result = false
        } else if currentDieValuesArray == [1,2,3,4,5,6] {
            result = false
        }
        currentDieValuesArray.removeAll()

        for die in currentDiceArray {
            switch die.dieFace!.faceValue {
            case 1,5:
                result = false
            case 2,3,4,6:
                if die.dieFace!.countThisRoll >= 3 {
                    result = false
                }
            default:
                break
            }
        }
        return result
    }

    func scoreDice(key: String, isComplete: (Bool) -> Void) {
        switch key {
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
            print("Three Pair Found")
            currentScore = 500
            pairs = 0
            positionDice()
            startNewRoll()
        case "ThreeOAK":
            print("Three of a kind found")
            currentScore = calcMultiDieScore(count: 3)
        case "FourOAK":
            currentScore = calcMultiDieScore(count: 4)
        case "FiveOAK":
            currentScore = calcMultiDieScore(count: 5)
        case "SixOAK":
            currentScore = calcMultiDieScore(count: 6)
        case "Singles":
            if hasScoringDice {
                currentScore = calcSingleDice()
            }
        default:
            break
        }
        resetScoringCombosArray()
        isComplete(true)
    }

    func displayScore() {
        currentRollScore += currentScore
        score = currentRollScore
        currentScore = 0
    }

    func moveSelectedDice(count: Int, isComplete: (Bool) -> Void) {
        if count >= 3 {
            for die in currentDiceArray where die.dieFace!.countThisRoll == count {
                die.zRotation = 0
                die.physicsBody = nil
                die.zPosition = GameConstants.ZPositions.GameTable + 5
                die.position = getFirstPlaceHolderPosiition()
            }
            resetDiePhysics()
        }
        isComplete(true)
    }

    //MARK: ********** Get First Place Holder Position **********
    func getFirstPlaceHolderPosiition() -> (CGPoint) {
        if firstRoll {
            setupPlaceHoldersArray()
        }
        var nextPosition = CGPoint()
        if currentIndexes.isEmpty {
            currentIndexes = placeHolderIndexArray
        }
        placeHolderIndex = currentIndexes[0]
        nextPosition = currentPlaceHoldersArray[placeHolderIndex].position
        currentIndexes.removeFirst()
        return (nextPosition)
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
            die.dieFace!.countThisRoll = 0
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
            die.dieFace!.countThisRoll = 0
        }
        return result
    }
}
