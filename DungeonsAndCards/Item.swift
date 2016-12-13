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

class Item: GameObject {
    
    var name: String = "Uninitialized Item"
    var image: String = "invalid"
    var price: Int = 1
    var effects: [ItemEffect] = []
    
    static func invalid() -> Item {
        let item = Item()
        item.isValid = false
        
        item.name = "Invalid Item"
        item.image = "invalid"
        item.price = 1
        
        return item
    }
    
    private override init() {
        super.init()
    }
    
    init(json: JSON) {
        
        let name = json["name"].string
        assert(name != nil, "(🚩) - name not found in json")
        self.name = name ?? "JSON Error"
        
        let image = json["image"].string
        assert(image != nil, "(🚩) - image not found in json")
        self.image = image ?? "jsonerror"
        
        let price = json["price"].int
        assert(price != nil, "(🚩) - price not found in json")
        self.price = price ?? 1
        
        let effects = json["effects"].dictionary
        assert(price != nil, "(🚩) - effects not found in json")
        self.effects = effects?.map { ItemEffect(tuple: $0) } ?? []
    }
}

extension Item: Equatable {
    static func == (lhs:Item, rhs:Item) -> Bool {
        if lhs.name == rhs.name {
            return true
        } else {
            return false
        }
    }
}

