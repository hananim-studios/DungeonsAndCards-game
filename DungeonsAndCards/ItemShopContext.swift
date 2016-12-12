//
//  ItemShopContext.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 12/11/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation

enum ItemShopResponse {
    
    case noItemAtShopIndex
    case noSlotAtPartyIndex
    case noItemAtPartyIndex
    case notEnoughGold
    case slotIsOccupied
    case success
}

class ItemShopContext: Context {
    
    var party   : Party     { return game.party     }
    var shop    : ItemShop  { return game.itemShop  }
    
    override init(withGame game: Game) {
        super.init(withGame: game)
    }
    
    func canBuyItem(atShopIndex shopIndex: Int) -> ItemShopResponse {
        
        guard shop.item(atIndex: shopIndex).isValid else {
            
            return .noItemAtShopIndex
        }
        
        guard game.canSpendMoney(shop.price(forHeroAtIndex: shopIndex)) else {
            
            return .notEnoughGold
        }
        
        return .success
    }
    
    func canBuyItem(toPartyIndex partyIndex: Int) -> ItemShopResponse {
        
        guard party.hasSlot(atIndex: partyIndex) else {
            
            return .noSlotAtPartyIndex
        }
        
        if party.slot(atIndex: partyIndex).hasItem {
            
            return .slotIsOccupied
        }
        
        return .success
    }
    
    
    func buyItem(atShopIndex shopIndex: Int, toPartyIndex partyIndex: Int) {
        
        assert(canBuyItem(atShopIndex: shopIndex) == .success,
               "(🚩) - failed pre condition")
        assert(canBuyItem(toPartyIndex: partyIndex) == .success,
               "(🚩) - failed pre condition")
        
        let item = shop.item(atIndex: shopIndex)
        
        game.spendMoney(item.price)
        party.slot(atIndex: partyIndex).setItem(item)
    }
    
    func canRemoveItem(atPartyIndex partyIndex: Int) -> ItemShopResponse {
        
        guard party.hasSlot(atIndex: partyIndex) else {
            return .noSlotAtPartyIndex
        }
        
        guard party.slot(atIndex: partyIndex).hasItem else {
            return .noItemAtPartyIndex
        }
        
        return .success
    }
    
    func removeItem(atPartyIndex partyIndex: Int) {
        
        assert(canRemoveItem(atPartyIndex: partyIndex) == .success,
               "(🚩) - failed pre condition")
        
        party.slot(atIndex: partyIndex).removeItem()
    }
}
