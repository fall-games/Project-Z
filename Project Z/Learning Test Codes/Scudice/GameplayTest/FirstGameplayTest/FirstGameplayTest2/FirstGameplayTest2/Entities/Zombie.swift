//
//  Zombie.swift
//  FirstGameplayTest2
//
//  Created by andrea puppa on 07/05/2019.
//  Copyright © 2019 andrea puppa. All rights reserved.
//

import SpriteKit
import GameplayKit

class Zombie: GKEntity {
    
    var generator: GKAgent
    var generatorCenterFloat: float2
    var intialPositionFloat: float2
    var dead: Bool
    init(initialPosition: CGPoint, generatorAgent: GKAgent, generatorCenter: CGPoint) {
        self.generator = generatorAgent
        self.generatorCenterFloat = float2(Float(generatorCenter.x),Float(generatorCenter.y))
        self.intialPositionFloat = float2(Float(initialPosition.x),Float(initialPosition.y))
        let diffX = self.generatorCenterFloat.x - self.intialPositionFloat.x
        let diffY = self.generatorCenterFloat.y - self.intialPositionFloat.y
        let distance = sqrtf(powf(diffX, 2) + powf(diffY, 2))
        dead = false
        super.init()
        let spriteComponent = SpriteComponent(texture: SKTexture(imageNamed: "ZombieSimple2Tiles"))
        spriteComponent.node.name = "ZOMBIE"
        // Calcola direzione dello zombie
        let angle = atan2f(diffY/distance, diffX/distance)
        let moveToTargetAgent = MoveToTargetAgent(maxSpeed: 13, agent: self.generator)
        //applica direzione all agente
        moveToTargetAgent.rotation = angle
        //applica direzione alla grafica
        spriteComponent.node.zRotation = CGFloat(angle - .pi/2)
        addComponent(spriteComponent)
        addComponent(moveToTargetAgent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
