//
//  GameScene.swift
//  GolfTower
//
//  Created by Lane, Arthur on 11/9/23.
//

import SpriteKit
import GameplayKit
import CoreGraphics

class GameScene: SKScene{
    let localizeStrokes = NSLocalizedString("Strokes", comment:"");

    //variables used in GameScene, LevelBuilder, MenuLogic, BallController
    var golfBall: SKShapeNode!
    var afterimageNodes: [SKShapeNode] = []
    
    var hole: SKShapeNode!
    let holeRadius: CGFloat = 30
    
    let spikeRadius: CGFloat = 25
    var activeSpikes: [SKShapeNode] = []
    var spikeAnimationPlaying = false
    
    var startPoint: CGPoint?
    var directionLine: SKShapeNode?
    
    var strokeCountLabel: SKLabelNode!
    var strokeCount: Int = 0
    var currentPar: Int = 0
    var currentLevelSpriteNodes: [SKSpriteNode] = []
    var loadedLevel: Int = 0
    
    var isGamePaused: Bool = false
    var pauseButton: SKSpriteNode!
    var pauseMenu: SKNode!
    
    var unPasuing: Bool = false
    
    var levelSelectMenu: SKNode!
    
    var isGameWon: Bool = false
    var winMenu: SKNode!
    var resettingGame: Bool = false
    var isGameLost: Bool = false
    var loseMenu: SKNode!
    
    var ice: SKSpriteNode!
    
    var activeTeleporters: [SKNode] = []
    var teleporting: Bool = false
    var teleporterRadius: CGFloat = 20
    
    
    //sound effects
    let ballHit = SKAction.playSoundFileNamed("ballHit", waitForCompletion: false)
    let winEffect = SKAction.playSoundFileNamed("winEffect", waitForCompletion: false)
    let buttonClick = SKAction.playSoundFileNamed("buttonClick", waitForCompletion: false)
    let spikeEffect = SKAction.playSoundFileNamed("spikeEffect", waitForCompletion: false)
    let loseEffect = SKAction.playSoundFileNamed("loseEffect", waitForCompletion: false)
    let wallHit = SKAction.playSoundFileNamed("wallHit", waitForCompletion: false)
    let portalEffect = SKAction.playSoundFileNamed("portalEffect", waitForCompletion: false)
    
    //music
    let backgroundMusic = SKAudioNode(fileNamed: "Sunset Pier.mp3")
   
    
    
    //for wall collision
    struct PhysicsCategory {
        static let none: UInt32 = 0
        static let all: UInt32 = UInt32.max
        static let wall: UInt32 = 0b1       // 1
        static let ball: UInt32 = 0b10      // 2
    }

    //on startup:
    override func didMove(to view: SKView) {
        //turn this on to unlock max levels
        saveCurrentLevel(4)
        
        addChild(backgroundMusic)
        
        backgroundMusic.run(SKAction.play())
        
        setupPhysics()
        setupStrokeCountLabel()
        selectLevel(getCurrentLevel())
        makeMenus()
    }
    
    //touch detected
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isBallMoving else { return } // Ignore new touches if the ball is still moving
        
        if let touchLocation = touches.first?.location(in: self){
            startPoint = touchLocation

             if isGamePaused { //if paused (logic for pause menu)
                 if !pauseMenu.contains(touchLocation) { //if pressed outside, end pause
                    handlePauseMenuClose()
                    unPasuing = true
                    
                }else{ //pressed inside pause menu
                    
                    if pauseMenu.isHidden == false { //main pause menu logic
                        for node in pauseMenu.children {
                            if node.contains(touchLocation) {
                                if node.name == "resetButtonBackground" {
                                    run(buttonClick) //sound effect
                                    isGamePaused = false
                                    pauseMenu.isHidden.toggle()
                                    unPasuing = true
                                    selectLevel(loadedLevel)
                                } else if node.name == "levelSelecetionButtonBackground" {
                                    run(buttonClick) //sound effect
                                    pauseMenu.isHidden.toggle()
                                    levelSelectMenu.isHidden.toggle()
                                }
                            }
                        }
                        
                    }else if levelSelectMenu.isHidden == false {//level select menu logic (user has opened level select from pause menu)
                        for node in levelSelectMenu.children {
                            if node.contains(touchLocation) {
                                if node.contains(touchLocation), let nodeName = node.name {
                                    unPasuing=true
                                    switch nodeName {
                                    case "level1ButtonBackground":
                                        if getCurrentLevel() >= 0{
                                            run(buttonClick) //sound effect
                                            selectLevel(0)
                                            handlePauseMenuClose()
                                        }
                                    case "level2ButtonBackground":
                                        if getCurrentLevel() >= 1{
                                            run(buttonClick) //sound effect
                                            selectLevel(1)
                                            handlePauseMenuClose()
                                        }
                                    case "level3ButtonBackground":
                                        if getCurrentLevel() >= 2{
                                            run(buttonClick) //sound effect
                                            selectLevel(2)
                                            handlePauseMenuClose()
                                        }
                                    case "level4ButtonBackground":
                                        if getCurrentLevel() >= 3{
                                            run(buttonClick) //sound effect
                                            selectLevel(3)
                                            handlePauseMenuClose()
                                        }
                                    case "level5ButtonBackground":
                                        if getCurrentLevel() >= 4{
                                            run(buttonClick) //sound effect
                                            selectLevel(4)
                                            handlePauseMenuClose()
                                        }
                                    case "level6ButtonBackground":
                                        if getCurrentLevel() >= 5{
                                            run(buttonClick) //sound effect
                                            selectLevel(5)
                                            handlePauseMenuClose()
                                        }
                                    case "level7ButtonBackground":
                                        if getCurrentLevel() >= 6{
                                            run(buttonClick) //sound effect
                                            selectLevel(6)
                                            handlePauseMenuClose()
                                        }
                                    case "level8ButtonBackground":
                                        if getCurrentLevel() >= 7{
                                            run(buttonClick) //sound effect
                                            selectLevel(7)
                                            handlePauseMenuClose()
                                        }
                                    case "level9ButtonBackground":
                                        if getCurrentLevel() >= 8{
                                            run(buttonClick) //sound effect
                                            selectLevel(8)
                                            handlePauseMenuClose()
                                        }
                                    case "level10ButtonBackground":
                                        if getCurrentLevel() >= 9{
                                            run(buttonClick) //sound effect
                                            selectLevel(9)
                                            handlePauseMenuClose()
                                        }
                                    default:
                                        break
                                    }
                                }
                            }
                        }
                    }
                }
            }else if isGameLost { //lose game logic
                if loseMenu.contains(touchLocation) {
                    for node in loseMenu.children {
                        if node.contains(touchLocation) {
                            if node.name == "levelSelectButtonBackground_lose" {
                                closeLoseMenu()
                                renderLevelSelectMenu()
                                //print("levelSelectionChosen")
                            } else if node.name == "resetButtonBackground_lose" {
                                closeLoseMenu()
                                resettingGame = true
                                selectLevel(loadedLevel)
                            }
                        }
                    }
                }
            } else if isGameWon { // Win Menu logic
                if winMenu.contains(touchLocation) {
                    for node in winMenu.children {
                        if node.contains(touchLocation) {
                            if node.name == "nextLevelButtonBackground" {
                                self.resettingGame = true
                                closeWinMenu()
                                if (loadedLevel + 1) < 10{
                                    selectLevel(loadedLevel+1)
                                }else{
                                    selectLevel(0)
                                }
                            } else if node.name == "levelSelectButtonBackground" {
                                self.resettingGame = true
                                winMenu.isHidden = true
                                closeWinMenu()
                                renderLevelSelectMenu()

                            } else if node.name == "resetButtonBackground" {
                                closeWinMenu()
                                resettingGame = true
                                selectLevel(loadedLevel)
                            }

                        }
                    }
                }
            } else { //not paused
                if pauseButton.contains(touchLocation) { //pressed pause button, pause the game (note can only pause when ball is stationary)
                    handlePauseButtonTap()
                }else{ // not paused, or pausing, make direction line
                    directionLine = SKShapeNode()
                    addChild(directionLine!)
                }
            }
        }
    }
    
    //drag is happening
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let startPoint = startPoint else { return }
        let currentPoint = touches.first?.location(in: self)
        let delta = CGVector(dx: currentPoint!.x - startPoint.x, dy: currentPoint!.y - startPoint.y)
        
        //update the line based on drag
        updateDirectionLine(startPoint, delta)
        
    }
    
    //touch released
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let startPointl = startPoint, let currentPoint = touches.first?.location(in: self) else { return }
        
        //get final vector from starting touch location to end
        let delta = CGVector(dx: currentPoint.x - startPointl.x, dy: currentPoint.y - startPointl.y)
        
        // Apply velocity if we are shooting
        if !isGamePaused && !isGameWon && !isGameLost {
            if !unPasuing && !resettingGame {
                run(ballHit) //soundeffect
                
                applyImpulseToBall(delta)
                
                directionLine?.removeFromParent()
                
                incrementStrokeCount()
            }else{
                unPasuing = false
                resettingGame = false
            }
        }
        startPoint = nil
    }
    
    // called once ball in hole
    private func winGame() {
        guard !isGameWon else {return}
        run(winEffect) //sound effect
        
        if getCurrentLevel() < 9 {
            if loadedLevel + 1 > getCurrentLevel(){
                saveCurrentLevel(loadedLevel+1)
            }
            
        }
        
        //display win screen
        clearLevel()
        renderWinMenu()
        strokeCount = 0
        
    }
    
    private func loseGame() {
        run(loseEffect)
        self.isGameLost = true
        renderLoseMenu()
        
    }
    
    //the following functions are all called in update, on every tick
    private func checkBallInHole() {
        guard let golfBall = golfBall, isBallFast == false else { return }
        
        let distanceToHole = golfBall.position.distance(to: hole.position)
        
        if distanceToHole < holeRadius+3 {
            winGame()
        }
    }
    
    private func checkBallInSpike() {
        guard let golfBall = golfBall, activeSpikes.isEmpty == false else { return }
        
        for spike in activeSpikes{
            if golfBall.position.distance(to: spike.position) < spikeRadius {
                
                if !spikeAnimationPlaying{
                    run(spikeEffect) //sound effect
                    let sequenceAction = SKAction.sequence([SKAction.fadeOut(withDuration: 0.3), SKAction.wait(forDuration: 0.8)])
                    golfBall.physicsBody?.velocity = CGVector.zero
                    
                    golfBall.run(sequenceAction){
                        self.golfBall.alpha = 0.0
                        self.loseGame()
                        self.golfBall.alpha = 1.0
                    }
                }
                spikeAnimationPlaying = true

                break
            }
        }
    }
    
    private func checkTeleportation() {
        guard let golfBall = golfBall else { return }
        for teleporterNode in activeTeleporters {
     
            if let blueTeleporter = teleporterNode.children.first as? SKShapeNode,
               let orangeTeleporter = teleporterNode.children.last as? SKShapeNode {
                if golfBall.position.distance(to: blueTeleporter.position) < 20 {
                    if !teleporting{
                        teleporting = true
                        golfBall.position = orangeTeleporter.position
                        run(portalEffect) //teleport effect
                    }
                }else if golfBall.position.distance(to: orangeTeleporter.position) < 20 {
                    if !teleporting{
                        teleporting = true
                        golfBall.position = blueTeleporter.position
                        run(portalEffect) //teleport effect
                    }
                }else{
                    teleporting = false
                }
            }
            break
            
            
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if isBallMoving {
            createAfterimageNode()
        } else {
            removeAfterimages()
        }
        if !isGameWon{
            checkBallInHole()
            checkTeleportation()
            checkBallInSpike()
        }
        
        
        if strokeCount == currentPar && isBallMoving == false && !isGameLost{
            loseGame()
        }
    }
    
    //setup ball bouncing off side of screen
    private func setupPhysics() {
        physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        physicsBody?.friction = 0
        physicsBody?.restitution = 1.0
        physicsWorld.contactDelegate = self
    }
    
    //getter and setter for level user is currently on - saves over closing
    func saveCurrentLevel(_ level: Int) {
        UserDefaults.standard.set(level, forKey: "currentLevel")
    }
    
    func getCurrentLevel() -> Int {
        return UserDefaults.standard.object(forKey: "currentLevel") as? Int ?? 0
    }
    
    
} //used to compare locations of SKShapeNodes
extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        let dx = point.x - self.x
        let dy = point.y - self.y
        return sqrt(dx*dx + dy*dy)
    }
}

//wall collision checks (to use for sound effects)
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
      
      var firstBody: SKPhysicsBody
      var secondBody: SKPhysicsBody
      if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
        firstBody = contact.bodyA
        secondBody = contact.bodyB
      } else {
        firstBody = contact.bodyB
        secondBody = contact.bodyA
      }
     
      if ((firstBody.categoryBitMask & PhysicsCategory.wall != 0) &&
          (secondBody.categoryBitMask & PhysicsCategory.ball != 0)) {
          
          run(wallHit) //wall hit effect
        }
      }
    }
