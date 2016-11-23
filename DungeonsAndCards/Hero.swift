//
//  Hero.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 11/23/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation

class Hero {
    var template: String = "default"
    
    var attack: Int = 0
    var health: (current: Int, total: Int) = (0, 0)
}
