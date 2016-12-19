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
    
    let enemyMaxCount = 5
    
    var enemyCount: Int {
        return enemies.count
    }
    private var enemies : [Enemy]
    
    init() {
        self.enemies = []
        
        loadEnemies(forLevel: 0)
    }
    
    init(withUserDefaultsKey key: String) {
        
         self.enemies = []
        
        if let enemyCount = UserDefaults.standard.value(forKey: "\(key).enemyCount") as? Int {
            for i in 0..<enemyCount {
                addEnemy(Enemy(withUserDefaultsKey: "\(key).enemy\(i)"))
            }
        } else {
            assertionFailure("(🚩) - \(key).enemyCount not found in UserDefaults")
        }
    }
    
    func save(toUserDefaultsKey key: String) {
        
        UserDefaults.standard.set(enemyCount, forKey: "\(key).enemyCount")
        for i in 0..<enemyCount {
            enemies[i].save(toUserDefaultsKey: "\(key).enemy\(i)")
        }
    }
    
    func loadEnemies(forLevel: Int) {
        
        self.enemies.removeAll()
        
        for i in 0..<enemyMaxCount {
            
            enemies.append(EnemiesJSON.enemyAtIndex(index: i))
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
