//
//  Generator.swift
//  FirstGameplayTest2
//
//  Created by andrea puppa on 07/05/2019.
//  Copyright © 2019 andrea puppa. All rights reserved.
//

import SpriteKit
import GameplayKit

class Generator: GKEntity {
    
    //initialisation
    var centerOffset: CGPoint
    init(center: CGPoint) {
        centerOffset = center
        super.init()
        let tileSize = CGFloat(13)
        let genSize = tileSize/2
        let staticSpriteComponent = StaticSpriteComponent(name: "Generator", center: center, color: UIColor.yellow, size: genSize)
        staticSpriteComponent.generator.lineWidth = 2
        staticSpriteComponent.generator.strokeColor = UIColor.black
        //Agents use float instead of CGFloat
        let floatX = Float(center.x)
        let floatY = Float(center.y)
        let flatCenterOffset = float2(floatX,floatY)
        let lightAgent = LightAgent()
        lightAgent.setPosition(centerOffset: flatCenterOffset)
        addComponent(staticSpriteComponent)
        addComponent(lightAgent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
