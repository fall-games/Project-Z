//
//  LightAgent.swift
//  FirstGameplayTest2
//
//  Created by andrea puppa on 07/05/2019.
//  Copyright © 2019 andrea puppa. All rights reserved.
//

import SpriteKit
import GameplayKit

// 1
class LightAgent: GKAgent2D, GKAgentDelegate {
    
    func setPosition(centerOffset: float2) {
        self.position = float2(centerOffset)
    }
}
