//
//  Party.swift
//  DungeonsAndCards
//
//  Created by Gabriela de Carvalho Barros Bezerra on 01/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation

protocol PartyDelegate {
    

    
}

class PartySlot: GameObject {
    
    private var hero: Hero?
    private var item: Item?
    
    
    var hasHero: Bool {
        return hero != nil
    }
    
    func getHero() -> Hero {
        
        guard hero != nil else {
            assertionFailure("(🚩) - tried to access hero at slot without hero")
            return Hero.invalid()
        }
        
        return hero!
    }
    
    var onSetHero: ((Hero) -> Void)?
    func setHero(_ hero: Hero) {
        self.hero = hero
        onSetHero?(hero)
    }
    
    var onRemoveHero: (() -> Void)?
    func removeHero() {
        self.hero = nil
        onRemoveHero?()
    }
    
    func getItem() -> Item {
        
        guard item != nil else {
            assertionFailure("(🚩) - tried to access item at slot without item")
            return Item.invalid()
        }
        
        return item!
    }

    var hasItem: Bool {
        return item != nil
    }
    
    var onSetItem: ((Item) -> Void)?
    func setItem(_ item: Item) {
        self.item = item
        onSetItem?(item)
    }
    
    var onRemoveItem: (() -> Void)?
    func removeItem() {
        self.hero = nil
    }
    
    static func invalid() -> PartySlot {
        let slot = PartySlot()
        slot.isValid = false
        
        slot.hero = nil
        slot.item = nil
        
        return slot
    }
}

class Party {
    
    let slotCount = 3
    private var slots: [PartySlot]
    
    var hasHeroes: Bool {
        get {
            for i in 0..<slotCount {
                let hasHero = slot(atIndex: i).hasHero
                
                if hasHero {
                    return true
                }
            }
            
            return false
        }
    }
    
    init() {
        
        slots = [PartySlot]()
        
        for _ in 1...slotCount {
            slots.append(PartySlot())
        }
        
        assert(slots.count == slotCount, "(🚩) - slot count is < slotCount after Party initialization")
    }
    
    func hasSlot(atIndex index: Int) -> Bool {
        return (0...slots.count).contains(index)
    }
    
    func slot(atIndex index: Int) -> PartySlot {
        
        guard hasSlot(atIndex: index) else {
            assertionFailure("(🚩) - tried to access PartySlot at invalid index")
            return PartySlot.invalid()
        }
        
        return slots[index]
    }
}
