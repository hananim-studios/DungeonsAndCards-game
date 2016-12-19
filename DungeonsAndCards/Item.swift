//
//  Item.swift
//  DungeonsAndCards
//
//  Created by Gabriela de Carvalho Barros Bezerra on 01/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import SwiftyJSON

class ItemEffect {
    
    enum Effect: String {
        case None = "none"
        case AddHealth = "addHealth"
        case AddDamage = "addDamage"
        case SuperArmor = "superArmor"
    }
    
    let effect: Effect
    let value: Int
    
    init(withEffectName effectName: String, andValue value: Int) {
        
        self.effect = Effect(rawValue: effectName) ?? .None
        self.value = value
    }
    
    init(withEffect effect: Effect, andValue value: Int) {
        
        self.effect = effect
        self.value = value
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
        self.effects = effects?.map { ItemEffect(withEffectName: $0.key, andValue: $0.value.intValue) } ?? []
    }
    
    init(withUserDefaultsKey key: String) {
        
        let dict = UserDefaults.standard.dictionary(forKey: key)
        
        self.effects = []
        
        if let dict = dict {
            
            let name = dict["name"] as? String
            assert(name != nil, "(🚩) - name not found in UserDefaults")
            self.name = name ?? "UserDefaults Error"
            
            let image = dict["image"] as? String
            assert(image != nil, "(🚩) - image not found in UserDefaults")
            self.image = image ?? "userdefaultserror"
            
            let price = dict["price"] as? Int
            assert(price != nil, "(🚩) - price not found in UserDefaults")
            self.price = price ?? 1
            
            guard let effectCount = dict["effectCount"] as? Int else {
                assertionFailure("(🚩) - effect count not found in UserDefaults")
                return
            }
            
            guard let effectNames = dict["effectNames"] as? [String] else {
                assertionFailure("(🚩) - effect names not found in UserDefaults")
                return
            }
            
            guard let effectValues = dict["effectValues"] as? [Int] else {
                assertionFailure("(🚩) - effect names not found in UserDefaults")
                return
            }
            
            guard effectCount == effectNames.count && effectCount == effectValues.count else {
                assertionFailure("(🚩) - effects data mismatch")
                return
            }
            
            for i in 0..<effectCount {
                
                self.effects.append(ItemEffect(withEffectName: effectNames[i], andValue: effectValues[i]))
            }
        }
    }
    
    func save(toUserDefaultsKey key: String) {
        
        var dict = [String: Any]()
        
        dict.updateValue(self.name, forKey: "name")
        dict.updateValue(self.image, forKey: "image")
        dict.updateValue(self.price, forKey: "price")
        
        dict.updateValue(self.effects.count, forKey: "effectCount")
        dict.updateValue(self.effects.map {
            effect in
            
            return effect.effect.rawValue
        }, forKey: "effectNames")
        dict.updateValue(self.effects.map {
            effect in
            
            return effect.value
        }, forKey: "effectValues")
        
        UserDefaults.standard.set(dict, forKey: key)
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

