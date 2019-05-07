//
//  BattleSearchScene.swift
//  FirstGameplayTest
//
//  Created by andrea puppa on 05/05/2019.
//  Copyright © 2019 andrea puppa. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class BattleSearchScene: SKScene {
    
    var originalTouchPosition = CGFloat()
    var originalHsPosition = CGFloat()
    var originalButtonPosition = CGFloat()
    var buttonTouched = false
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.black
        layoutHomeScene()
        addSearchButton()
        addHomeScreenButton()
        addHomeScene()
    }
    
    func layoutHomeScene() {
        //Codice per creare la scena della home
        //inizio
        let searchScreen = SKShapeNode()
        searchScreen.name = "BATTLESCREEN"
        let shapeBs = UIBezierPath()
        let shapeOrigin = CGPoint(x: view!.bounds.minX, y: view!.bounds.minY)
        shapeBs.move(to: shapeOrigin)
        shapeBs.addLine(to: CGPoint(x: view!.bounds.minX, y: view!.bounds.maxY))
        shapeBs.addLine(to: CGPoint(x: view!.bounds.maxX, y: view!.bounds.maxY))
        shapeBs.addLine(to: CGPoint(x: view!.bounds.maxX, y: view!.bounds.minY))
        shapeBs.addLine(to: CGPoint(x: view!.bounds.minX, y: view!.bounds.minY))
        shapeBs.close()
        searchScreen.path = shapeBs.cgPath
        searchScreen.fillColor = UIColor.black
        searchScreen.strokeColor = UIColor.black
        searchScreen.zPosition = 0
        //fine
        addChild(searchScreen)
    }
    
    func addSearchButton() {
        //Tasto inizio gioco
        let width = frame.size.width
        let buttonHeight = width/4
        let searchButton = SKShapeNode()
        searchButton.name = "SEARCH"
        let shapeSb = UIBezierPath()
        let shapeOrigin = CGPoint(x: view!.bounds.minX + (buttonHeight/2), y: view!.bounds.midY - (buttonHeight/2))
        shapeSb.move(to: shapeOrigin)
        shapeSb.addLine(to: CGPoint(x: view!.bounds.minX + (buttonHeight/2), y: view!.bounds.midY + (buttonHeight/2)))
        shapeSb.addLine(to: CGPoint(x: view!.bounds.maxX - (buttonHeight/2), y: view!.bounds.midY + (buttonHeight/2)))
        shapeSb.addLine(to: CGPoint(x: view!.bounds.maxX - (buttonHeight/2), y: view!.bounds.midY - (buttonHeight/2)))
        shapeSb.addLine(to: CGPoint(x: view!.bounds.minX + (buttonHeight/2), y: view!.bounds.midY - (buttonHeight/2)))
        shapeSb.close()
        searchButton.path = shapeSb.cgPath
        searchButton.fillColor = UIColor.red
        searchButton.strokeColor = UIColor.red
        //Aggiungo etichetta BATTLE
        let battle = SKLabelNode(text: "BATTLE")
        battle.name = "BATTLE"
        battle.fontName = "AvenirNext-Bold"
        battle.fontSize = 50.0
        battle.fontColor = UIColor.white
        battle.position = CGPoint(x: searchButton.frame.midX, y: searchButton.frame.midY - (battle.frame.height/2))
        battle.zPosition = 1
        searchButton.addChild(battle)
        addChild(searchButton)
    }
    
    func addHomeScreenButton() {
        let width = frame.size.width
        let rectSize = width / 4
        let homeButton = SKShapeNode()
        homeButton.name = "HOMEBUTTON"
        let shapeButton = UIBezierPath()
        let minY = view!.bounds.minY
        //Faccio partire il tasto da 3/4 la larghezza
        let shapeOrigin = CGPoint(x: -rectSize * 3, y: minY)
        shapeButton.move(to: shapeOrigin)
        shapeButton.addLine(to: CGPoint(x: -rectSize * 3, y: rectSize))
        shapeButton.addLine(to: CGPoint(x: rectSize, y: rectSize))
        shapeButton.addLine(to: CGPoint(x: rectSize, y: minY))
        shapeButton.addLine(to: CGPoint(x: -rectSize * 3, y: minY))
        shapeButton.close()
        homeButton.path = shapeButton.cgPath
        homeButton.fillColor = UIColor.white
        homeButton.zPosition = 0
        //Aggiungo etichetta B
        let h = SKLabelNode(text: "H")
        h.name = "H"
        h.fontName = "AvenirNext-Bold"
        h.fontSize = 30.0
        h.fontColor = UIColor.black
        let hPos = CGPoint(x: rectSize/2, y: rectSize/2)
        h.position = hPos
        h.zPosition = 1
        homeButton.addChild(h)
        addChild(homeButton)
    }
    
    func addHomeScene() {
        let width = frame.size.width
        let rectSize = width / 4
        let homeScene = SKShapeNode()
        homeScene.name = "HOMESCENE"
        let shapeScene = UIBezierPath()
        let minX = view!.bounds.minX
        let maxY = view!.bounds.maxY
        //creo la parte nera
        let shapeOrigin = CGPoint(x: -width, y: rectSize)
        shapeScene.move(to: shapeOrigin)
        shapeScene.addLine(to: CGPoint(x: -width, y: maxY))
        shapeScene.addLine(to: CGPoint(x: minX, y: maxY))
        shapeScene.addLine(to: CGPoint(x: minX, y: rectSize))
        shapeScene.addLine(to: CGPoint(x: -width, y: rectSize))
        shapeScene.close()
        homeScene.path = shapeScene.cgPath
        homeScene.fillColor = UIColor.white
        addChild(homeScene)
    }
    
    func goToGameScene() {
        let gameScene = GameScene(fileNamed: "GameScene")
        view!.presentScene(gameScene)
    }
    
    func goToHomeScene() {
        let homeScene = HomeScene(size: view!.bounds.size)
        view!.presentScene(homeScene)
    }
    
    func finalMove(rectsize: CGFloat, duration: TimeInterval) {
        let nodeHs: SKShapeNode = self.childNode(withName: "HOMESCENE") as! SKShapeNode
        let moveRightScene = SKAction.moveBy(x: rectsize * 2, y: 0, duration: duration)
        nodeHs.run(moveRightScene, completion: {self.goToHomeScene()})
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            originalTouchPosition = location.x
            //Home button part
            let nodeH: SKShapeNode = self.childNode(withName: "HOMEBUTTON") as! SKShapeNode
            let frameH = nodeH.calculateAccumulatedFrame()
            let minX = frameH.minX
            let maxX = frameH.maxX
            let minY = frameH.minY
            let maxY = frameH.maxY
            let nodeHs: SKShapeNode = self.childNode(withName: "HOMESCENE") as! SKShapeNode
            originalHsPosition = nodeHs.position.x
            originalButtonPosition = nodeH.position.x
            //Battle button part
            let nodeBattleButton: SKShapeNode = self.childNode(withName: "SEARCH") as! SKShapeNode
            let battleButtonFrame = nodeBattleButton.frame
            let buttonMinX = battleButtonFrame.minX
            let buttonMinY = battleButtonFrame.minY
            let buttonMaxX = battleButtonFrame.maxX
            let buttonMaxY = battleButtonFrame.maxY
            if location.x > buttonMinX && location.x < buttonMaxX {
                if location.y > buttonMinY && location.y < buttonMaxY {
//                    nodeBattleButton.fillColor = UIColor.green
//                    nodeBattleButton.strokeColor = UIColor.green
                    self.goToGameScene()
                }
            } else if location.x > minX && location.x < maxX {
                if location.y > minY && location.y < maxY {
                    buttonTouched = true
                    let width = frame.size.width
                    let rectSize = width / 4
                    let duration: TimeInterval = 0.25/2
                    let moveRightButton = SKAction.moveBy(x: rectSize * 2, y: 0, duration: duration)
                    let moveRightScene = SKAction.moveBy(x: rectSize * 2, y: 0, duration: duration)
                    nodeHs.run(moveRightScene)
                    nodeH.run(moveRightButton, completion: {self.finalMove(rectsize: rectSize, duration: duration)})
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let width = frame.size.width
            let rectSize = width / 4
            let location = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            let offset = location.x - previousLocation.x
            let nodeHs: SKShapeNode = self.childNode(withName: "HOMESCENE") as! SKShapeNode
            let nodeH: SKShapeNode = self.childNode(withName: "HOMEBUTTON") as! SKShapeNode
            if nodeHs.position.x >= 0 && nodeHs.position.x <= (rectSize * 2) {
                nodeHs.position.x = nodeHs.position.x + offset
                nodeH.position.x = nodeH.position.x + offset
            } else {
                nodeHs.position.x = nodeHs.position.x + offset
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if buttonTouched == false {
            for _ in touches {
                let width = frame.size.width
                let rectSize = width / 4
                let nodeHs: SKShapeNode = self.childNode(withName: "HOMESCENE") as! SKShapeNode
                let nodeH: SKShapeNode = self.childNode(withName: "HOMEBUTTON") as! SKShapeNode
                if nodeHs.position.x < width/2 {
                    let moveBack = SKAction.moveTo(x: originalHsPosition, duration: 0.25)
                    let moveBackButton = SKAction.moveTo(x: originalButtonPosition, duration: 0.25)
                    nodeHs.run(moveBack)
                    nodeH.run(moveBackButton)
                } else {
                    let moveToScene = SKAction.moveTo(x: width, duration: 0.25)
                    let moveButtonToScene = SKAction.moveTo(x: rectSize * 2, duration: 0.25)
                    nodeH.run(moveButtonToScene)
                    nodeHs.run(moveToScene, completion: {self.goToHomeScene()})
                }
            }
        }
    }
}
