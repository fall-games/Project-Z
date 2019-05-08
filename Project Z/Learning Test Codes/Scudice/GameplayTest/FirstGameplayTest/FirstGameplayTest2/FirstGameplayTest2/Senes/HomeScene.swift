//
//  HomeScene.swift
//  FirstGameplayTest2
//
//  Created by andrea puppa on 06/05/2019.
//  Copyright © 2019 andrea puppa. All rights reserved.
//

import Foundation
import SpriteKit

class HomeScene: SKScene {
    
    var originalTouchPosition = CGFloat()
    var originalBsPosition = CGFloat()
    var originalButtonPosition = CGFloat()
    var buttonTouched = false
    
    override func didMove(to view: SKView) {
        layoutHomeScene()
        addBattleScreenButton()
        addBattleScene()
    }
    
    func layoutHomeScene() {
        //Codice per creare la scena della home
        //inizio
        let homeScreen = SKShapeNode()
        homeScreen.name = "HOMESCREEN"
        let shapeHome = UIBezierPath()
        let shapeOrigin = CGPoint(x: view!.bounds.minX, y: view!.bounds.minY)
        shapeHome.move(to: shapeOrigin)
        shapeHome.addLine(to: CGPoint(x: view!.bounds.minX, y: view!.bounds.maxY))
        shapeHome.addLine(to: CGPoint(x: view!.bounds.maxX, y: view!.bounds.maxY))
        shapeHome.addLine(to: CGPoint(x: view!.bounds.maxX, y: view!.bounds.minY))
        shapeHome.addLine(to: CGPoint(x: view!.bounds.minX, y: view!.bounds.minY))
        shapeHome.close()
        homeScreen.path = shapeHome.cgPath
        homeScreen.fillColor = UIColor.white
        homeScreen.zPosition = 0
        //Aggiungo etichetta HOME
        let home = SKLabelNode(text: "HOME")
        home.name = "HOME"
        home.fontName = "AvenirNext-Bold"
        home.fontSize = 50.0
        home.fontColor = UIColor.black
        home.position = CGPoint(x: frame.midX, y: frame.midY)
        home.zPosition = 1
        homeScreen.addChild(home)
        //fine
        addChild(homeScreen)
    }
    
    func addBattleScreenButton() {
        let width = frame.size.width
        let rectSize = width / 4
        let battleButton = SKShapeNode()
        battleButton.name = "BATTLEBUTTON"
        let shapeButton = UIBezierPath()
        let minY = view!.bounds.minY
        //Faccio partire il tasto da 3/4 la larghezza
        let shapeOrigin = CGPoint(x: rectSize * 3, y: minY)
        shapeButton.move(to: shapeOrigin)
        shapeButton.addLine(to: CGPoint(x: rectSize * 3, y: rectSize))
        shapeButton.addLine(to: CGPoint(x: (rectSize * 3) + width, y: rectSize))
        shapeButton.addLine(to: CGPoint(x: (rectSize * 3) + width, y: minY))
        shapeButton.addLine(to: CGPoint(x: rectSize * 3, y: minY))
        shapeButton.close()
        battleButton.path = shapeButton.cgPath
        battleButton.fillColor = UIColor.black
        battleButton.strokeColor = UIColor.black
        battleButton.zPosition = 0
        //Aggiungo etichetta B
        let b = SKLabelNode(text: "B")
        b.name = "B"
        b.fontName = "AvenirNext-Bold"
        b.fontSize = 30.0
        b.fontColor = UIColor.white
        let textCount = CGFloat(integerLiteral: b.text!.count)
        let offset = (textCount/4) * b.fontSize
        let bPos = CGPoint(x: battleButton.position.x + (rectSize * (7/2)) + offset, y: battleButton.position.y + (rectSize/2))
        b.position = bPos
        b.zPosition = 1
        battleButton.addChild(b)
        addChild(battleButton)
    }
    
    func addBattleScene() {
        let width = frame.size.width
        let rectSize = width / 4
        let battleScene = SKShapeNode()
        battleScene.name = "BATTLESCENE"
        let shapeScene = UIBezierPath()
        let maxY = view!.bounds.maxY
        //creo la parte nera
        let shapeOrigin = CGPoint(x: width, y: rectSize)
        shapeScene.move(to: shapeOrigin)
        shapeScene.addLine(to: CGPoint(x: width, y: maxY))
        shapeScene.addLine(to: CGPoint(x: width * 2, y: maxY))
        shapeScene.addLine(to: CGPoint(x: width * 2, y: rectSize))
        shapeScene.addLine(to: CGPoint(x: width, y: rectSize))
        shapeScene.close()
        battleScene.path = shapeScene.cgPath
        battleScene.fillColor = UIColor.black
        battleScene.strokeColor = UIColor.black
        addChild(battleScene)
    }
    
    func changeLabel(labelNode: SKLabelNode) {
        let width = frame.size.width
        let rectSize = width / 4
        let textCount = CGFloat(integerLiteral: labelNode.text!.count)
        let offset = (textCount/4) * labelNode.fontSize
        let bPos = CGPoint(x: labelNode.parent!.position.x + (rectSize * (7/2)) + offset, y: labelNode.parent!.position.y + (rectSize/2))
        labelNode.position = bPos
    }
    
    func changeScene() {
        let battleSearchScene = BattleSearchScene(size: view!.bounds.size)
        view!.presentScene(battleSearchScene)
    }
    
    func finalMove(rectsize: CGFloat, duration: TimeInterval) {
        let nodeBs: SKShapeNode = self.childNode(withName: "BATTLESCENE") as! SKShapeNode
        let moveLeftScene = SKAction.moveBy(x: -rectsize * 2, y: 0, duration: duration)
        nodeBs.run(moveLeftScene, completion: {self.changeScene()})
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            originalTouchPosition = location.x
            let nodeB: SKShapeNode = self.childNode(withName: "BATTLEBUTTON") as! SKShapeNode
            let frameB = nodeB.calculateAccumulatedFrame()
            let minX = frameB.minX
            let maxX = frameB.maxX
            let minY = frameB.minY
            let maxY = frameB.maxY
            let nodeBs: SKShapeNode = self.childNode(withName: "BATTLESCENE") as! SKShapeNode
            originalBsPosition = nodeBs.position.x
            originalButtonPosition = nodeB.position.x
            if location.x > minX && location.x < maxX {
                if location.y > minY && location.y < maxY {
                    buttonTouched = true
                    changeLabel(labelNode: nodeB.childNode(withName: "B") as! SKLabelNode)
                    let width = frame.size.width
                    let rectSize = width / 4
                    let duration: TimeInterval = 0.25/2
                    let moveLeftButton = SKAction.moveBy(x: -rectSize * 2, y: 0, duration: duration)
                    let moveLeftScene = SKAction.moveBy(x: -rectSize * 2, y: 0, duration: duration)
                    nodeBs.run(moveLeftScene)
                    nodeB.run(moveLeftButton, completion: {self.finalMove(rectsize: rectSize, duration: duration)})
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
            let nodeBs: SKShapeNode = self.childNode(withName: "BATTLESCENE") as! SKShapeNode
            let nodeB: SKShapeNode = self.childNode(withName: "BATTLEBUTTON") as! SKShapeNode
            if nodeBs.position.x <= 0 && nodeBs.position.x >= (-rectSize * 2) {
                nodeBs.position.x = nodeBs.position.x + offset
                nodeB.position.x = nodeB.position.x + offset
            } else {
                nodeBs.position.x = nodeBs.position.x + offset
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if buttonTouched == false {
            for _ in touches {
                let width = frame.size.width
                let rectSize = width / 4
                let nodeBs: SKShapeNode = self.childNode(withName: "BATTLESCENE") as! SKShapeNode
                let nodeB: SKShapeNode = self.childNode(withName: "BATTLEBUTTON") as! SKShapeNode
                if nodeBs.position.x > -width/2 {
                    let moveBack = SKAction.moveTo(x: originalBsPosition, duration: 0.25)
                    let moveBackButton = SKAction.moveTo(x: originalButtonPosition, duration: 0.25)
                    nodeBs.run(moveBack)
                    nodeB.run(moveBackButton)
                } else {
                    let moveToScene = SKAction.moveTo(x: -width, duration: 0.25)
                    let moveButtonToScene = SKAction.moveTo(x: -rectSize * 2, duration: 0.25)
                    nodeB.run(moveButtonToScene)
                    nodeBs.run(moveToScene, completion: {self.changeScene()})
                }
            }
        }
    }
}
