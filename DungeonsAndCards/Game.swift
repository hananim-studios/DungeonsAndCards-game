//
//  Game.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 11/23/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol GameDelegate {
    func game(_ game: Game, changedGoldTo gold: Int)
    func game(_ game: Game, didHireHero hero: Hero, atSlot slot: Int)
    func game(_ game: Game, didSwapHero selectedHeroIndex: Int, swapHeroIndex: Int)
    func game(_ game: Game, didDismissHero hero: Hero, atSlot slot: Int)
    func game(_ game: Game, didBuyItem item: Item, atSlot slot: Int)
}

class Game {
    
    var delegate: GameDelegate?

    var gold: Int = 200
    
    var dungeonLevel: Int = 0
    
    var hand: Hand
    
    var party: Party
    
    var itemShop: ItemShop
    
    
    init(){
        if !HeroesJSON.load()  { fatalError("Unable to load heroes.json") }
        if !ItemsJSON.load()   { fatalError("Unable to load items.json") }
        if !EnemiesJSON.load() { fatalError("Unable to load enemies.json") }
        
        self.hand = Hand()
        self.party = Party()
        self.itemShop = ItemShop()
    }
    
}

extension Game {
    
    static var sharedInstance = Game()
    
    //MARK - Implement Protocol Functions
    func hireHero(hero: Hero, atSlot slot: Int) {
        
        if self.gold >= hero.gold {
            
            self.gold -= hero.gold
            
            self.party.heroes[slot] = hero
    
//            for i in 0...self.hand.heroes.count-1{
//                if self.hand.heroes[i] == hero {
//                  //self.hand.heroes[i] = nil
//                    self.hand.heroes.remove(at: i)
//                    return
//                }
//            }
        
            delegate?.game(self, didHireHero: hero, atSlot: slot)
            delegate?.game(self, changedGoldTo: self.gold)
        }
    }
    
    func dismissHero(hero: Hero, atSlot slot: Int) {
            
        self.party.heroes[slot] = nil
        
        delegate?.game(self, didDismissHero: hero, atSlot: slot)
    }
    
    func swapHero(heroAt selectedIndex: Int, withHeroAtIndex swapIndex: Int){
        
        let swap = self.party.heroes[selectedIndex]
        self.party.heroes[selectedIndex] = self.party.heroes[swapIndex]
        self.party.heroes[swapIndex] = swap
        
        delegate?.game(self, didSwapHero: selectedIndex, swapHeroIndex: swapIndex)
    }
    
    func buyItem(item: Item, atSlot slot: Int) {
        if self.gold >= item.gold {
            
            self.gold -= item.gold
            
            self.itemShop.items[slot] = item
            
            delegate?.game(self, didBuyItem: item, atSlot: slot)
            delegate?.game(self, changedGoldTo: self.gold)
        }
    }
}
