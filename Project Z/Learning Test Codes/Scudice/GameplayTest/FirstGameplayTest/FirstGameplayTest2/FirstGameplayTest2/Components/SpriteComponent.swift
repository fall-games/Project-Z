//
//  SpriteComponent.swift
//  FirstGameplayTest2
//
//  Created by andrea puppa on 07/05/2019.
//  Copyright © 2019 andrea puppa. All rights reserved.
//

import SpriteKit
import GameplayKit

class SpriteComponent: GKComponent {
    // 3
    let node: SKSpriteNode
    
    // 4
    init(texture: SKTexture) {
        node = SKSpriteNode(texture: texture)
        super.init()
    }
    
    // 5
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
