//
//  Item.swift
//  DungeonsAndCards
//
//  Created by Gabriela de Carvalho Barros Bezerra on 01/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import SwiftyJSON

enum ItemEffect {
    
    case None
    
    case AddHealth(value: Int)
    
    case AddDamage(value: Int)
    
    case SuperArmor(value: Int)
    
    init(tuple: (key: String, value: JSON)) {
        
        switch(tuple.key) {
            
        case "addHealth":
            self = .AddHealth(value: tuple.value.intValue)
            
        case "addDamage":
            self = .AddDamage(value: tuple.value.intValue)
            
        case "superArmor":
            self = .SuperArmor(value: tuple.value.intValue)
            
        default:
            self = .None
        }
    }
    
    
}

class Item {
    
    var name: String
    var pic: String
    var gold: Int
    var effects: [ItemEffect] = []
    
    init(json: JSON) {
        
        if let name = json["name"].string {
            self.name = name
        } else {
            fatalError("Malformed JSON")
        }
        
        if let pic = json["pic"].string {
            self.pic = pic
        } else {
            fatalError("Malformed JSON")
        }
        
        if let gold = json["gold"].int {
            self.gold = gold
        } else {
            fatalError("Malformed JSON")
        }
        
        if let effect = json["effects"].dictionary {
            for effectJson in effect {
                self.effects.append(ItemEffect(tuple: effectJson))
            }
        }
    }
}

