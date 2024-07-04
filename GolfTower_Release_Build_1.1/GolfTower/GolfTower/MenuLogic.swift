//
//  MenuLogic.swift
//  GolfTower
//
//  Created by Lane, Arthur on 11/10/23.
//

import Foundation
import SpriteKit
import GameplayKit

extension GameScene {
    func makeMenus(){
        setupPauseButton()
    }

    func renderWinMenu() {
        isGameWon = true
        setupWinMenu()
        winMenu.isHidden = false
    }

    func renderLoseMenu() {
        print("render loss menu")
        isGameLost = true
        setupLoseMenu()
        loseMenu.isHidden = false
    }

    func closeLoseMenu(){
        guard let loseMenu = loseMenu else {return}
        loseMenu.isHidden = true
        loseMenu.removeAllChildren()
        loseMenu.removeFromParent()
    }

    func closeWinMenu(){
        winMenu.isHidden = true
        winMenu.removeAllChildren()
        winMenu.removeFromParent()
    }
    
    func handlePauseButtonTap() {
        setupInfoBox()
        setupLevelSelectMenu()
        isGamePaused = true
        pauseMenu.isHidden = false
    }
    
    func renderLevelSelectMenu(){
        isGamePaused = true
        handlePauseButtonTap()
        pauseMenu.isHidden = true
        levelSelectMenu.isHidden = false
    }

    func handlePauseMenuClose(){
        pauseMenu.removeAllChildren()
        pauseMenu.removeFromParent()
        levelSelectMenu.removeAllChildren()
        levelSelectMenu.removeFromParent()
        isGamePaused = false
    }
    
    
    private func setupPauseButton() {
        pauseButton = SKSpriteNode(imageNamed: "PauseIcon") // Replace with image
        pauseButton.size = CGSize(width: 80, height: 80)
        pauseButton.position = CGPoint(x: 200, y: 570)
        pauseButton.zPosition = 2
        
        addChild(pauseButton)
    }
    
    //pause menu box
    private func setupInfoBox() {
        pauseMenu = SKNode()
        pauseMenu.isHidden = true
        addChild(pauseMenu)
        
        // Create a background for the information box
        let boxBackground = createBackground(color: SKColor.white,
                                             size: CGSize(width: 350, height: 650),
                                             cornerRadius: 20,
                                             outlineWidth: 3,
                                             outlineColor: SKColor.clear)
        boxBackground.zPosition = 2
        pauseMenu.addChild(boxBackground)
        let titleLabel = SKLabelNode(text: NSLocalizedString("Paused", comment: "")) // Replace with the actual level number
        titleLabel.fontName = "Arial Bold"
        titleLabel.fontSize = 45
        titleLabel.fontColor = SKColor.black
        titleLabel.position = CGPoint(x: 0, y: 200)
        titleLabel.zPosition = 4
        pauseMenu.addChild(titleLabel)
        
        
        let levelLabel = SKLabelNode(text: String(format: NSLocalizedString("Level", comment: ""), loadedLevel+1))

        levelLabel.fontName = "Arial"
        levelLabel.fontSize = 25
        levelLabel.fontColor = SKColor.black
        levelLabel.position = CGPoint(x: 0, y: 150)
        levelLabel.zPosition = 4
        pauseMenu.addChild(levelLabel)
        
        let strokeLabel = SKLabelNode(text: String(format: NSLocalizedString("Strokes", comment: ""), strokeCount))
        strokeLabel.fontName = "Arial"
        strokeLabel.fontSize = 25
        strokeLabel.fontColor = SKColor.black
        strokeLabel.position = CGPoint(x: 0, y: 110)
        strokeLabel.zPosition = 4
        pauseMenu.addChild(strokeLabel)
        
        let resetButtonBackground = createBackground(
            color: SKColor(red: 203/255, green: 92/255, blue: 92/255, alpha: 1),
            size: CGSize(width: 250, height: 80),
            cornerRadius: 100,
            outlineWidth: 0,
            outlineColor: SKColor.clear)
        resetButtonBackground.name = "resetButtonBackground"
        resetButtonBackground.position = CGPoint(x: 0, y: -138)
        resetButtonBackground.zPosition = 3
        pauseMenu.addChild(resetButtonBackground)
        
        let resetButton = SKLabelNode(text: NSLocalizedString("Restart", comment: ""))
        resetButton.fontName = "Arial Bold"
        resetButton.position = CGPoint(x: 0, y: -150)
        resetButton.name = "resetButton"
        resetButton.zPosition = 4
        pauseMenu.addChild(resetButton)
        
        
        let levelSelecetionButtonBackground = createBackground(
            color: SKColor(red: 105/255, green: 129/255, blue: 214/255, alpha: 1),
            size: CGSize(width: 250, height: 80),
            cornerRadius: 100,
            outlineWidth: 0,
            outlineColor: SKColor.clear)
        levelSelecetionButtonBackground.name = "levelSelecetionButtonBackground"
        levelSelecetionButtonBackground.position = CGPoint(x: 0, y: -238)
        levelSelecetionButtonBackground.zPosition = 3
        pauseMenu.addChild(levelSelecetionButtonBackground)
        
        let levelSelectButton = SKLabelNode(text: NSLocalizedString("Level Select", comment: ""))
        levelSelectButton.fontName = "Arial Bold"
        levelSelectButton.position = CGPoint(x: 0, y: -250)
        levelSelectButton.name = "levelSelectButton"
        levelSelectButton.zPosition = 4
        pauseMenu.addChild(levelSelectButton)
    }
    
    //level select menu
    private func setupLevelSelectMenu() {
        levelSelectMenu = SKNode()
        levelSelectMenu.isHidden = true
        addChild(levelSelectMenu)
        
        // Create a background for the level select menu
        let menuBackground = createBackground(color: SKColor.white,
                                             size: CGSize(width: 350, height: 650),
                                             cornerRadius: 20,
                                             outlineWidth: 3,
                                             outlineColor: SKColor.clear)
        menuBackground.zPosition = 2
        levelSelectMenu.addChild(menuBackground)
        
        // title label
        let titleLabel = SKLabelNode(text:  NSLocalizedString("Floor Select", comment: ""))
        titleLabel.position = CGPoint(x: 0, y: 275)
        titleLabel.fontName = "Arial Bold"
        titleLabel.fontSize = 45
        titleLabel.fontColor = SKColor.black
        titleLabel.zPosition = 3
        levelSelectMenu.addChild(titleLabel)
        
        // buttons for each level
        for i in 1...10 {
            let isCompleted = i <= getCurrentLevel()+1
            let buttonBackground = createBackground(color: SKColor(red: 105/255, green: 129/255, blue: 214/255, alpha: 1),
                                                size: CGSize(width: 150, height: 30),
                                                cornerRadius: 100,
                                                outlineWidth: 0,
                                                outlineColor: SKColor.clear,
                                                isCompleted: isCompleted)
            buttonBackground.name = "level\(i)ButtonBackground"
            buttonBackground.position = CGPoint(x: 0, y: (i * 50) - 288)
            buttonBackground.zPosition = 3
            levelSelectMenu.addChild(buttonBackground)
            
            let levelButton = SKLabelNode(text: String(format: NSLocalizedString("Floor", comment: ""), i))
            levelButton.position = CGPoint(x: 0, y: (i * 50) - 300)
            levelButton.name = "Floor\(i)Button"
            levelButton.fontName = "Arial Bold"
            levelButton.zPosition = 4
            levelSelectMenu.addChild(levelButton)
        }
    }
    
    private func checkPerfect(level: Int) -> Int{
        switch level{
        case 0: return 1
        case 1: return 1
        case 2: return 2
        case 3: return 1
        case 4: return 2
        case 5: return 1
        case 6: return 1
        case 7: return 2
        case 8: return 1
        case 9: return 2
        default: return 1
        }
    }
    

    private func setupWinMenu() {
        winMenu = SKNode()
        winMenu.isHidden = true
        addChild(winMenu)

        let menuBackground = createBackground(color: SKColor.white,
                                             size: CGSize(width: 350, height: 650),
                                             cornerRadius: 20,
                                             outlineWidth: 3,
                                             outlineColor: SKColor.clear)
        menuBackground.zPosition = 2
        winMenu.addChild(menuBackground)

        let titleLabel = SKLabelNode(text:  NSLocalizedString("Level Complete!", comment: ""))
        titleLabel.position = CGPoint(x: 0, y: 250)
        titleLabel.fontName = "Arial Bold"
        titleLabel.fontSize = 45
        titleLabel.fontColor = SKColor.black
        titleLabel.zPosition = 3
        winMenu.addChild(titleLabel)
        
        let ptitleLabel = SKLabelNode(text: strokeCount<=checkPerfect(level: loadedLevel) ? NSLocalizedString("PERFECT!", comment: "") : "")
        ptitleLabel.position = CGPoint(x: 0, y: 190)
        ptitleLabel.fontName = "Arial Bold"
        ptitleLabel.fontSize = 45
        ptitleLabel.fontColor = SKColor.yellow
        ptitleLabel.zPosition = 3
        winMenu.addChild(ptitleLabel)
        
        let strokesCountLabel1: SKLabelNode
        strokesCountLabel1 = SKLabelNode(text:  NSLocalizedString("Strokes used", comment: ""))
        strokesCountLabel1.fontName = "Arial"
        strokesCountLabel1.fontSize = 25
        strokesCountLabel1.fontColor = SKColor.black
        strokesCountLabel1.position = CGPoint(x: 0, y: 110)
        strokesCountLabel1.zPosition = 3
        winMenu.addChild(strokesCountLabel1)

        let strokesCountLabel2: SKLabelNode
        strokesCountLabel2 = SKLabelNode(text: "\(strokeCount)/\(currentPar)")
        strokesCountLabel2.fontName = "Arial"
        strokesCountLabel2.fontSize = 25
        strokesCountLabel2.fontColor = SKColor.black
        strokesCountLabel2.position = CGPoint(x: 0, y: 80)
        strokesCountLabel2.zPosition = 3
        winMenu.addChild(strokesCountLabel2)

//        let currentLevel = getCurrentLevel()
        let currentLevelLabel = SKLabelNode(text: String(format: NSLocalizedString("Level", comment: ""), loadedLevel+1))
        currentLevelLabel.fontName = "Arial"
        currentLevelLabel.fontSize = 25
        currentLevelLabel.fontColor = SKColor.black
        currentLevelLabel.position = CGPoint(x: 0, y: 50)
        currentLevelLabel.zPosition = 3
        winMenu.addChild(currentLevelLabel)
        
        let nextLevelButtonBackground = createBackground(
            color: SKColor(red: 105/255, green: 129/255, blue: 214/255, alpha: 1),
            size: CGSize(width: 250, height: 80),
            cornerRadius: 100,
            outlineWidth: 0,
            outlineColor: SKColor.clear)
        nextLevelButtonBackground.name = "nextLevelButtonBackground"
        nextLevelButtonBackground.position = CGPoint(x: 0, y: 0)
        nextLevelButtonBackground.zPosition = 3
        winMenu.addChild(nextLevelButtonBackground)


        let nextLevelButton = SKLabelNode(text:  NSLocalizedString("Next Level", comment: ""))
        nextLevelButton.position = CGPoint(x: 0, y: 0)
        nextLevelButton.name = "nextLevelButton"
        nextLevelButton.fontName = "Arial Bold"
        nextLevelButton.zPosition = 4
        winMenu.addChild(nextLevelButton)
        
        let levelSelectButtonBackground = createBackground(
            color: SKColor(red: 63/255, green: 232/255, blue: 82/255, alpha: 1),
            size: CGSize(width: 250, height: 80),
            cornerRadius: 100,
            outlineWidth: 0,
            outlineColor: SKColor.clear)
        levelSelectButtonBackground.name = "levelSelectButtonBackground"
        levelSelectButtonBackground.position = CGPoint(x: 0, y: -100)
        levelSelectButtonBackground.zPosition = 3
        winMenu.addChild(levelSelectButtonBackground)

        
        let levelSelectButton = SKLabelNode(text:  NSLocalizedString("Level Select", comment: ""))
        levelSelectButton.position = CGPoint(x: 0, y: -102)
        levelSelectButton.name = "levelSelectButton"
        levelSelectButton.fontName = "Arial Bold"
        levelSelectButton.zPosition = 4
        winMenu.addChild(levelSelectButton)
        
        let resetButtonBackground = createBackground(
            color: SKColor(red: 203/255, green: 92/255, blue: 92/255, alpha: 1),
            size: CGSize(width: 250, height: 80),
            cornerRadius: 100,
            outlineWidth: 0,
            outlineColor: SKColor.clear)
        resetButtonBackground.name = "resetButtonBackground"
        resetButtonBackground.position = CGPoint(x: 0, y: -200)
        resetButtonBackground.zPosition = 3
        winMenu.addChild(resetButtonBackground)

        let restartButton = SKLabelNode(text:  NSLocalizedString("Restart", comment: ""))
        restartButton.position = CGPoint(x: 0, y: -202)
        restartButton.name = "restartButton"
        restartButton.fontName = "Arial Bold"
        restartButton.zPosition = 4
        winMenu.addChild(restartButton)
    }

    private func setupLoseMenu() {
        loseMenu = SKNode()
        loseMenu.isHidden = true
        addChild(loseMenu)

        let menuBackground = createBackground(color: SKColor.white,
                                             size: CGSize(width: 350, height: 650),
                                             cornerRadius: 20,
                                             outlineWidth: 3,
                                             outlineColor: SKColor.clear)
        menuBackground.zPosition = 2
        loseMenu.addChild(menuBackground)

        let titleLabel = SKLabelNode(text:  NSLocalizedString("You Lost", comment: ""))
        titleLabel.position = CGPoint(x: 0, y: 100)
        titleLabel.fontName = "Arial Bold"
        titleLabel.fontSize = 45
        titleLabel.fontColor = SKColor.black
        titleLabel.zPosition = 3
        loseMenu.addChild(titleLabel)


        let levelSelectButtonBackground = createBackground(
            color: SKColor(red: 63/255, green: 232/255, blue: 82/255, alpha: 1),
            size: CGSize(width: 250, height: 80),
            cornerRadius: 100,
            outlineWidth: 0,
            outlineColor: SKColor.clear)
        levelSelectButtonBackground.name = "levelSelectButtonBackground_lose"
        levelSelectButtonBackground.position = CGPoint(x: 0, y: -100)
        levelSelectButtonBackground.zPosition = 3
        loseMenu.addChild(levelSelectButtonBackground)

        
        let levelSelectButton = SKLabelNode(text:  NSLocalizedString("Level Select", comment: ""))
        levelSelectButton.position = CGPoint(x: 0, y: -102)
        levelSelectButton.name = "levelSelectButton_lose"
        levelSelectButton.fontName = "Arial Bold"
        levelSelectButton.zPosition = 4
        loseMenu.addChild(levelSelectButton)

        let resetButtonBackground = createBackground(
            color: SKColor(red: 203/255, green: 92/255, blue: 92/255, alpha: 1),
            size: CGSize(width: 250, height: 80),
            cornerRadius: 100,
            outlineWidth: 0,
            outlineColor: SKColor.clear)
        resetButtonBackground.name = "resetButtonBackground_lose"
        resetButtonBackground.position = CGPoint(x: 0, y: -200)
        resetButtonBackground.zPosition = 3
        loseMenu.addChild(resetButtonBackground)

        
        let restartButton = SKLabelNode(text:  NSLocalizedString("Restart", comment: ""))
        restartButton.position = CGPoint(x: 0, y: -202)
        restartButton.name = "restartButton_lose"
        restartButton.fontName = "Arial Bold"
        restartButton.zPosition = 4
        loseMenu.addChild(restartButton)
    
    }

    //helper function for those above
    private func createBackground(color: SKColor, size: CGSize, cornerRadius: CGFloat, outlineWidth: CGFloat, outlineColor: SKColor, isCompleted: Bool? = true) -> SKShapeNode {
        let rect = CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height)
        let roundedRect = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)

        let shapeNode = SKShapeNode(path: roundedRect.cgPath)
        shapeNode.fillColor = isCompleted ?? true ? color : SKColor.darkGray
        shapeNode.strokeColor = outlineColor
        shapeNode.lineWidth = outlineWidth

        return shapeNode
    }
}
