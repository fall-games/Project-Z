//
//  MoveToLightAgent.swift
//  FirstGameplayTest2
//
//  Created by andrea puppa on 07/05/2019.
//  Copyright © 2019 andrea puppa. All rights reserved.
//

import SpriteKit
import GameplayKit

// 1
class MoveToTargetAgent: GKAgent2D, GKAgentDelegate {
    
    var generator: GKAgent
    
    init(maxSpeed: Float, agent: GKAgent) {
        self.generator = agent
        super.init()
        delegate = self
        self.maxSpeed = maxSpeed
        self.mass = 0.01
        self.speed = maxSpeed
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func agentWillUpdate(_ agent: GKAgent) {
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
            return
        }
        //Set the agent position in the node position, befer update
         self.position = float2(Float(spriteComponent.node.position.x), Float(spriteComponent.node.position.y))
    }
    
    func agentDidUpdate(_ agent: GKAgent) {
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
            return
        }
        //The Agent updated his position, so set the node position to the agent position
        spriteComponent.node.position = CGPoint(x: CGFloat(self.position.x), y: CGFloat(self.position.y))
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        behavior = MoveBehavior(targetSpeed: maxSpeed, seek: generator)
    }
}
