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
    private(set) var hero: Hero?
    private(set) var item: Item?
    
    var hasHero: Bool {
        return hero != nil
    }
    
    var hasItem: Bool {
        return item != nil
    }
    
    func setHero(hero: Hero) {
        self.hero = hero
    }
    
    func setItem(item: Item) {
        self.item = item
    }
    
    static func invalid() -> PartySlot {
        let slot = PartySlot()
        
        slot.hero = nil
        slot.item = nil
        
        return slot
    }
}

class Party {
    
    private let slotCount = 3
    private var slots: [PartySlot]
    
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
            assertionFailure("(🚩) - tried to access hero at invalid index")
            return PartySlot.invalid()
        }
        
        return slots[index]
    }
}
