//
//  MoveBehavior.swift
//  FirstGameplayTest2
//
//  Created by andrea puppa on 07/05/2019.
//  Copyright © 2019 andrea puppa. All rights reserved.
//

import SpriteKit
import GameplayKit

class MoveBehavior: GKBehavior {
    init(targetSpeed: Float, seek: GKAgent) {
        super.init()
        // 2
        if targetSpeed > 0 {
            // 3
            setWeight(1.0, for: GKGoal(toReachTargetSpeed: targetSpeed))
            // 4
            setWeight(0.5, for: GKGoal(toSeekAgent: seek))
        }
    }
}
