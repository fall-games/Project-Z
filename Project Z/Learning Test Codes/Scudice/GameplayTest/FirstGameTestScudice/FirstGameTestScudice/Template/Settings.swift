//
//  Settings.swift
//  FirstGameTestScudice
//
//  Created by andrea puppa on 29/04/2019.
//  Copyright © 2019 andrea puppa. All rights reserved.
//

import SpriteKit

enum PhysicsCategories {
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1
    static let switchCategory: UInt32 = 0x1 << 1
}

enum ZPositions {
    static let lable: CGFloat = 0
    static let ball: CGFloat = 1
    static let colorSwitch: CGFloat = 2
}
