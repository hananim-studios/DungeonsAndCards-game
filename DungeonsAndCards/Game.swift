//
//  Game.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 11/23/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import SwiftyJSON

class Game {
    
    static var hasSavedGame: Bool {
        return UserDefaults.standard.bool(forKey: "hasSavedGame")
    }
    
    //var delegate: GameDelegate?

    var onMoneyChanged: ((Int) -> Void)?
    private(set) var money: Int = 200 {
        
        didSet {
            onMoneyChanged?(self.money)
        }
    }
    
    var level: Int = 0
    
    var party   : Party
    var battle  : Battle
    
    var heroShop: HeroShop
    var itemShop: ItemShop
    
    //var dungeon: Dungeon
    
    private init() {
        self.party      = Party()
        self.battle     = Battle()
        self.heroShop   = HeroShop()
        self.itemShop   = ItemShop()
    }
    
    func saveGame() {
        UserDefaults.standard.set(true, forKey: "hasSavedGame")
        
        party.save(toUserDefaultsKey: "party")
        heroShop.save(toUserDefaultsKey: "heroShop")
        itemShop.save(toUserDefaultsKey: "itemShop")
        battle.save(toUserDefaultsKey: "battle")
        
        UserDefaults.standard.set(money, forKey: "money")
        UserDefaults.standard.set(level, forKey: "level")
        
        UserDefaults.standard.synchronize()
    }
    
    static func newGame() -> Game {
        
        UserDefaults.standard.set(false, forKey: "hasSavedGame")
        
        let newGame = Game()
        
        return newGame
    }
    
    static func savedGame() -> Game {
        
        if Game.hasSavedGame {
            
            // TODO: - Implement loading savedGame
            let savedGame = Game()
            
            savedGame.party = Party(withUserDefaultsKey: "party")
            savedGame.heroShop = HeroShop(withUserDefaultsKey: "heroShop")
            savedGame.itemShop = ItemShop(withUserDefaultsKey: "itemShop")
            savedGame.battle = Battle(withUserDefaultsKey: "battle")
            
            savedGame.money = UserDefaults.standard.integer(forKey: "money") 
            savedGame.level = UserDefaults.standard.integer(forKey: "level")
            
            return savedGame
            
        } else {
            assertionFailure("(🚩) - called Game.saveGame(), but Game.hasSavedGame is false")
            
            // fallback to new game
            return Game.newGame()
        }
    }
    
    func canSpendMoney(_ money: Int) -> Bool {
        return self.money >= money
    }
    
    func spendMoney(_ money: Int) {
        assert(canSpendMoney(money), "(🚩) - pre condition failed")
        
        self.money -= money
    }
    
}
