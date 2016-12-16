//
//  BattleContext.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 12/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation

enum BattleResponse {
    
    case noHeroAtPartyIndex
    case noItemAtPartyIndex
    case noEnemy
    case success
}

class BattleContext: Context {
    var party       : Party     { return game.party  }
    var battle      : Battle    { return game.battle }
    
    override init(withGame game: Game) {
        
        super.init(withGame: game)
        
        battle.loadEnemies(forLevel: game.level)
    }
    
    func canAttackEnemy(withHeroAtIndex index: Int) -> BattleResponse {
        
        guard party.slot(atIndex: index).hasHero else {
            
            return .noHeroAtPartyIndex
        }
        
        guard battle.hasEnemy else {
            
            return .noEnemy
        }
        
        return .success
    }
    
    var onAttackEnemyWithHeroAtIndex: ((Int) -> Void)?
    func attackEnemy(withHeroAtIndex index: Int) {
        
        assert(canAttackEnemy(withHeroAtIndex: index) == .success,
               "(🚩) - failed pre condition")
        
        let e = battle.currentEnemy()
        let h = party.slot(atIndex: index).getHero()
        
        e.health -= h.attack
        h.health -= e.attack
        
        onAttackEnemyWithHeroAtIndex?(index)
        
        if e.health <= 0 {
            killCurrentEnemy()
        }
        
        if h.health <= 0 {
            killHero(atIndex: index)
        }
    }
    
    func canUseItem(atIndex index: Int) -> BattleResponse {
        
        guard party.slot(atIndex: index).hasItem else {
            
            return .noItemAtPartyIndex
        }
        
        return .success
    }
    
    func useItem(atIndex index: Int) {
        
        assert(canUseItem(atIndex: index) == .success,
               "(🚩) - failed pre condition")
        
        party.slot(atIndex: index).removeItem()
    }

    var onKillCurrentEnemy: (()->Void)?
    func killCurrentEnemy() {
        
        battle.removeCurrentEnemy()
        
        onKillCurrentEnemy?()
        
        if !battle.hasEnemy {
            
            finishBattle()
        }
    }
    
    var onKillHeroAtIndex: ((Int)->Void)?
    func killHero(atIndex index: Int) {
        
        party.slot(atIndex: index).removeHero()
        
        onKillHeroAtIndex?(index)
        
        if !party.hasHeroes {
            
            failBattle()
        }
    }
    
    var onFinishBattle: (()->Void)?
    func finishBattle() {
        
        game.level += 1
        
        onFinishBattle?()
    }

    var onFailBattle: (()->Void)?
    func failBattle() {
        
        onFailBattle?()
    }
}
