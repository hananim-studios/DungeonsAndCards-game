//
//  Hero.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 11/23/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import SwiftyJSON

class Hero: GameObject {

    var name: String = "Uninitialized Hero"
    var image: String = "invalid"
    var description: String = "This Hero is uninitialized"
    var attack: Int = 1
    var health: Int = 1
    var price: Int = 1
    
    static func invalid() -> Hero {
        let hero = Hero()
        hero.isValid = false
        
        hero.name = "Invalid Hero"
        hero.description = "This Hero is the result of an error"
        hero.image = "invalid"
        hero.attack = 1
        hero.health = 1
        hero.price = 1
        
        return hero
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
        
        
        let price = json["price"].int
        assert(price != nil, "(🚩) - price not found in json")
        self.price = price ?? 1
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
            
            
            let price = dict["price"] as? Int
            assert(price != nil, "(🚩) - price not found in UserDefaults")
            self.price = price ?? 1
        }
    }
    
    func save(toUserDefaultsKey key: String) {
        
        var dict = [String: Any]()
        
        dict.updateValue(self.name, forKey: "name")
        dict.updateValue(self.description, forKey: "description")
        dict.updateValue(self.image, forKey: "image")
        dict.updateValue(self.attack, forKey: "attack")
        dict.updateValue(self.health, forKey: "health")
        dict.updateValue(self.price, forKey: "price")
        
        UserDefaults.standard.set(dict, forKey: key)
    }

}

extension Hero: Equatable {
    static func == (lhs:Hero, rhs:Hero) -> Bool {
        if lhs.name == rhs.name {
            return true
        } else {
            return false
        }
    }
}
