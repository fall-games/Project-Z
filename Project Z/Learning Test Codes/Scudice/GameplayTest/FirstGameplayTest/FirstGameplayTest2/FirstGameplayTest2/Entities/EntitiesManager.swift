//
//  EntitiesManager.swift
//  FirstGameplayTest2
//
//  Created by andrea puppa on 07/05/2019.
//  Copyright © 2019 andrea puppa. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class EntitiesManager {
    
    //Inizializzo le variabili per gli input
    var generatorCenter: CGPoint
    var gameScene: SKScene
    var generatorAgent: GKAgent
    var survivorAgent: GKAgent
    var survivorCenter: CGPoint
    var toRemove = Set<GKEntity>()
    var survivorExists: Bool = false
    
    lazy var componentSystems: [GKComponentSystem] = {
        let moveToTargetSystem = GKComponentSystem(componentClass: MoveToTargetAgent.self)
        return [moveToTargetSystem]
    }()
    
    init(scene: SKScene, generatorCenter: CGPoint) {
        self.generatorCenter = generatorCenter
        self.gameScene = scene
        self.generatorAgent = GKAgent()
        self.survivorAgent = GKAgent()
        self.survivorCenter = CGPoint()
        spawnGenerator()
    }
    
    //funzione per creare il quadrato giallo al centro del bunker
    func spawnGenerator() {
        let generator = Generator(center: self.generatorCenter)
        let generatorSpriteNode = (generator.component(ofType: StaticSpriteComponent.self)?.generator)!
        self.generatorAgent = (generator.component(ofType: LightAgent.self))!
        generatorSpriteNode.zPosition = 3
        self.gameScene.addChild(generatorSpriteNode)
    }
    
    //unzione per creare gli zombies
    func spawnZombie(initialPosition: CGPoint, generatorCenter: CGPoint) {
        let zombie = Zombie(initialPosition: initialPosition, generatorAgent: self.generatorAgent, generatorCenter: self.generatorCenter)
        self.add(zombie)
        let zombieSpriteNode = (zombie.component(ofType: SpriteComponent.self)?.node)!
        zombieSpriteNode.position = initialPosition
        zombieSpriteNode.zPosition = 3
        self.gameScene.addChild(zombieSpriteNode)
    }
    
    //funzione per creare il sopravvissuto
    func spawnSurvivor(initialPosition: CGPoint) {
        let survivor = Survivor(initialPosition: initialPosition)
        let survivorSpriteNode = (survivor.component(ofType: SpriteComponent.self)?.node)!
        self.generatorAgent = (survivor.component(ofType: LightAgent.self))!
        self.survivorCenter = initialPosition
        survivorSpriteNode.position = initialPosition
        survivorSpriteNode.zPosition = 3
        self.gameScene.addChild(survivorSpriteNode)
    }
    
    //Funzione carpire se il sopravvissuto esiste o no
    func updateZombieDirection() {
        for zombie in zombies {
            let diffX = Float(self.survivorCenter.x) - (zombie.component(ofType: MoveToTargetAgent.self)?.position.x)!
            let diffY = Float(self.survivorCenter.y) - (zombie.component(ofType: MoveToTargetAgent.self)?.position.y)!
            let distance = sqrtf(powf(diffX, 2) + powf(diffY, 2))
            let angle = atan2f(diffY/distance, diffX/distance)
            //applica direzione all agente
            zombie.component(ofType: MoveToTargetAgent.self)?.rotation = angle
            //applica direzione alla grafica
            zombie.component(ofType: SpriteComponent.self)?.node.zRotation = CGFloat(angle - .pi/2)
        }
    }
    
    func addZombie(zombie: Zombie) {
        
    }
    var zombies = Set<Zombie>()
    
    // 3
    func add(_ zombie: Zombie) {
        zombies.insert(zombie)
        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: zombie)
        }
    }
    
    // 4
    func remove(_ zombie: Zombie) {
        zombies.remove(zombie)
        zombie.component(ofType: SpriteComponent.self)?.node.removeFromParent()
        toRemove.insert(zombie)
    }
    
    func moveToLight() -> [MoveToTargetAgent] {
        var TotalMoves = [MoveToTargetAgent]()
        for zombie in zombies {
            if let moveToLight = zombie.component(ofType: MoveToTargetAgent.self) {
                TotalMoves.append(moveToLight)
            }
        }
        return TotalMoves
    }
    
    func update(_ deltaTime: CFTimeInterval) {
        
        for zombie in zombies {
            let diffX = zombie.generatorCenterFloat.x - (zombie.component(ofType: MoveToTargetAgent.self)?.position.x)!
            let diffY = zombie.generatorCenterFloat.y - (zombie.component(ofType: MoveToTargetAgent.self)?.position.y)!
            let distance = sqrtf(powf(diffX, 2) + powf(diffY, 2))
            if distance <= (13/2) {
                self.remove(zombie)
            }
        }
        
        // Aggiorna la posizione degli zombies
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }
        
        // Elimina zombies morti
        for currentRemove in toRemove {
            for componentSystem in componentSystems {
                componentSystem.removeComponent(foundIn: currentRemove)
            }
        }
        
        //rimuovi
        toRemove.removeAll()
    }
}
