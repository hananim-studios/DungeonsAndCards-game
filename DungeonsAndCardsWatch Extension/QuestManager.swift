//
//  QuestManager.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 02/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation

protocol QuestManagerDelegate {
    func didUpdateQuests(withExercise exercise: Double, Move move: Double, Stand stand: Double, andTap tap: Double)
}

class QuestManager: HeathKitManagerDelegate {

    var delegate: QuestManagerDelegate?
    let healthKitManager = HealthKitManager()
    static let sharedInstance = QuestManager()
    var quests: [Quest]
   
    init(){
        
        let exerciseQuest = Quest(with: .exercise)
        let moveQuest = Quest(with: .move)
        let standQuest = Quest(with: .stand)
        let tapQuest = Quest(with: .tap)
        
        self.quests = [exerciseQuest, moveQuest, standQuest, tapQuest]
        sortQuest()
        
        healthKitManager.delegate = self
        
    }
    
    func didUpdateSummary(withExercise exercise: Double, Move move: Double, Stand stand: Double, andTap tap: Double) {
        
        self.delegate?.didUpdateQuests(withExercise: exercise, Move: move, Stand: stand, andTap: tap)
        
        for quest in quests {
            switch quest.questType {
            case .exercise:
                quest.currentQuestObjective = exercise
            case .move:
                quest.currentQuestObjective = move
            case .stand:
                quest.currentQuestObjective = stand
            case .tap:
                quest.currentQuestObjective = tap
                
            }
        }
    }
    
    private func sortQuest(){
        //Randomize a quest
        let index = Int(arc4random_uniform(UInt32(quests.count)))
        let quest = quests[index]
        
        //Initialize a quest
        initQuest(quest)
        
        //Add quest in the beginning of array
        quests.remove(at: index)
        quests.insert(quest, at: 0)
    }
    
    func initQuest(_ quest :Quest){
        
        for element in quests {
            if quest == element {
                element.active = true
            }
        }
    }
    
    func isQuestCompleted(_ quest: Quest) -> Bool {
        
        switch quest.questType {
            case .exercise:
                break;
            case .move:
                break;
            case .stand:
                break;
            case .tap:
                break;
        }
        return true
    }
    
}
