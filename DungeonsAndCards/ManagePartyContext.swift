//
//  HireParty.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 12/10/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation

enum ManagePartyResponse {
    
    case noHeroAtShopIndex
    case noSlotAtPartyIndex
    case notEnoughGold
    case slotIsOccupied
    case success
}

class ManagePartyContext: Context {
    
    var party   : Party     { return game.party     }
    var shop    : HeroShop  { return game.heroShop  }
    
    override init(withGame game: Game) {
        super.init(withGame: game)
    }
    
    func canBuyHero(atShopIndex shopIndex: Int) -> ManagePartyResponse {
        
        guard shop.hero(atIndex: shopIndex).isValid else {
            return .noHeroAtShopIndex
        }
        
        guard game.canSpendMoney(shop.price(forHeroAtIndex: shopIndex)) else {
            return .notEnoughGold
        }
        
        return .success
    }
    
    func canBuyHero(toPartyIndex partyIndex: Int) -> ManagePartyResponse {
        
        guard party.hasSlot(atIndex: partyIndex) else {
            return .noSlotAtPartyIndex
        }
        
        if party.slot(atIndex: partyIndex).hasHero {
            return .slotIsOccupied
        }
        
        return .success
    }
    
    
    func buyHero(atShopIndex shopIndex: Int, toPartyIndex partyIndex: Int) -> ManagePartyResponse {
        
        let r1 = canBuyHero(atShopIndex: shopIndex)
        guard r1 == .success else {
            assertionFailure()
            return r1
        }
        
        let r2 = canBuyHero(toPartyIndex: partyIndex)
        guard r2 == .success else {
            assertionFailure()
            return r2
        }
        
        return .success
    }
    
    func canRemoveHero(atPartyIndex partyIndex: Int) -> ManagePartyResponse {
        
        guard party.hasSlot(atIndex: partyIndex) else {
            return .noSlotAtPartyIndex
        }
        
        return .success
    }
    
    func removeHero(atPartyIndex partyIndex: Int) -> ManagePartyResponse {
        
        let r = canRemoveHero(atPartyIndex: partyIndex)
        guard r == .success else {
            assertionFailure()
            return r
        }
        
        return .success
    }
}
