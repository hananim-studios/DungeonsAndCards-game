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

    var gold: Int = 0
    var dungeonLevel: Int = 0
    
    var currentHand: Hand?
    
    var party: Party = Party()
    
    init(){
        if HeroesJSON.load(){
            self.currentHand = Hand()
        }
    }
        
}
