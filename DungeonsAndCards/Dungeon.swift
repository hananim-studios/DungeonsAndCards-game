//
//  Dungeon.swift
//  DungeonsAndCards
//
//  Created by Gabriela de Carvalho Barros Bezerra on 09/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import SwiftyJSON

class Dungeon {
    
    var enemies : [Enemy] = []
    var reward : Int = 0
    var level : Int = 0
    
    init(){
        
        print("creating new dungeon enemies...")
        
        while (enemies.count < 3) {
            let i = arc4random_uniform(UInt32(EnemiesJSON.count()))
            if let randomEnemy = EnemiesJSON.enemyAtIndex(index:Int(i)) {
                if !enemies.contains(randomEnemy){
                    enemies.append(randomEnemy)
                    print("  \(enemies.count-1) append '\(randomEnemy.name)' succeeded")
                    reward += randomEnemy.gold
                }
            }
        }
        
    }
    
}
