//
//  GameTable_Ext.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/11/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//
import SpriteKit

extension GameScene {
        
    func setupGameTable() {
        if let GameTable = background.childNode(withName: "GameTable") as? SKSpriteNode {
            gameTable = GameTable
        } else {
            print("game table not found")
        }
    }

    func setupLogo() {
        
        logo.fontName = GameConstants.StringConstants.FontName
        logo.fontColor = GameConstants.Colors.LogoFont
        logo.fontSize = GameConstants.Sizes.Logo1Font
        logo.alpha = 0.65
        logo.position = CGPoint(x: 0, y: -50)
        logo.zPosition = GameConstants.ZPositions.Logo
        
        logo2.fontName = GameConstants.StringConstants.FontName
        logo2.fontColor = GameConstants.Colors.LogoFont
        logo2.fontSize = GameConstants.Sizes.Logo2Font
        logo2.alpha = 0.65
        logo2.zRotation = 75
        
        logo2.zPosition = GameConstants.ZPositions.Logo
        logo2.position = CGPoint(x: -185, y: -25)
        gameTable.addChild(logo)
        logo.addChild(logo2)
    }
    
    func setupCurrentRollScoreLabel() {
        playerNameLabel.text = "\(currentPlayer.name):"
        playerNameLabel.fontName = GameConstants.StringConstants.FontName
        playerNameLabel.fontColor = GameConstants.Colors.LogoFont
        playerNameLabel.fontSize = GameConstants.Sizes.PlayerNameLabelFont
        playerNameLabel.position = CGPoint(x: (gameTable.frame.minX) + ((gameTable.size.width) / 3), y: (gameTable.frame.maxY) / 2)
        playerNameLabel.zPosition = GameConstants.ZPositions.NameLabel
        playerNameLabel.alpha = 0.65
        
        //currentRollScoreLabel.text = String(currentPlayer.currentRollScore)
        currentRollScoreLabel.fontName = GameConstants.StringConstants.FontName
        currentRollScoreLabel.fontColor = GameConstants.Colors.LogoFont
        currentRollScoreLabel.fontSize = GameConstants.Sizes.PlayerScoreLabelFont
        currentRollScoreLabel.position = CGPoint(x: playerNameLabel.position.x + 110, y: playerNameLabel.position.y)
        currentRollScoreLabel.zPosition = GameConstants.ZPositions.ScoreLabel
        currentRollScoreLabel.alpha = 0.65
        
        gameTable.addChild(currentRollScoreLabel)
        gameTable.addChild(playerNameLabel)
    }

    
}
