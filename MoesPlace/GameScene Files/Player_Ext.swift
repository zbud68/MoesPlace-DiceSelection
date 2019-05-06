//
//  Player_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/12/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit

extension GameScene {

    func setupPlayers() {
        player1.name = "Player 1"
        player2.name = "Player 2"
        player3.name = "Player 3"
        player4.name = "Player 4"

        player1.nameLabel.text = player1.name
        player2.nameLabel.text = player2.name
        player3.nameLabel.text = player3.name
        player4.nameLabel.text = player4.name
        
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
        currentPlayer = playersArray.first
        positionPlayerLabels()
    }
    

    func positionPlayerLabels() {
        for player in playersArray {
            player.scoreLabel.zPosition = 30
            player.scoreLabel.fontName = GameConstants.StringConstants.FontName
            player.scoreLabel.fontSize = GameConstants.Sizes.PlayerScoreLabelFont
            player.scoreLabel.fontColor = GameConstants.Colors.PlayerScoreLabelFont
            player.scoreLabel.zPosition = GameConstants.ZPositions.ScoreLabel
            
            switch player.name {
            case "Player 1":
                player1.scoreLabel.position = CGPoint(x: 0, y: ((scoresWindow.frame.maxY / 4) + (scoresWindow.size.height / 4)) - 10)
            case "Player 2":
                player2.scoreLabel.position = CGPoint(x: 0, y: (scoresWindow.size.height / 8) - (scoresWindow.frame.maxY / 4))
            case "Player 3":
                player3.scoreLabel.position = CGPoint(x: 0, y: (scoresWindow.size.height / 8) - (scoresWindow.frame.maxY) - 10)
            case "Player 4":
                player4.scoreLabel.position = CGPoint(x: 0, y: (scoresWindow.frame.minY) + (scoresWindow.size.height / 4) + 15)
            default:
                break
            }
            scoresWindow.addChild(player.scoreLabel)
        }
    }
}
