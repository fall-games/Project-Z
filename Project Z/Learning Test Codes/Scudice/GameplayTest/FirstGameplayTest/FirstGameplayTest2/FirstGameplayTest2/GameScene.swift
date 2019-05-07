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
    
    
    
    override func didMove(to view: SKView) {
        addOutsideFloor()
        handleTileMap()
        createBunkerRef()
    }
    
    func addOutsideFloor() {
        let outsideFloor = SKShapeNode()
        outsideFloor.name = "OUTSIDEFLOOR"
        let shapeBs = UIBezierPath()
        let shapeOrigin = CGPoint(x: view!.bounds.minX, y: view!.bounds.minY)
        shapeBs.move(to: shapeOrigin)
        shapeBs.addLine(to: CGPoint(x: view!.bounds.minX, y: view!.bounds.maxY))
        shapeBs.addLine(to: CGPoint(x: view!.bounds.maxX, y: view!.bounds.maxY))
        shapeBs.addLine(to: CGPoint(x: view!.bounds.maxX, y: view!.bounds.minY))
        shapeBs.addLine(to: CGPoint(x: view!.bounds.minX, y: view!.bounds.minY))
        shapeBs.close()
        outsideFloor.path = shapeBs.cgPath
        outsideFloor.fillColor = UIColor.blue
        outsideFloor.strokeColor = UIColor.blue
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
        bunkeRef.strokeColor = UIColor.red
        print(bunkeRef.frame)
        print(midX, midY)
        print(refWidthTiles/2)
        print(midX - (refWidthTiles/2))
        addChild(bunkeRef)
    }
    
    
}
