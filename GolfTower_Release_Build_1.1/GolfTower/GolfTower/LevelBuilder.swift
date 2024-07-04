//
//  LevelBuilder.swift
//  GolfTower
//
//  Created by Lane, Arthur on 11/10/23.
//

import Foundation
import SpriteKit
import GameplayKit

struct Rectangle {
    var origin: CGPoint
    var width: CGFloat
    var height: CGFloat
    var rotation: CGFloat
}

struct Level {
    var start: CGPoint
    var hole: CGPoint
    var teleporter: (a: CGPoint, b: CGPoint)?
    var walls: [Rectangle]?
    var iceRegion: Rectangle?
    var spikes: [CGPoint]?
    var par: Int
}

let level0 = Level(
    start: CGPoint(x: 300, y: 1000),
    hole: CGPoint(x: 300, y: 300),
    teleporter: nil,
    walls: [],
    iceRegion: Rectangle(origin: CGPoint(x: 0, y: 0), width: 15, height: 15, rotation: 0),
    spikes: nil,
    par: 2
)

let level1 = Level(
    start: CGPoint(x: 300, y: 900),
    hole: CGPoint(x: 300, y: 300),
    teleporter: nil,
    walls: [
        Rectangle(origin: CGPoint(x: 200, y: 500), width: 400, height: 30, rotation: 0),
    ],
    iceRegion: Rectangle(origin: CGPoint(x: 0, y: 0), width: 15, height: 15, rotation: 0),
    spikes: nil,
    par: 3
)

let level2 = Level(
    start: CGPoint(x: 100, y: 220),
    hole: CGPoint(x: 150, y: 1000),
    teleporter: nil,
    walls: [
        Rectangle(origin: CGPoint(x: 350, y: 200), width: 350, height: 30, rotation: -0.785),
        Rectangle(origin: CGPoint(x: 0, y: 400), width: 350, height: 30, rotation: 0),
        Rectangle(origin: CGPoint(x: 350, y: 400), width: 30, height: 600, rotation: 0),
        Rectangle(origin: CGPoint(x: -100, y: 1200), width: 500, height: 30, rotation: -0.785),
        Rectangle(origin: CGPoint(x: -60, y: 900), width: 300, height: 30, rotation: 0.785),
    ],
    iceRegion: Rectangle(origin: CGPoint(x: 0, y: 0), width: 15, height: 15, rotation: 0),
    spikes: nil,
    par: 4
)

let level3 = Level(
    start: CGPoint(x: 120, y: 680),
    hole: CGPoint(x: 470, y: 680),
    teleporter: nil,
    walls: [
        Rectangle(origin: CGPoint(x: 380, y: 500), width: 300, height: 30, rotation: -0.785),
        Rectangle(origin: CGPoint(x: -80, y: 500), width: 300, height: 30, rotation: 0.785),
        Rectangle(origin: CGPoint(x: 285, y: 600), width: 30, height: 170, rotation: 0),
    ],
    iceRegion: Rectangle(origin: CGPoint(x: 0, y: 0), width: 15, height: 15, rotation: 0),
    spikes: nil,
    par: 3
)

let level4 = Level(
    start: CGPoint(x: 520, y: 1100),
    hole: CGPoint(x: 300, y: 1100),
    teleporter: nil,
    walls: [
        Rectangle(origin: CGPoint(x: 160, y: 0), width: 30, height: 1300, rotation: 0),
        Rectangle(origin: CGPoint(x: 410, y: 320), width: 30, height: 1100, rotation: 0),
    ],
    iceRegion: Rectangle(origin: CGPoint(x: 0, y: 0), width: 15, height: 15, rotation: 0),
    spikes: nil,
    par: 3
)

let level5 = Level(
    start: CGPoint(x: 430, y: 900),
    hole: CGPoint(x: 150, y: 410),
    teleporter: (a: CGPoint(x: 400, y: 410), b: CGPoint(x: 150, y: 900)),
    walls: [
        Rectangle(origin: CGPoint(x: 50, y: 270), width: 30, height: 280, rotation: 0),
        Rectangle(origin: CGPoint(x: 510, y: 270), width: 30, height: 280, rotation: 0),
        Rectangle(origin: CGPoint(x: 80, y: 270), width: 430, height: 30, rotation: 0),
        Rectangle(origin: CGPoint(x: 80, y: 520), width: 430, height: 30, rotation: 0),
    ],
    iceRegion: Rectangle(origin: CGPoint(x: 0, y: 0), width: 15, height: 15, rotation: 0),
    spikes: nil,
    par: 2
)

let level6 = Level(
    start: CGPoint(x: 100, y: 300),
    hole: CGPoint(x: 450, y: 800),
    teleporter: (a: CGPoint(x: 540, y: 600), b: CGPoint(x: 250, y: 730)),
    walls: [
        Rectangle(origin: CGPoint(x: 0, y: 500), width: 250, height: 30, rotation: 0),
        Rectangle(origin: CGPoint(x: 370, y: 0), width: 30, height: 960, rotation: 0),
        Rectangle(origin: CGPoint(x: 135, y: 730), width: 30, height: 350, rotation: 0),
        Rectangle(origin: CGPoint(x: 0, y: 1200), width: 450, height: 30, rotation: 0),
    ],
    iceRegion: Rectangle(origin: CGPoint(x: 0, y: 0), width: 15, height: 15, rotation: 0),
    spikes: [
        CGPoint(x: 370, y: 1100),
        CGPoint(x: 135, y: 600)
    ],
    par: 3
)

let level7 = Level(
    start: CGPoint(x: 180, y: 1100),
    hole: CGPoint(x: 500, y: 330),
    teleporter: (a: CGPoint(x: 180, y: 330), b: CGPoint(x: 500, y: 1100)),
    walls: [
        Rectangle(origin: CGPoint(x: 0, y: 500), width: 100, height: 30, rotation: 0),
        Rectangle(origin: CGPoint(x: 270, y: 500), width: 100, height: 30, rotation: 0),
        Rectangle(origin: CGPoint(x: 370, y: 0), width: 30, height: 1300, rotation: 0),
    ],
    iceRegion: Rectangle(origin: CGPoint(x: 370, y: 0), width: 230, height: 1300, rotation: 0),
    spikes: [
        CGPoint(x: 60, y: 800),
        CGPoint(x: 180, y: 800),
        CGPoint(x: 310, y: 800),
        CGPoint(x: 450, y: 500),
        CGPoint(x: 550, y: 700),
        CGPoint(x: 450, y: 950),
    ],
    par: 4
)

let level8 = Level(
    start: CGPoint(x: 300, y: 1150),
    hole: CGPoint(x: 300, y: 230),
    teleporter: (a: CGPoint(x: 180, y: 550), b: CGPoint(x: 420, y: 750)),
    walls: [],
    iceRegion: nil,
    spikes: [
        CGPoint(x: 60, y: 350),
        CGPoint(x: 180, y: 350),
        CGPoint(x: 300, y: 350),
        CGPoint(x: 420, y: 350),
        CGPoint(x: 540, y: 350),
        
        CGPoint(x: 120, y: 450),
        CGPoint(x: 240, y: 450),
        CGPoint(x: 360, y: 450),
        CGPoint(x: 480, y: 450),
        
        CGPoint(x: 60, y: 550),
        // TP a here
        CGPoint(x: 300, y: 550),
        CGPoint(x: 420, y: 550),
        CGPoint(x: 540, y: 550),
        
        CGPoint(x: 120, y: 650),
        CGPoint(x: 240, y: 650),
        CGPoint(x: 360, y: 650),
        CGPoint(x: 480, y: 650),
        
        CGPoint(x: 60, y: 750),
        CGPoint(x: 180, y: 750),
        CGPoint(x: 300, y: 750),
        // TP b here
        CGPoint(x: 540, y: 750),
        
        CGPoint(x: 120, y: 850),
        CGPoint(x: 240, y: 850),
        CGPoint(x: 360, y: 850),
        CGPoint(x: 480, y: 850),
        
        CGPoint(x: 60, y: 950),
        CGPoint(x: 180, y: 950),
        CGPoint(x: 300, y: 950),
        CGPoint(x: 420, y: 950),
        CGPoint(x: 540, y: 950),
    ],
    par: 2
)

let level9 = Level(
    start: CGPoint(x: 150, y: 1150),
    hole: CGPoint(x: 300, y: 230),
    teleporter: (a: CGPoint(x: 480, y: 820), b: CGPoint(x: 130, y: 800)),
    walls: [
        Rectangle(origin: CGPoint(x: -200, y: 1150), width: 450, height: 30, rotation: -0.785),
        Rectangle(origin: CGPoint(x: -180, y: 580), width: 614, height: 30, rotation: -0.785),
        Rectangle(origin: CGPoint(x: 230, y: 580), width: 450, height: 30, rotation: -0.785),
        Rectangle(origin: CGPoint(x: -100, y: 970), width: 500, height: 30, rotation: 0.785),
        Rectangle(origin: CGPoint(x: -50, y: 1120), width: 780, height: 30, rotation: 0.785),
        Rectangle(origin: CGPoint(x: 180, y: 166), width: 780, height: 30, rotation: 0.785),
    ],
    iceRegion: Rectangle(origin: CGPoint(x:0,y:0), width:600, height:1300, rotation: 0),
    spikes: [
        CGPoint(x: 60, y: 350),
        CGPoint(x: 180, y: 350),
        CGPoint(x: 300, y: 350),
        
        CGPoint(x: 60, y: 800),
        CGPoint(x: 60, y: 730),
        CGPoint(x: 60, y: 870),
        CGPoint(x: 200, y: 800),
        CGPoint(x: 200, y: 730),
        CGPoint(x: 200, y: 870),
        CGPoint(x: 200, y: 730),
        CGPoint(x: 130, y: 730),
        CGPoint(x: 130, y: 870),
        
        CGPoint(x: 370, y: 870),
        CGPoint(x: 440, y: 930)
    ],
    par: 3
)

let levels = [level0, level1, level2, level3, level4, level5, level6, level7, level8, level9]


extension GameScene {
    
    
    //function used in level selection screen, can have different effects in necesary
    func selectLevel(_ level: Int) {
        print("Selected level: \(level)")
        
        loadedLevel = level
        isGameWon = false
        isGameLost = false
        spikeAnimationPlaying = false
        resetStrokeCount()
        
        clearLevel()
        
        currentPar = levels[level].par
        
        renderStrokeLabel()
        
        let grass = SKShapeNode(rect: CGRect(x: -300, y: -650, width: 600, height: 1300))
        grass.fillColor = SKColor(red: 66/255, green: 158/255, blue: 81/255, alpha: 1)
        addChild(grass)
        
        let menuBarRect = Rectangle(origin: CGPoint(x: 0, y: 0), width: 600, height: 150, rotation: 0)
        createWall(menuBarRect)
        
        setupBall(convertCoords(levels[level].start))
        setupHole(convertCoords(levels[level].hole))
        
        if let walls = levels[level].walls {
            setupWalls(walls)
        }
        
        if let spikes = levels[level].spikes {
            setupSpikes(spikes)
        }
        
        if let teleporter = levels[level].teleporter {
            let tpA = convertCoords(teleporter.a)
            let tpB = convertCoords(teleporter.b)
            createTeleporter(startLocation: tpA, endLocation: tpB)
        }
        
    }
    
    private func convertCoords(_ point: CGPoint) -> CGPoint {
        let SCREEN_SIZE_IPHONE_14_PRO_X: CGFloat = 600
        let SCREEN_SIZE_IPHONE_14_PRO_Y: CGFloat = 1300
        
        let newX = point.x - (SCREEN_SIZE_IPHONE_14_PRO_X / 2)
        let newY = -point.y + (SCREEN_SIZE_IPHONE_14_PRO_Y / 2)
        return CGPoint(x: newX, y: newY)
    }
    
    private func offsetRectangle(_ rect: Rectangle) -> Rectangle {
        let adjustedOrigin = CGPoint(x: rect.origin.x + (rect.width / 2), y: rect.origin.y - (rect.height / 2))
        return Rectangle(origin: adjustedOrigin, width: rect.width, height: rect.height, rotation: rect.rotation)
    }
    
    //make teleporter
    private func createTeleporter(startLocation: CGPoint, endLocation: CGPoint){
        // Create blue teleporter side
        let blueTeleporter = SKShapeNode(circleOfRadius: teleporterRadius)
        blueTeleporter.position = startLocation
        blueTeleporter.fillColor = SKColor.blue
        blueTeleporter.strokeColor = SKColor.clear

        // Create orange teleporter side
        let orangeTeleporter = SKShapeNode(circleOfRadius: teleporterRadius)
        orangeTeleporter.position = endLocation
        orangeTeleporter.fillColor = SKColor.orange
        orangeTeleporter.strokeColor = SKColor.clear

        // Combine blue and orange teleporter sides into a single node
        let teleporterNode = SKNode()
        teleporterNode.addChild(blueTeleporter)
        teleporterNode.addChild(orangeTeleporter)

        addChild(teleporterNode)
        
        activeTeleporters.append(teleporterNode)
        
    }
    
    private func setupBall(_ origin: CGPoint) {
        createGolfBall(position: origin)
    }
    
    //make hole
    private func setupHole(_ position: CGPoint) {
        hole = SKShapeNode(circleOfRadius: holeRadius)
        hole.position = position
        hole.strokeColor = SKColor(red: 24/255, green: 24/255, blue: 24/255, alpha: 1)
        hole.fillColor = SKColor(red: 24/255, green: 24/255, blue: 23/255, alpha: 1)
        addChild(hole)
    }
    
    private func setupSpikes(_ spikes: [CGPoint]) {
        for spike in spikes {
            let newCoords = convertCoords(spike)
            createSpike(newCoords)
        }
    }
    
    //make spike
    private func createSpike(_ position: CGPoint) {
        let spike = SKShapeNode(circleOfRadius: spikeRadius)
        spike.position = position
        spike.strokeColor = SKColor.red
        spike.fillColor = SKColor.black
        addChild(spike)
        activeSpikes.append(spike)
    }
    
    private func setupWalls(_ walls: [Rectangle]) {
        for wall in walls {
            createWall(wall)
        }
    }
    
    //make wall (rotation in radians)
    private func createWall(_ rect: Rectangle) {
        let convertedCoordsRect = Rectangle(origin: convertCoords(rect.origin), width: rect.width, height: rect.height, rotation: rect.rotation)
        
        let offsetRect = offsetRectangle(convertedCoordsRect)
        
        let wall = SKSpriteNode(color: SKColor.white, size: CGSize(width: offsetRect.width, height: offsetRect.height))
        wall.position = offsetRect.origin
        wall.zRotation = offsetRect.rotation
        wall.physicsBody = SKPhysicsBody(rectangleOf: wall.size)
        wall.physicsBody?.isDynamic = false // Make the wall static (non-moving)
        wall.physicsBody?.categoryBitMask = PhysicsCategory.wall
        wall.physicsBody?.contactTestBitMask = PhysicsCategory.ball
        wall.physicsBody?.collisionBitMask = PhysicsCategory.all
        wall.physicsBody?.usesPreciseCollisionDetection = true

        addChild(wall)
        
        currentLevelSpriteNodes.append(wall)
    }
    
//    private func setupIce(_ rect: Rectangle) {
//        let convertedCoordsRect = Rectangle(origin: convertCoords(rect.origin), width: rect.width, height: rect.height, rotation: rect.rotation)
//
//        let offsetRect = offsetRectangle(convertedCoordsRect)
//
//        let iceColor = SKColor(red: 159/255, green: 229/255, blue: 238/225, alpha: 1)
//        let iceRegion = SKSpriteNode(color: iceColor, size: CGSize(width: offsetRect.width, height: offsetRect.height))
//        iceRegion.position = offsetRect.origin
//
//        addChild(iceRegion)
//
//        ice = iceRegion
//    }
    
    //resets level
    func resetLevel() {
        isGameWon = false
        isGameLost = false
        spikeAnimationPlaying = false
        strokeCount = 0
        resetStrokeCount()
        //golfBall.physicsBody?.angularVelocity = 0
    }
    
    func clearLevel() {
        guard let golfBall = golfBall else { return }
        isGameWon = false
        isGameLost = false
        activeTeleporters.removeAll()
        activeSpikes.removeAll()
        golfBall.removeFromParent()
        for node in currentLevelSpriteNodes {
            node.removeAllChildren()
            node.removeFromParent()
        }
        currentLevelSpriteNodes.removeAll()
    }
    
    func setupStrokeCountLabel() {
        strokeCountLabel = SKLabelNode(fontNamed: "Arial")
        strokeCountLabel.fontSize = 40
        strokeCountLabel.position = CGPoint(x: -200, y: 550)
        strokeCountLabel.fontColor = SKColor.black
        addChild(strokeCountLabel)
        renderStrokeLabel()
    }
    
    private func resetStrokeCount() {
        strokeCount = 0
        renderStrokeLabel()
    }
    
    func incrementStrokeCount() {
        strokeCount += 1
        renderStrokeLabel()
    }
    
    private func renderStrokeLabel() {
        strokeCountLabel.text = "\(strokeCount) / \(currentPar)"
    }
}
