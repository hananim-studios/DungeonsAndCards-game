//
//  ItemShop.swift
//  DungeonsAndCards
//
//  Created by Gabriela de Carvalho Barros Bezerra on 08/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import SwiftyJSON

class ItemShop {
    
    let itemCount = 5
    private var items : [Item]
    
    init() {
        
        self.items = []
        
        for i in 0..<itemCount {
            
            items.append(ItemsJSON.itemAtIndex(index: i))
        }
    }
    
    init(withUserDefaultsKey key: String) {
        
        self.items = []
        
        if let itemCount = UserDefaults.standard.value(forKey: "\(key).itemCount") as? Int {
            for i in 0..<itemCount {
                items.append(Item(withUserDefaultsKey: "\(key).item\(i)"))
            }
        } else {
            assertionFailure("(🚩) - \(key).itemCount not found in UserDefaults")
        }
    }
    
    func save(toUserDefaultsKey key: String) {
        UserDefaults.standard.set(itemCount, forKey: "\(key).itemCount")
        for i in 0..<itemCount {
            items[i].save(toUserDefaultsKey: "\(key).item\(i)")
        }
    }
    
    func hasItem(atIndex index: Int) -> Bool {
        return (0...items.count).contains(index)
    }
    
    func item(atIndex index: Int) -> Item {
        
        guard hasItem(atIndex: index) else {
            assertionFailure("(🚩) - tried to access item at invalid index")
            return Item.invalid()
        }
        
        return items[index]
    }
    
    var onSetItemAtIndex: ((Item, Int) -> Void)?
    func setItem(_ item: Item, atIndex index: Int) {
        
        guard hasItem(atIndex: index) else {
            
            assertionFailure("(🚩) - tried to set item at invalid index")
            return
        }
        
        
        items[index] = item
    }
    
    func price(forHeroAtIndex index: Int) -> Int {
        
        return item(atIndex: index).price
    }
}
