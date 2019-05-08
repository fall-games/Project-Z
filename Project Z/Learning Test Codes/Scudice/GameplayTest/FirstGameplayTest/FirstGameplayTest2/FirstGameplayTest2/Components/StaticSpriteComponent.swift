//
//  StaticSpriteComponent.swift
//  FirstGameplayTest2
//
//  Created by andrea puppa on 07/05/2019.
//  Copyright © 2019 andrea puppa. All rights reserved.
//

import SpriteKit
import GameplayKit

class StaticSpriteComponent: GKComponent {
    // 3
    let generator: SKShapeNode
    let center: CGPoint
    
    // 4
    init(name: String, center: CGPoint, color: UIColor, size: CGFloat) {
        let tileSize = CGFloat(13)
        let genSize = tileSize/2
        generator = SKShapeNode()
        generator.name = name
        self.center = center
        let shapeScene = UIBezierPath()
        let midX = center.x
        let midY = center.y
        //creo la parte nera
        let shapeOrigin = CGPoint(x: midX - genSize, y: midY - genSize)
        shapeScene.move(to: shapeOrigin)
        shapeScene.addLine(to: CGPoint(x: midX - size, y: midY + size))
        shapeScene.addLine(to: CGPoint(x: midX + size, y: midY + size))
        shapeScene.addLine(to: CGPoint(x: midX + size, y: midY - size))
        shapeScene.addLine(to: CGPoint(x: midX - size, y: midY - size))
        shapeScene.close()
        generator.path = shapeScene.cgPath
        generator.strokeColor = color
        generator.fillColor = color
        super.init()
    }
    
    // 5
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
