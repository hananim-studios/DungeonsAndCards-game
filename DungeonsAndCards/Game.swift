//
//  Game.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 11/23/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation

class Game {
    
    var heroes: [Hero] = []
    var availableHeroes: [Hero] = []
    
    init() {
        self.heroes = [Hero(withTemplate: "wizard"), Hero(withTemplate: "warrior"),
                        Hero(withTemplate: "shiny_wizard")]
        
        self.availableHeroes = [Hero(withTemplate: "gypsy1"), Hero(withTemplate: "warrior"),
                                Hero(withTemplate: "noble"), Hero(withTemplate: "wizard"),
                                Hero(withTemplate: "queen")]
    }
}
