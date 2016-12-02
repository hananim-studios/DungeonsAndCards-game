//
//  Party.swift
//  DungeonsAndCards
//
//  Created by Gabriela de Carvalho Barros Bezerra on 01/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation

protocol PartyDelegate {
    
    func didHireHero (hero: Hero, atSlot slot: Int)
    func didDismissHero (hero: Hero, atSlot slot: Int)
    
}

class Party {
    
    var heroes: [Hero?] = [nil,nil,nil]
    
    var delegate: PartyDelegate?
    
    //MARK - Implement Protocol Functions
    func hireHero(hero: Hero, atSlot slot: Int) {
        
        heroes[slot] = hero
        
        print("*****\n Heroes:\n\(heroes)\n*****")
        
        delegate?.didHireHero(hero: hero, atSlot: slot)
    }
    
    func dismissHero(hero: Hero, atSlot slot: Int) {
        
        heroes[slot] = nil
        
        delegate?.didDismissHero(hero: hero, atSlot: slot)
        
    }
}
