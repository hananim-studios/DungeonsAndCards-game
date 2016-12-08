//
//  Quests.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 02/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import HealthKit

enum QuestType : Double {
    case exercise = 40 //raw value will be quest objectives
    case move = 200
    case stand = 100
    case tap = 80
}

class Quest {
    let name: String
    var active : Bool
    var questObjective : Double
    var currentQuestObjective : Double
    var questType: QuestType
    
    init(with questType: QuestType) {
        self.currentQuestObjective = 0
        self.questType = questType
        self.active = false
        self.questObjective = questType.rawValue
        switch self.questType{
        case .exercise:
            self.name = "Faça exercício"
        case .move:
            self.name = "Faça um movimento"
        case .stand:
            self.name = "Se levante"
        case .tap:
            self.name = "Aperte várias vezes"


        }
    }
}

extension Quest : Equatable {
    static func == (a: Quest, b: Quest) -> Bool {
        return (a.questType == b.questType)
    }
}
