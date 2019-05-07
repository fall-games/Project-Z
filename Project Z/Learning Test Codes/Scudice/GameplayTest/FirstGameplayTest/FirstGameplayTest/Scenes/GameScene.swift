//
//  GameScene.swift
//  FirstGameplayTest
//
//  Created by andrea puppa on 05/05/2019.
//  Copyright © 2019 andrea puppa. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        interfaceSks()
    }
    
    func interfaceSks() {
        let floor: SKTileMapNode = childNode(withName: "FloorTileGrid") as! SKTileMapNode
        let floorPosition = floor.position
        print(floorPosition)
        let floorFrame = floor.frame
        print(floorFrame)
        print(self.frame)
        print(self.view!.frame)
    }
}
