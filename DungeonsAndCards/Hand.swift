//
//  Hand.swift
//  DungeonsAndCards
//
//  Created by Gabriela de Carvalho Barros Bezerra on 01/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import SwiftyJSON

class Hand {
    
    var heroes : [Hero] = []
    
    init(){
    
        print("creating new Hand...")
        
        while (heroes.count < 5) {
          let i = arc4random_uniform(UInt32(HeroesJSON.count()))
            if let randomHero = HeroesJSON.heroAtIndex(index:Int(i)) {
                if !heroes.contains(randomHero){
                    heroes.append(randomHero)
                    print("  \(heroes.count-1) append '\(randomHero.name)' succeeded")
                }
            }
        }
        
    }
    
}


