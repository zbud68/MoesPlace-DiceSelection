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

    func getPlaceHolders() {
        if let Die1PlaceHolder = gameTable.childNode(withName: "Die1PlaceHolder") as? SKSpriteNode {
            die1PlaceHolder = Die1PlaceHolder
        }

        if let Die2PlaceHolder = gameTable.childNode(withName: "Die2PlaceHolder") as? SKSpriteNode {
            die2PlaceHolder = Die2PlaceHolder
        }

        if let Die3PlaceHolder = gameTable.childNode(withName: "Die3PlaceHolder") as? SKSpriteNode {
            die3PlaceHolder = Die3PlaceHolder
        }

        if let Die4PlaceHolder = gameTable.childNode(withName: "Die4PlaceHolder") as? SKSpriteNode {
            die4PlaceHolder = Die4PlaceHolder
        }

        if let Die5PlaceHolder = gameTable.childNode(withName: "Die5PlaceHolder") as? SKSpriteNode {
            die5PlaceHolder = Die5PlaceHolder
        }

        if let Die6PlaceHolder = gameTable.childNode(withName: "Die6PlaceHolder") as? SKSpriteNode {
            die6PlaceHolder = Die6PlaceHolder
        }
        placeHoldersArray = [die1PlaceHolder, die2PlaceHolder, die3PlaceHolder, die4PlaceHolder, die5PlaceHolder]

        if currentGame.numDice == 6 {
            placeHoldersArray.append(die6PlaceHolder)
        }
        placeHoldersIndex = 0
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

        if currentGame.numDice == 6 {
            if let Die6 = gameTable.childNode(withName: "Die6") as? Die {
                die6 = Die6
            } else {
                print("die6 not found")
            }
        }
        die1.placeHolder = die1PlaceHolder
        die2.placeHolder = die2PlaceHolder
        die3.placeHolder = die3PlaceHolder
        die4.placeHolder = die4PlaceHolder
        die5.placeHolder = die5PlaceHolder
        die6.placeHolder = die6PlaceHolder
        
        die1.texture = GameConstants.Textures.Die1
        die2.texture = GameConstants.Textures.Die2
        die3.texture = GameConstants.Textures.Die3
        die4.texture = GameConstants.Textures.Die4
        die5.texture = GameConstants.Textures.Die5
        die6.texture = GameConstants.Textures.Die6

        die1.dieFace = dieFace1
        die2.dieFace = dieFace2
        die3.dieFace = dieFace3
        die4.dieFace = dieFace4
        die5.dieFace = dieFace5
        die6.dieFace = dieFace6

        diceArray = [die1, die2, die3, die4, die5]

        if currentGame.numDice == 6 {
            diceArray.append(die6)
        } else {
            die6.removeFromParent()
            die6PlaceHolder.removeFromParent()
        }
        currentDiceArray = diceArray
        positionDice()
    }

    func positionDice() {
        for die in currentDiceArray {
            die.physicsBody = nil
            die.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            die.zRotation = 0
            die.position = getFirstPlaceHolderPosition()

            /*
            switch die.name {
            case "Die1":
                die1.position = die1PlaceHolder.position
            case "Die2":
                die2.position = die2PlaceHolder.position
            case "Die3":
                die3.position = die3PlaceHolder.position
            case "Die4":
                die4.position = die4PlaceHolder.position
            case "Die5":
                die5.position = die5PlaceHolder.position
            case "Die6":
                die6.position = die6PlaceHolder.position
            default:
                break
            }*/
        }
        resetDiePhysics()
    }

    func rollDiceAction(isComplete: (Bool) -> Void) {
        for die in currentDiceArray {
            var rollAction: SKAction = SKAction()
            let Wait = SKAction.wait(forDuration: 0.15)

            if let RollAction = SKAction(named: "RollDice") {
                rollAction = RollAction
            }

            let MoveAction = SKAction.run {
                let randomX = CGFloat(arc4random_uniform(5) + 5)
                let randomY = CGFloat(arc4random_uniform(2) + 3)

                die.physicsBody?.applyImpulse(CGVector(dx: randomX, dy: randomY))
                die.physicsBody?.applyTorque(3)
            }
            let getDieSides = SKAction.run {
                self.setDieSides(die: die)
            }

            let Group = SKAction.group([rollAction, MoveAction])

            let Seq = SKAction.sequence([Group, Wait, getDieSides])

            die.position = CGPoint(x: 0, y: 0)
            die.run(Seq)
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
    }

    func returnDiceToHomePosition() {


        let moveDie1 = SKAction.move(to: die1PlaceHolder.position, duration: 0.25)
        let moveDie2 = SKAction.move(to: die2PlaceHolder.position, duration: 0.25)
        let moveDie3 = SKAction.move(to: die3PlaceHolder.position, duration: 0.25)
        let moveDie4 = SKAction.move(to: die4PlaceHolder.position, duration: 0.25)
        let moveDie5 = SKAction.move(to: die5PlaceHolder.position, duration: 0.25)
        let moveDie6 = SKAction.move(to: die6PlaceHolder.position, duration: 0.25)

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
                die.physicsBody?.collisionBitMask = 2
                die.physicsBody?.isDynamic = false
                die.run(rotateDice)
            }
            self.die1.run(moveDie1)
            self.die2.run(moveDie2)
            self.die3.run(moveDie3)
            self.die4.run(moveDie4)
            self.die5.run(moveDie5)
        }

        let moveDice2 = SKAction.run {
            for die in self.currentDiceArray {
                die.physicsBody?.collisionBitMask = 2
                die.physicsBody?.isDynamic = false
                die.run(rotateDice)
            }
            self.die1.run(moveDie1)
            self.die2.run(moveDie2)
            self.die3.run(moveDie3)
            self.die4.run(moveDie4)
            self.die5.run(moveDie5)
            self.die6.run(moveDie6)
        }

        let resetDice = SKAction.run {
            self.resetDieVariables()
        }

        let seq1 = SKAction.sequence([moveDice1, resetDice])

        let seq2 = SKAction.sequence([moveDice2, resetDice])

        for die in currentDiceArray {
            if currentGame.numDice == 5 {
                die.run(seq1)
            } else {
                die.run(seq2)
            }
        }
        resetDiePhysics()
    }

    func resetDice() {
        currentDiceArray = diceArray
        selectedDieArray.removeAll()
        for die in currentDiceArray {
            die.selected = false
            die.counted = false
        }
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
        placeHoldersArray.removeAll()
        placeHoldersArray = [die1PlaceHolder, die2PlaceHolder, die3PlaceHolder, die4PlaceHolder, die5PlaceHolder]
        if currentGame.numDice == 6 {
            placeHoldersArray.append(die6PlaceHolder)
        }
        placeHoldersIndex = 0
    }
}
