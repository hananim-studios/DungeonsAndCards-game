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

    var name: String = ""
    var image: String = ""
    var description: String = ""
    var attack: Int = 0
    var health: Int = 0
    var price: Int = 0
    
    static func invalid() -> Hero {
        let hero = Hero()
        hero.isValid = false
        
        hero.name = "Invalid"
        hero.description = "This Hero is the result of an error"
        hero.image = "invalid"
        hero.attack = 0
        hero.health = 0
        hero.price = 0
        
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
        
        
        let price = json["health"].int
        assert(price != nil, "(🚩) - price not found in json")
        self.price = price ?? 1
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
