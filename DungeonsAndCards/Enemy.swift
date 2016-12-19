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
    
    var name: String = "Uninitialized Enemy"
    var description: String = "This Enemy is uninitialized"
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
    
    init(withUserDefaultsKey key: String) {
        
        let dict = UserDefaults.standard.dictionary(forKey: key)
        
        if let dict = dict {
            
            let name = dict["name"] as? String
            assert(name != nil, "(🚩) - name not found in UserDefaults")
            self.name = name ?? "UserDefaults Error"
            
            let description = dict["description"] as? String
            assert(description != nil, "(🚩) - description not found in json")
            self.description = description ?? "UserDefaults Error"
            
            let image = dict["image"] as? String
            assert(image != nil, "(🚩) - image not found in UserDefaults")
            self.image = image ?? "userdefaultserror"
            
            let attack = dict["attack"] as? Int
            assert(attack != nil, "(🚩) - attack not found in UserDefaults")
            self.attack = attack ?? 1
            
            let health = dict["health"] as? Int
            assert(health != nil, "(🚩) - health not found in UserDefaults")
            self.health = health ?? 1
            
            
            let reward = dict["reward"] as? Int
            assert(reward != nil, "(🚩) - price not found in UserDefaults")
            self.reward = reward ?? 1
        }
    }
    
    func save(toUserDefaultsKey key: String) {
        
        var dict = [String: Any]()
        
        dict.updateValue(self.name, forKey: "name")
        dict.updateValue(self.description, forKey: "description")
        dict.updateValue(self.image, forKey: "image")
        dict.updateValue(self.attack, forKey: "attack")
        dict.updateValue(self.health, forKey: "health")
        dict.updateValue(self.reward, forKey: "reward")
        
        UserDefaults.standard.set(dict, forKey: key)
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
