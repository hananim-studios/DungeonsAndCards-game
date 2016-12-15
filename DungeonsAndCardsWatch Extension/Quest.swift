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
    case exercise = 100 //raw value will be quest objectives
    case move = 101
    case stand = 102
    case tap = 103
}

class Quest {
    let name: String
    var active: Bool
    var questObjective: Double
    var currentQuestObjective: Double
    var completionPercentage: Float
    var questType: QuestType
    var questBounty: String
    
    init(with questType: QuestType) {
        self.currentQuestObjective = 0
        self.questType = questType
        self.active = false
        self.questObjective = questType.rawValue
        self.completionPercentage = Float(self.currentQuestObjective/self.questObjective)
        switch self.questType{
        case .exercise:
            self.name = "Exercise"
            self.questBounty = "50"
        case .move:
            self.name = "Move"
            self.questBounty = "20"
        case .stand:
            self.name = "Get up"
            self.questBounty = "30"
        case .tap:
            self.name = "Tap"
            self.questBounty = "10"

        }
    }
}

extension Quest : Equatable {
    static func == (a: Quest, b: Quest) -> Bool {
        return (a.questType == b.questType)
    }
}
