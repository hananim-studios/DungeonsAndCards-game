//
//  EnemyParty.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 12/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import SwiftyJSON

class Battle {
    
    private(set) var enemyCount = 3
    private      var enemies : [Enemy]
    
    init() {
        
        self.enemies = []
        
        for i in 0..<enemyCount {
            
            addEnemy(EnemiesJSON.enemyAtIndex(index: i))
        }
    }
    
    var hasEnemy: Bool {
        
        if enemies.first == nil {
            return false
        }
        
        return true
    }
    
    func currentEnemy() -> Enemy {
        
        guard hasEnemy else {
            
            assertionFailure("(🚩) - tried to access current enemy but there is no enemy")
            
            return Enemy.invalid()
        }
        
        return enemies.first!
    }
    
    var onAddEnemy: ((Enemy) -> Void)?
    func addEnemy(_ enemy: Enemy) {
        
        enemies.append(enemy)
        onAddEnemy?(enemy)
    }
    
    var onRemoveCurrentEnemy: (() -> Void)?
    func removeCurrentEnemy() {
        
        guard hasEnemy else {
            
            assertionFailure("(🚩) - tried to remove current enemy but there is no enemy")
            
            return
        }
        
        enemies.removeFirst()
        onRemoveCurrentEnemy?()
    }
}
