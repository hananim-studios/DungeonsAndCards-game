//
//  Quests.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 02/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import HealthKit

enum QuestType : Int {
    case exercise = 1
    case move = 2
    case stand = 3
    case tap = 4
}

class Quest {
    var active : Bool
    var questObjective : Int
    var questType: QuestType 
    
    init(with questType: QuestType) {
        self.questType = questType
        self.active = false
        self.questObjective = questType.rawValue
    }
}

extension Quest : Equatable {
    static func == (a: Quest, b: Quest) -> Bool {
        return (a.questType == b.questType)
    }
}
