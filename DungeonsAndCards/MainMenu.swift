//
//  MainMenu.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 12/10/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation

class MainMenu {
    
    //var delegate: MainMenuDelegate?
    
    var onStartGame: ((Game) -> Void)?
    func startGame() {
        
        let game = Game.newGame()
        
        onStartGame?(game)
    }
    
    var onContinueGame: ((Game) -> Void)?
    func continueGame() {
        
        let game = Game.savedGame()
        
        onContinueGame?(game)
    }
}

