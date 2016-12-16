//
//  HeroShopContext.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 12/10/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation

enum HeroShopResponse {
    
    case noHeroAtShopIndex
    case noSlotAtPartyIndex
    case noHeroAtPartyIndex
    case notEnoughMoney
    case slotIsOccupied
    case success
}

class HeroShopContext: Context {
    
    var party   : Party     { return game.party     }
    var shop    : HeroShop  { return game.heroShop  }
    
    override init(withGame game: Game) {
        
        super.init(withGame: game)
        
        shop.loadHeroes(forLevel: game.level)
    }
    
    func canBuyHero(atShopIndex shopIndex: Int) -> HeroShopResponse {
        
        guard shop.hero(atIndex: shopIndex).isValid else {
            return .noHeroAtShopIndex
        }
        
        guard game.canSpendMoney(shop.price(forHeroAtIndex: shopIndex)) else {
            return .notEnoughMoney
        }
        
        return .success
    }
    
    func canBuyHero(toPartyIndex partyIndex: Int) -> HeroShopResponse {
        
        guard party.hasSlot(atIndex: partyIndex) else {
            return .noSlotAtPartyIndex
        }
        
        if party.slot(atIndex: partyIndex).hasHero {
            return .slotIsOccupied
        }
        
        return .success
    }
    
    
    func buyHero(atShopIndex shopIndex: Int, toPartyIndex partyIndex: Int) {
        
        assert(canBuyHero(atShopIndex: shopIndex) == .success,
               "(🚩) - failed pre condition")
        assert(canBuyHero(toPartyIndex: partyIndex) == .success,
               "(🚩) - failed pre condition")
        
        let hero = shop.hero(atIndex: shopIndex)
        
        game.spendMoney(hero.price)
        party.slot(atIndex: partyIndex).setHero(hero)
        shop.removeHero(atIndex: shopIndex)
    }
    
    func canRemoveHero(atPartyIndex partyIndex: Int) -> HeroShopResponse {
        
        guard party.hasSlot(atIndex: partyIndex) else {
            return .noSlotAtPartyIndex
        }
        
        guard party.slot(atIndex: partyIndex).hasHero else {
            return .noHeroAtPartyIndex
        }

        
        return .success
    }
    
    func removeHero(atPartyIndex partyIndex: Int) {
        
        assert(canRemoveHero(atPartyIndex: partyIndex) == .success,
               "(🚩) - failed pre condition")
        
        party.slot(atIndex: partyIndex).removeHero()
    }
    
    func canRemoveHero(atShopIndex shopIndex: Int) -> HeroShopResponse {
        
        guard shop.hasHero(atIndex: shopIndex) else {
            return .noHeroAtShopIndex
        }
        
        
        return .success
    }
    
    func removeHero(atShopIndex shopIndex: Int) {
        
        assert(canRemoveHero(atShopIndex: shopIndex) == .success,
               "(🚩) - failed pre condition")
        
        party.slot(atIndex: shopIndex).removeHero()
    }
    
    func canSwapHero(fromPartyIndex i: Int, toPartyIndex j: Int) -> HeroShopResponse {
        
        guard party.hasSlot(atIndex: i) else {
            return .noSlotAtPartyIndex
        }
        
        guard party.slot(atIndex: i).hasHero else {
            return .noHeroAtPartyIndex
        }
        
        return .success
    }
    
    func swapHero(fromPartyIndex i: Int, toPartyIndex j: Int) {
        assert(canSwapHero(fromPartyIndex: i, toPartyIndex: j) == .success,
               "(🚩) - failed pre condition")
        
        party.swapHero(fromIndex: i, toIndex: j)
    }
}
