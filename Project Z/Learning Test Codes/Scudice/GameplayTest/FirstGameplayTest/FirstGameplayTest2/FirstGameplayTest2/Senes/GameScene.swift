//
//  GameScene.swift
//  FirstGameplayTest2
//
//  Created by andrea puppa on 06/05/2019.
//  Copyright © 2019 andrea puppa. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //Inizializzo variabili
    var entitiesManager: EntitiesManager!
    var lastUpdateTimeInterval: TimeInterval = 0
    var cardSelection: String = "ZOMBIE"
    var survivorExists: Bool = false
    
    override func didMove(to view: SKView) {
        addOutsideFloor()
        handleTileMap()
        createBunkerRef()
        createSlectZombieButton()
        createSlectSurvivorButton()
        entitiesManager = EntitiesManager(scene: self, generatorCenter: CGPoint(x: self.frame.midX, y: self.frame.midY))
    }
    
    func addOutsideFloor() {
        let outsideFloor = SKSpriteNode(texture: SKTexture(imageNamed: "BackGround"))
        outsideFloor.name = "OUTSIDEFLOOR"
        outsideFloor.position = self.position
        outsideFloor.anchorPoint = self.anchorPoint
        outsideFloor.zPosition = 0
        //fine
        addChild(outsideFloor)
    }
    
    func handleTileMap() {
        let tileSize = CGFloat(13)
        let refWidthTiles = 24 * tileSize
        let refHeightTiles = 40 * tileSize
        let midX = frame.midX
        let midY = frame.midY
        let floor: SKTileMapNode = childNode(withName: "FloorTileGrid") as! SKTileMapNode
        floor.position = CGPoint(x: midX - (refWidthTiles/2), y: midY - (refHeightTiles/2))
        floor.zPosition = 1
    }
    
    func createBunkerRef() {
        let tileSize = CGFloat(13)
        let refWidthTiles = 24 * tileSize
        let refHeightTiles = 40 * tileSize
        let bunkeRef = SKShapeNode()
        bunkeRef.name = "BUNKEREF"
        let shapeScene = UIBezierPath()
        let midX = frame.midX
        let midY = frame.midY
        //creo la parte nera
        let shapeOrigin = CGPoint(x: midX - (refWidthTiles/2), y: midY - (refHeightTiles/2))
        shapeScene.move(to: shapeOrigin)
        shapeScene.addLine(to: CGPoint(x: midX - (refWidthTiles/2), y: midY + (refHeightTiles/2)))
        shapeScene.addLine(to: CGPoint(x: midX + (refWidthTiles/2), y: midY + (refHeightTiles/2)))
        shapeScene.addLine(to: CGPoint(x: midX + (refWidthTiles/2), y: midY - (refHeightTiles/2)))
        shapeScene.addLine(to: CGPoint(x: midX - (refWidthTiles/2), y: midY - (refHeightTiles/2)))
        shapeScene.close()
        bunkeRef.path = shapeScene.cgPath
        bunkeRef.lineWidth = 4
        bunkeRef.strokeColor = UIColor.red
        bunkeRef.zPosition = 2
        addChild(bunkeRef)
    }
    
    func createSlectZombieButton() {
        let width = frame.size.width
        let rectSize = width / 4
        let zombieCard = SKSpriteNode(texture: SKTexture(imageNamed: "ZombieCartoonCard"))
        zombieCard.name = "ZOMBIECARD"
        zombieCard.anchorPoint = self.anchorPoint
        zombieCard.position = CGPoint(x: frame.midX - (rectSize/2), y: rectSize/4)
        zombieCard.alpha = 1
        zombieCard.zPosition = 3
        //fine
        addChild(zombieCard)
    }
    
    func createSlectSurvivorButton() {
        let width = frame.size.width
        let rectSize = width / 4
        let zombieCard = SKSpriteNode(texture: SKTexture(imageNamed: "SurvivorCartoonCard"))
        zombieCard.name = "SURVIVOR"
        zombieCard.anchorPoint = self.anchorPoint
        zombieCard.position = CGPoint(x: frame.midX - (rectSize/2), y: frame.maxY - (rectSize * (5/4)))
        zombieCard.alpha = 0.5
        zombieCard.zPosition = 3
        //fine
        addChild(zombieCard)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchPosition = touch.location(in: self)
            let cardSelectZombie: SKSpriteNode = self.childNode(withName: "ZOMBIECARD") as! SKSpriteNode
            let cardSelectSurvivor: SKSpriteNode = self.childNode(withName: "SURVIVOR") as! SKSpriteNode
            if cardSelectZombie.frame.contains(touchPosition) {
                cardSelectZombie.alpha = 1
                cardSelectSurvivor.alpha = 0.5
                cardSelection = "ZOMBIE"
            }else if cardSelectSurvivor.frame.contains(touchPosition) {
                if self.survivorExists == false {
                    cardSelectSurvivor.alpha = 1
                    cardSelectZombie.alpha = 0.5
                    cardSelection = "SURVIVOR"
                }
            }
            let generatorNode: SKShapeNode = self.childNode(withName: "Generator") as! SKShapeNode
            if cardSelection == "ZOMBIE" && !cardSelectZombie.frame.contains(touchPosition) {
                entitiesManager.spawnZombie(initialPosition: touchPosition,generatorCenter: CGPoint(x: generatorNode.frame.midX, y: generatorNode.frame.midY))
            } else if cardSelection == "SURVIVOR" && !cardSelectSurvivor.frame.contains(touchPosition) {
                if self.survivorExists == false {
                    entitiesManager.spawnSurvivor(initialPosition: touchPosition)
                    self.survivorExists = true
                    cardSelectSurvivor.alpha = 0.5
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        entitiesManager.update(deltaTime)
        if self.survivorExists == true {
            entitiesManager.updateZombieDirection()
        }
    }
}
