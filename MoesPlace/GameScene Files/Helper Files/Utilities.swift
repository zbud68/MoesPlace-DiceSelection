//
//  Utilities.swift
//  MoesPlace
//
//  Created by Mark Davis on 5/1/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

extension GameScene {

    func removeDuplicateInts(values: [Int]) -> [Int] {
        // Convert array into a set to get unique values.
        let uniques = Set<Int>(values)
        // Convert set back into an Array of Ints.
        let result = Array<Int>(uniques)
        return result
    }

    func printArrayContents(arrayName: String) {
        switch arrayName {
        case "currentDiceArray":
            for die in currentDiceArray {
                print("dieValue: \(die.dieFace!.faceValue), dieCount: \(die.dieFace!.countThisRoll)")
            }
        case "selectedDieArray":
            for die in selectedDieArray {
                print("dieValue: \(die.dieFace!.faceValue), dieCount: \(die.dieFace!.countThisRoll)")
            }
        case "currentDieValuesArray":
            for currentDieValue in currentDieValuesArray {
                print("currentDieValue: \(currentDieValue)")
            }
        case "diceArray":
            for die in diceArray {
                print("dieValue: \(die.dieFace!.faceValue), dieCount: \(die.dieFace!.countThisRoll)")
            }
        case "scoringDiceArray":
            for die in scoringDiceArray {
                print("dieValue: \(die.dieFace!.faceValue), dieCount: \(die.dieFace!.countThisRoll)")
            }
        case "scoringCombosArray":
            for (key, value) in scoringCombosArray {
                print("Key: \(key), Value: \(value)")
            }
        default:
            break
        }
    }

}
