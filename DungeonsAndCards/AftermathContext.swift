//
//  AftermathContext.swift
//  DungeonsAndCards
//
//  Created by Gabriela de Carvalho Barros Bezerra on 20/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation

class AftermathContext: Context {
    
    var lose: Bool { return !game.party.hasHeroes }
    var level: Int { return game.level }
    
    override init(withGame game: Game) {
        super.init(withGame: game)
    }
    
}
