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
    
    let heroMaxCount = 5
    
    var heroCount: Int {
        return heroes.count
    }
    private var heroes : [Hero]
    
    init() {
        self.heroes = []
        
        loadHeroes(forLevel: 0)
    }
    
    init(withUserDefaultsKey key: String) {
        
        self.heroes = []
        
        if let heroCount = UserDefaults.standard.value(forKey: "\(key).heroCount") as? Int {
            for i in 0..<heroCount {
                heroes.append(Hero(withUserDefaultsKey: "\(key).hero\(i)"))
            }
        } else {
            assertionFailure("(🚩) - heroCount not found in UserDefaults")
        }
    }
    
    func save(toUserDefaultsKey key: String) {
        UserDefaults.standard.set(heroCount, forKey: "\(key).heroCount")
        for i in 0..<heroCount {
            heroes[i].save(toUserDefaultsKey: "\(key).hero\(i)")
        }
    }
    
    func loadHeroes(forLevel: Int) {
        
        self.heroes.removeAll()
        
        for i in heroCount..<heroMaxCount {
            
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
    
    var onRemoveHeroAtIndex: ((Int) -> Void)?
    func removeHero(atIndex index: Int) {
        
        guard hasHero(atIndex: index) else {
            
            assertionFailure("(🚩) - tried to remove hero at invalid index")
            return
        }
        
        heroes.remove(at: index)
        onRemoveHeroAtIndex?(index)
    }
    
    func price(forHeroAtIndex index: Int) -> Int {
        
        return hero(atIndex: index).price
    }
}


