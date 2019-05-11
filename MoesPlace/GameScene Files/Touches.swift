//
//  Touches.swift
//  MoesPlace
//
//  Created by Mark Davis on 5/9/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
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
                numDice = 5
                currentGame.numDice = 5
                print("numDice: \(numDice)")
                removeSixthDie()
                //setupNewGame()

            case "SixDiceButton":
                numDice = 6
                currentGame.numDice = 6
                print("numDice: \(numDice)")
                addSixthDie()
                //setupNewGame()

            case "MatchScoreOff":
                print("match score off touched")
                matchScoreOnButton.zPosition = matchScoreOffButton.zPosition
                matchScoreOffButton.position = CGPoint(x: 2000, y: 0)
                matchScoreOnButton.position = matchScoreButtonPosition
                matchTargetScore = true
                //setupNewGame()

            case "MatchScoreOn":
                print("match score on touched")
                matchScoreOffButton.zPosition = matchScoreOnButton.zPosition
                matchScoreOnButton.position = CGPoint(x: 2000, y: 0)
                matchScoreOffButton.position = matchScoreButtonPosition
                matchTargetScore = false
                //setupNewGame()

            case "TargetScorePlus":
                targetScore += 500

            case "TargetScoreMinus":
                targetScore -= 500
                //setupNewGame()

            case "NumPlayersPlus":
                let maxNumPlayers = 4
                if numPlayers < maxNumPlayers {
                    numPlayers += 1
                } else {
                    print("Maximin Number of players is: \(maxNumPlayers)")
                }
                //setupNewGame()

            case "NumPlayersMinus":
                let minNumPlayers = 1
                if numPlayers > minNumPlayers {
                    numPlayers -= 1
                } else {
                    print("Minimun Number of players is: \(minNumPlayers)")
                }

                //setupNewGame()

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
        //touchedDie.selected = true
        let count = touchedDie.dieFace!.countThisRoll
        if count >= 3 {
            for die in currentDiceArray where die.dieFace!.countThisRoll == count {
                die.selected = true
                hasScoringDice = true
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
            dieSelected = true
            scoringCombosArray["Singles"] = true
            touchedDie.physicsBody = nil
            touchedDie.zRotation = 0
            touchedDie.selected = true
            hasScoringDice = true
            touchedDie.position = getFirstPlaceHolderPosiition()
            selectedDieArray.append(touchedDie)
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
        resetDiePhysics()
        currentDiceArray.removeAll(where: { $0.selected })
    }
}
