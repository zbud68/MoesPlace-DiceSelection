//
//  GameConstants.swift
//  Moe's Place
//
//  Created by Mark Davis on 2/5/19.
//  Copyright © 2019 Mark Davis. All rights reserved.
//

import SpriteKit
import UIKit

struct GameConstants {

    struct StringConstants {
        static let Player1Name = "Player 1"
        static let Player2Name = "Player 2"
        static let Player3Name = "Player 3"
        static let Player4Name = "Player 4"

        static let Die1Name = "Die1"
        static let Die2Name = "Die2"
        static let Die3Name = "Die3"
        static let Die4Name = "Die4"
        static let Die5Name = "Die5"
        static let Die6Name = "Die6"
        
        static let BackGroundName = "BackGround"
        static let GameTableName = "GameTable"
        static let ButtonWindowName = "ButtonWindow"
        static let ScoresWindowName = "ScoresWindow"
        static let MainMenuName = "MainMenu"
        static let SettingsMenuName = "SettingsMenu"

        static let buttonWindowImageName = "WindowPopup1"
        static let ScoresWindowImageName = "WindowPopup2"
        static let GameTableImageName = "WindowPopup"
        static let MainMenuImageName = "MainMenu"
        static let SettingsMenuImageName = "SettingsMenu"
        static let HelpMenuImageName = "HelpMenu"
        static let BackGroundImageName = "Felt_Green"

        static let FontName = "Marker Felt Wide"
    }
    
    struct Textures {
        //static let DieTexture = SKTexture(imageNamed: "\(die.dieName)")
        static let Die1 = SKTexture(imageNamed: "Die1")
        static let Die2 = SKTexture(imageNamed: "Die2")
        static let Die3 = SKTexture(imageNamed: "Die3")
        static let Die4 = SKTexture(imageNamed: "Die4")
        static let Die5 = SKTexture(imageNamed: "Die5")
        static let Die6 = SKTexture(imageNamed: "Die6")

        static let MainMenu = SKTexture(imageNamed: "MainMenu")
        static let SettingsMenu = SKTexture(imageNamed: "SettingsMenu")
        static let GameTable = SKTexture(imageNamed: "WindowPopup")
        static let ButtonWindow = SKTexture(imageNamed: "WindowPopup1")
        static let ScoresWindow = SKTexture(imageNamed: "WindowPopup2")
        static let BackGround = SKTexture(imageNamed: "Felt_Green")
    }
    
    struct Sizes {
        static let Logo1Font = CGFloat(144)
        static let Logo2Font = CGFloat(34)
        static let PlayerNameLabelFont = CGFloat(25)
        static let PlayerScoreLabelFont = CGFloat(25)
        static let ScoresMenu = CGSize(width: 150, height: 330)
        static let ScoresMenuFont = CGFloat(34)
        static let MainMenuFont = CGFloat(34)
        static let ButtonLabelFont = CGFloat(18)
        static let Dice = CGSize(width: 48, height: 48)
    }
    
    struct Colors {
        static let LogoFont = UIColor.brown
        static let PlayerNameLabelFont = UIColor.darkText
        static let PlayerScoreLabelFont = UIColor.darkText
        static let ScoresMenuFont = UIColor.darkText
        static let MainMenuFont = UIColor.darkText
        static let ButtonLabelFont = UIColor.darkText
    }

    struct ZPositions {
        static let BackGround: CGFloat = 0
        static let GameTable: CGFloat = 10
        static let Window: CGFloat = 10
        static let Logo: CGFloat = 15
        static let Button: CGFloat = 20
        static let ButtonLabel: CGFloat = 20
        static let NameLabel: CGFloat = 20
        static let ScoreLabel:  CGFloat = 20
        static let Dice: CGFloat = 30
        static let Message: CGFloat = 80
        static let Menu: CGFloat = 60
        static let MenuLabel: CGFloat = 60
    }

    struct PhysicsCategory {
        static let Dice = UInt32(1)
        static let Frame = UInt32(2)
    }

    struct Messages {
        static let GameInProgress = "There is currently a game in progress. Press 'Continue' to abandon game in progress and return to main menu, or 'Cancel' and press 'Resume Game' from main menu to contiue the game in progress"
        static let NoGameInProgress = "There is no game in progress, select 'New Game' from the main menu to start a new game"
        static let Winner = "has won the game."
        static let GameOver = "Has finished the game.\n Remaining players have 1 final roll."
        static let Busted = "You must match the target score exactly to win"
        static let Farkle = "No scoring dice"
        static let Settings = "There is currently a game in progress, if you continue the current game will be aborted.  Press 'Continue' to abandon game in progress and continue to the Settings Menu, or 'Cancel' and press 'Resume Game' from main menu to contiue the game in progress"
        static let NoScoringDieSelected = "You must select a scoring sie to continue. Please select a 1, 5, or a scoring combination to keep rolling or select 'Keep Score' to end your turn."
    }
    
    struct Locations {
        static let MainMenu = CGPoint(x: 0, y: 0)
        static let SettingsMenu = CGPoint(x: 0, y: 0)
    }

    struct Positions {
        static let MainMenu = CGPoint(x: 500, y: 0)
        static let Die6OffScreen = CGPoint(x: -1170, y: -134)
        static let Die6PlaceHolder = CGPoint(x: -250, y: -118)
    }
    
}
