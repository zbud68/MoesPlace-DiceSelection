//
//  Actions.swift
//  MoesPlace
//
//  Created by Mark Davis on 5/9/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
    func rollDiceAction() {
        for die in currentDiceArray {
            var rollAction: SKAction = SKAction()
            let Wait = SKAction.wait(forDuration: 0.15)

            if let RollAction = SKAction(named: "RollDice") {
                rollAction = RollAction
            }

            let MoveAction = SKAction.run {
                die.position = CGPoint(x: 0, y: 0)

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

            resetDiePhysics()
            die.run(Seq)
        }
    }

    func runFarkleAction(isComplete: (Bool) -> Void) {
        let wait = SKAction.wait(forDuration: 1)
        let fadeOut = SKAction.fadeOut(withDuration: 0.20)
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

        let moveDie1 = SKAction.move(to: getFirstPlaceHolderPosiition(), duration: 0.1)
        let moveDie2 = SKAction.move(to: getFirstPlaceHolderPosiition(), duration: 0.1)
        let moveDie3 = SKAction.move(to: getFirstPlaceHolderPosiition(), duration: 0.1)
        let moveDie4 = SKAction.move(to: getFirstPlaceHolderPosiition(), duration: 0.1)
        let moveDie5 = SKAction.move(to: getFirstPlaceHolderPosiition(), duration: 0.1)
        let moveDie6 = SKAction.move(to: getFirstPlaceHolderPosiition(), duration: 0.1)

        let farkleMessage = SKAction.run {
            self.farkleMessage()
        }

        let resetDiceFaces = SKAction.run {
            self.resetDieFaces()
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

        let fadeIn = SKAction.fadeIn(withDuration: 0.20)
        let fadeTo = SKAction.fadeAlpha(to: 0.65, duration: 0.20)

        let seq1 = SKAction.sequence([wait, fadeOut, changeColorToRed, fadeIn, fadeOut, fadeIn, fadeOut, fadeIn, fadeOut, changeColorBack, fadeTo, wait, moveDice1, farkleMessage, resetDiceFaces])

        let seq2 = SKAction.sequence([wait, fadeOut, changeColorToRed, fadeIn, fadeOut, fadeIn, fadeOut, fadeIn, fadeOut, changeColorBack, fadeTo, wait, moveDice2, farkleMessage, resetDiceFaces])

        if numDice == 5 {
            logo.run(seq1)
        } else {
            logo.run(seq2)
        }
        currentDiceArray = diceArray
        for die in currentDiceArray {
            die.selected = false
            die.counted = false
        }
        isComplete(true)
    }
}
