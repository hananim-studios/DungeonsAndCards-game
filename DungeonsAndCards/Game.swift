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
    func game(_ game: Game, didUseItem item: Item, onHeroAtSlot slot: Int)
    
    func game(_ game: Game, didAttack slot: Int)
    
}

extension GameDelegate {
    
    // Gold
    func game(_ game: Game, changedGoldTo gold: Int){
    }
    
    // Hero
    func game(_ game: Game, didHireHero hero: Hero, atSlot slot: Int){
    }
    func game(_ game: Game, didSwapHero selectedHeroIndex: Int, swapHeroIndex: Int){
    }
    func game(_ game: Game, didDismissHero hero: Hero, atSlot slot: Int){
    }
    
    // Item
    func game(_ game: Game, didBuyItem item: Item, atSlot slot: Int){
    }
    func game(_ game: Game, didUseItem item: Item, onHeroAtSlot slot: Int){
    }
    
    //Battle
    func game(_ game: Game, didAttack slot: Int){
    }
    
}

class Game {
    
    var delegate: GameDelegate?

    var gold: Int = 200
    
    var dungeonLevel: Int = 0
    
    var hand: Hand
    var party: Party
    
    var itemShop: ItemShop
    var itemBag: ItemBag

    var dungeon: Dungeon
    
    init(){
        if !HeroesJSON.load()  { fatalError("Unable to load heroes.json") }
        if !ItemsJSON.load()   { fatalError("Unable to load items.json") }
        if !EnemiesJSON.load() { fatalError("Unable to load enemies.json") }
        
        self.hand = Hand()
        self.party = Party()
        
        self.itemShop = ItemShop()
        self.itemBag = ItemBag()
    
        self.dungeon = Dungeon()
    }
    
}

extension Game {
    
    static var sharedInstance = Game()
    
    //MARK - Implement Protocol Functions
    func hireHero(hero: Hero, atSlot slot: Int) {
        
        if self.gold >= hero.gold {
            
            self.gold -= hero.gold
            
            self.party.heroes[slot] = hero
    
/// Remove hired hero from hand
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
            
            self.itemBag.bag[slot] = item
            
            delegate?.game(self, didBuyItem: item, atSlot: slot)
            delegate?.game(self, changedGoldTo: self.gold)
        }
    }
    
    func useItem(item: Item, onHeroAtSlot slot: Int){
        for effect in item.effects {
            switch effect {
            case let .AddHealth(value: health):
                self.party.heroes[slot]?.health += health
                break
            case let .AddDamage(value: damage):
                self.party.heroes[slot]?.damage += damage
                break
            case let .SuperArmor(value: superArmor):
                self.party.heroes[slot]?.health += superArmor
                break
            default:
                print("unknown effect")
                break
            }
        }
        self.itemBag.bag.remove(at: slot)
        delegate?.game(self, didUseItem: item, onHeroAtSlot: slot)
    }
    
    func attack(slot: Int) {
        
        self.party.heroes[slot]!.health -= self.dungeon.enemies.last!.damage
        self.dungeon.enemies.last!.health -= self.party.heroes[slot]!.damage
        
        if self.dungeon.enemies.last!.health <= 0 {
            self.dungeon.enemies.removeLast()
            print("Enemy defeated!")
        }
        
        if self.party.heroes[slot]!.health <= 0 {
            self.party.heroes.remove(at: slot)
            print("You lost a hero!")
        }
        
        delegate?.game(self, didAttack: slot)
    }


}
