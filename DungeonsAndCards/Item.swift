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
    
    case addHealth(value: Int)
    
    case addDamage(value: Int)
    
    case SuperArmor(value: Int)
    
    init(tuple: (key: String, value: JSON)) {
        
        switch(tuple.key) {
            
        case "addHealth":
            self = .addHealth(value: tuple.value.intValue)
            
        case "greatAttack":
            self = .addDamage(value: tuple.value.intValue)
            
        case "superArmor":
            self = .SuperArmor(value: tuple.value.intValue)
            
        default:
            self = .None
        }
    }
    
    
}

class Item {
    
    var name: String?
    var pic: String?
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
        
        if let effect = json["effects"].dictionary {
            for effectJson in effect {
                self.effects.append(ItemEffect(tuple: effectJson))
            }
        }
    }
}

