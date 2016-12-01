//
//  Hero.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 11/23/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import SwiftyJSON

class Hero {

//    var template: String = "default"
//    
//    var attack: Int = 0
//    var health: (current: Int, total: Int) = (0, 0)
//    
//    init(withTemplate template: String) {
//        self.template = template
//    }

    var name: String?
    var description: String?
    var pic: String?
    var damage: Int?
    var health: Int?
    var gold: Int?
    
    init(json: JSON) {
        
        if let name = json["name"].string {
            self.name = name
        } else {
            fatalError("Malformed JSON")
        }
        
        if let description = json["description"].string {
            self.description = description
        } else {
            fatalError("Malformed JSON")
        }
        
        if let pic = json["pic"].string {
            self.pic = pic
        } else {
            fatalError("Malformed JSON")
        }
        
        if let damage = json["damage"].int {
            self.damage = damage
        } else {
            fatalError("Malformed JSON")
        }
        
        if let health = json["health"].int {
            self.health = health
        } else {
            fatalError("Malformed JSON")
        }
        
        if let gold = json["gold"].int {
            self.gold = gold
        } else {
            fatalError("Malformed JSON")
        }
        
    }

}
