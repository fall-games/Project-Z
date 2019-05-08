//
//  StaticSpriteComponent.swift
//  FirstGameplayTest2
//
//  Created by andrea puppa on 07/05/2019.
//  Copyright © 2019 andrea puppa. All rights reserved.
//

import SpriteKit
import GameplayKit

class Survivor: GKEntity {
    
    //initialisation
    var centerOffset: CGPoint
    init(initialPosition: CGPoint) {
        centerOffset = initialPosition
        super.init()
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: "SurvivorSimple"))
        spriteComponent.node.name = "SURVIVOR"
        let floatX = Float(initialPosition.x)
        let floatY = Float(initialPosition.y)
        let flatCenterOffset = float2(floatX,floatY)
        let lightAgent = LightAgent()
        lightAgent.setPosition(centerOffset: flatCenterOffset)
        addComponent(spriteComponent)
        addComponent(lightAgent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
