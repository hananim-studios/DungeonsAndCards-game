//
//  Game.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 11/23/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation

class Game {
    
    var money: Int = 10
    var partyHeroes: [Hero?] = []
    var handHeroes: [Hero?] = []
    
    init() {
        self.partyHeroes = [Hero(withTemplate: "wizard"), nil,
                        Hero(withTemplate: "shiny_wizard")]
        
        self.handHeroes = [Hero(withTemplate: "gypsy1"), Hero(withTemplate: "warrior"),
                                Hero(withTemplate: "noble"), Hero(withTemplate: "wizard"),
                                Hero(withTemplate: "queen")]
    }
}
