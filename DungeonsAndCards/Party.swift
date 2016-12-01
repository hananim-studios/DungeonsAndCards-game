//
//  Party.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 11/23/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import SwiftyJSON

class Party {
    
    var heroes : [Hero?] = []
    var hand : [Hero?] = []
    
    lazy var heroesJSON: JSON = HeroesJSON.load()
    
    init(){
        
        for _ in 0...4 {
            let i = arc4random_uniform(UInt32(heroesJSON.count))
            let randomHero = HeroesJSON.heroAtIndex(index: Int(i))
            hand.append(randomHero)
        }
        
        for _ in 0...2 {
            let i = arc4random_uniform(UInt32(heroesJSON.count))
        }
        
    }
    
    
}
