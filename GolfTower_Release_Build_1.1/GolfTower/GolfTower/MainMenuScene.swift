//
//  GameScene.swift
//  Salvo
//
//  Created by Weigel, Aidan on 11/7/23.
//

import SpriteKit
import GameplayKit
import Foundation
import SwiftUI

class MainMenuScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var initialTap: Bool = true
    
    private var titleScreen: SKNode?
    private var startGameButton: SKLabelNode?
    
    let menuTitle = SKSpriteNode(imageNamed: "KingmakersTransparent")
    let backgroundMusic = SKAudioNode(fileNamed: "aweigelPiano.mp3")
   
    func setupTitleScreen() {
        titleScreen = SKNode()
        
        let titleBackground = SKSpriteNode(imageNamed: "golfTowerBackground")
        titleBackground.setScale(0.9)
        titleBackground.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        titleBackground.zPosition = 0
        titleScreen?.addChild(titleBackground)
        
        let titleLabel = SKSpriteNode(imageNamed: "golfTowerText")
        titleLabel.setScale(0.4)
        titleLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.6)
        titleLabel.zPosition = 1
        titleScreen?.addChild(titleLabel)

        startGameButton = createButton(label:NSLocalizedString("Start Game", comment: ""), position: CGPoint(x: size.width * 0.5, y: size.height * 0.25))
        titleScreen?.addChild(startGameButton!)
        titleScreen?.isHidden = true


    }
    
    //should set up the assets in the main menu
    func setupNodes() {
        backgroundColor = SKColor(red:242/255.0, green: 229/255.0, blue: 227/225.0, alpha: 1.0)
        
        let scaleFactor: CGFloat = 0.5
        menuTitle.setScale(scaleFactor)
        menuTitle.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
    }

    //should add the assets in the main menu
    func addNodes() {
        addChild(menuTitle)
        addChild(backgroundMusic)
        backgroundMusic.run(SKAction.play())
    }
    
    
    //create a game scene
    func startGame() {
        
        let gameScene = SKScene(fileNamed: "GameScene")!
        self.view!.ignoresSiblingOrder = true
        gameScene.scaleMode = .aspectFill
        self.view!.presentScene(gameScene, transition: SKTransition.fade(withDuration: 1.0))
    }
    
    override func didMove(to view: SKView) {
        setupNodes()
        addNodes()
        setupTitleScreen()
        addTitleScreen()
        
    }
    
    func addTitleScreen() {
        guard let titleScreen = titleScreen, let _ = startGameButton else {return}

        addChild(titleScreen)
    }
    
    // localization logic
    func handleButtonTap(_ button: SKLabelNode) {
        switch button.name {
        case "GameBeginButton":
            startGame()
        default:
            break
        }
    }
    
    //new method: should switch to gamescene view
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if initialTap {
            initialTap = false
            menuTitle.isHidden = true
            titleScreen?.isHidden = false
        } else {
            guard let touch = touches.first else {
                return
            }
            let touchLocation = touch.location(in: self)
            
            let radius: CGFloat = 45.0
            if let button = findButton(at: touchLocation, withRadius: radius) {
                handleButtonTap(button)
            }
        }
    }
    
    func findButton(at location: CGPoint, withRadius radius: CGFloat) -> SKLabelNode? {
        // find button within the specified radius
        for case let button as SKLabelNode in self.nodes(at: location) {
            let distance = hypot(location.x - button.position.x, location.y - button.position.y)
            if distance <= radius {
                return button
            }
        }
        return nil
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        let dt = currentTime - self.lastUpdateTime
        
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
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
    
    private func createButton(label: String, position: CGPoint) -> SKLabelNode {
        let button = SKLabelNode(text: label)
        button.position = position
        button.fontName = "Arial Bold"
        button.name = "GameBeginButton"
        
        let buttonBackground = createBackground(
            color: SKColor(red: 63/255, green: 232/255, blue: 82/255, alpha: 1),
            size: CGSize(width: 250, height: 80),
            cornerRadius: 100,
            outlineWidth: 0,
            outlineColor: SKColor.clear)
        buttonBackground.zPosition = 0
        
        button.horizontalAlignmentMode = .center
        button.verticalAlignmentMode = .center
        button.zPosition = 4
        button.addChild(buttonBackground)
        
        return button
    }
}
