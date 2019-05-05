//
//  GameScene.swift
//  ScenesTest
//
//  Created by andrea puppa on 01/05/2019.
//  Copyright © 2019 andrea puppa. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var originalTouchPosition = CGFloat()
    var originalHsPosition = CGFloat()
    var originalButtonPosition = CGFloat()
    var buttonTouched = false
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.black
        layoutHomeScene()
        addHomeScreenButton()
        addHomeScene()
        }
    
    func layoutHomeScene() {
        //Codice per creare la scena della home
        //inizio
        let battleScreen = SKShapeNode()
        battleScreen.name = "BATTLESCREEN"
        let shapeBs = UIBezierPath()
        let shapeOrigin = CGPoint(x: view!.bounds.minX, y: view!.bounds.minY)
        shapeBs.move(to: shapeOrigin)
        shapeBs.addLine(to: CGPoint(x: view!.bounds.minX, y: view!.bounds.maxY))
        shapeBs.addLine(to: CGPoint(x: view!.bounds.maxX, y: view!.bounds.maxY))
        shapeBs.addLine(to: CGPoint(x: view!.bounds.maxX, y: view!.bounds.minY))
        shapeBs.addLine(to: CGPoint(x: view!.bounds.minX, y: view!.bounds.minY))
        shapeBs.close()
        battleScreen.path = shapeBs.cgPath
        battleScreen.fillColor = UIColor.black
        battleScreen.strokeColor = UIColor.black
        battleScreen.zPosition = 0
        //Aggiungo etichetta HOME
        let battle = SKLabelNode(text: "BATTLE")
        battle.name = "BATTLE"
        battle.fontName = "AvenirNext-Bold"
        battle.fontSize = 50.0
        battle.fontColor = UIColor.white
        battle.position = CGPoint(x: frame.midX, y: frame.midY)
        battle.zPosition = 1
        battleScreen.addChild(battle)
        
        //fine
        addChild(battleScreen)
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
    
    func changeScene() {
        let menuScene = MenuScene(size: view!.bounds.size)
        view!.presentScene(menuScene)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            originalTouchPosition = location.x
            let nodeH: SKShapeNode = self.childNode(withName: "HOMEBUTTON") as! SKShapeNode
            let frameH = nodeH.calculateAccumulatedFrame()
            let minX = frameH.minX
            let maxX = frameH.maxX
            let minY = frameH.minY
            let maxY = frameH.maxY
            let nodeHs: SKShapeNode = self.childNode(withName: "HOMESCENE") as! SKShapeNode
            originalHsPosition = nodeHs.position.x
            originalButtonPosition = nodeH.position.x
            if location.x > minX && location.x < maxX {
                if location.y > minY && location.y < maxY {
                    buttonTouched = true
                    let width = frame.size.width
                    let rectSize = width / 4
                    let moveRightButton = SKAction.moveBy(x: rectSize * 2, y: 0, duration: 0.25)
                    let moveRightScene = SKAction.moveBy(x: width, y: 0, duration: 0.25)
                    nodeHs.run(moveRightScene)
                    nodeH.run(moveRightButton, completion: {self.changeScene()})
                    
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let width = frame.size.width
            let rectSize = width / 4
            let ratio = width/rectSize
            let location = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            let offset = location.x - previousLocation.x
            let nodeHs: SKShapeNode = self.childNode(withName: "HOMESCENE") as! SKShapeNode
            let nodeH: SKShapeNode = self.childNode(withName: "HOMEBUTTON") as! SKShapeNode
            if nodeHs.position.x >= 0 && nodeHs.position.x <= width {
                nodeHs.position.x = nodeHs.position.x + offset
                nodeH.position.x = nodeH.position.x + (offset/ratio)
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
                    nodeHs.run(moveToScene, completion: {self.changeScene()})
                }
            }
        }
    }
}
