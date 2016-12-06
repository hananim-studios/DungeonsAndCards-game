//
//  Party.swift
//  DungeonsAndCards
//
//  Created by Gabriela de Carvalho Barros Bezerra on 01/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation

protocol PartyDelegate {
    

    
}

class Party {
    
    var heroes: [Hero?] = [nil,nil,nil]
    
    var delegate: PartyDelegate?
}
