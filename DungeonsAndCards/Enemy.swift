//
//  Enemy.swift
//  DungeonsAndCards
//
//  Created by Gabriela de Carvalho Barros Bezerra on 01/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import SwiftyJSON

class Enemy: GameObject {
    
    var name: String = "Uninitialized Hero"
    var description: String = "This Hero is uninitialized"
    var image: String = "invalid"
    var attack: Int = 1
    var health: Int = 1
    var reward: Int = 1
    
    static func invalid() -> Enemy {
        let enemy = Enemy()
        enemy.isValid = false
        
        enemy.name = "Invalid"
        enemy.description = "This Enemy is the result of an error"
        enemy.image = "invalid"
        enemy.attack = 1
        enemy.health = 1
        enemy.reward = 1
        
        return enemy
    }
    
    private override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        let name = json["name"].string
        assert(name != nil, "(🚩) - name not found in json")
        self.name = name ?? "JSON Error"
        
        let description = json["description"].string
        assert(description != nil, "(🚩) - description not found in json")
        self.description = description ?? "JSON Error"
        
        let image = json["image"].string
        assert(image != nil, "(🚩) - image not found in json")
        self.image = image ?? "jsonerror"
        
        let attack = json["attack"].int
        assert(attack != nil, "(🚩) - attack not found in json")
        self.attack = attack ?? 1
        
        let health = json["health"].int
        assert(health != nil, "(🚩) - health not found in json")
        self.health = health ?? 1
        
        
        let reward = json["reward"].int
        assert(reward != nil, "(🚩) - reward not found in json")
        self.reward = reward ?? 1
    }
}

extension Enemy: Equatable {
    static func == (lhs: Enemy, rhs: Enemy) -> Bool {
        if lhs.name == rhs.name {
            return true
        } else {
            return false
        }
    }
}
