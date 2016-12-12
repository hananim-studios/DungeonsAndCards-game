//
//  HeroShop.swift
//  DungeonsAndCards
//
//  Created by Gabriela de Carvalho Barros Bezerra on 01/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import SwiftyJSON

class HeroShop {
    
    let heroCount = 5
    private var heroes : [Hero]
    
    init() {
        
        self.heroes = []
        
        for i in 0..<heroCount {
            
            heroes.append(HeroesJSON.heroAtIndex(index: i))
        }
    }
    
    func hasHero(atIndex index: Int) -> Bool {
        return (0...heroes.count).contains(index)
    }
    
    func hero(atIndex index: Int) -> Hero {
        
        guard hasHero(atIndex: index) else {
            assertionFailure("(🚩) - tried to access hero at invalid index")
            return Hero.invalid()
        }
        
        return heroes[index]
    }
    
    var onSetHeroAtIndex: ((Hero, Int) -> Void)?
    func setHero(_ hero: Hero, atIndex index: Int) {
        
        guard hasHero(atIndex: index) else {
            
            assertionFailure("(🚩) - tried to set hero at invalid index")
            return
        }
        
        heroes[index] = hero
        onSetHeroAtIndex?(hero, index)
    }
    
    func price(forHeroAtIndex index: Int) -> Int {
        
        return hero(atIndex: index).price
    }
}


