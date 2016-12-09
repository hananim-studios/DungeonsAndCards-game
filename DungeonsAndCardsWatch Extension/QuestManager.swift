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
    func questDidComplete()
}

class QuestManager: HeathKitManagerDelegate {

    var delegate: QuestManagerDelegate?
    let healthKitManager = HealthKitManager()
    static let sharedInstance = QuestManager()
    var quests: [Quest]
    var inactive: [Quest]
    
    init(){
        
        let exerciseQuest = Quest(with: .exercise)
        let moveQuest = Quest(with: .move)
        let standQuest = Quest(with: .stand)
        let tapQuest = Quest(with: .tap)
        
        self.quests = [exerciseQuest, moveQuest, standQuest, tapQuest]
        self.inactive = [Quest]()
        sortQuest()
        
        healthKitManager.delegate = self
    }
    
    //MARK: - Methods
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
    
    private func initQuest(_ quest :Quest){
        
        for element in quests {
            if quest == element {
                element.active = true
            }
        }
    }
    
    private func isQuestCompleted(_ quest: Quest) -> Bool {
        if quest.currentQuestObjective >= quest.questObjective {
            print("Quest: \(quest.name) is completed with current Objective: \(quest.currentQuestObjective)")
            return true
        }
        return false
    }
    
    private func restartQuest(_ quest: Quest) {
        print("Quest: \(quest.name) was restarted")
        quest.currentQuestObjective = 0
        quest.active = false
    }
    
    private func sendQuestToInactiveArray(_ quest: Quest){
        var index: Int?
        for element in quests{
            if element == quest {
               index = quests.index(of: element)
            }
        }
        if let i = index {
            quests.remove(at: i)
            inactive.append(quest)
            print("Quest: \(quest.name) was removed from quests array (size: \(quests.count) and sent to inactiveArray (size: \(inactive.count))")
        }
    }
    
    private func shouldReset() {
        if quests.count < 1 {
            quests = inactive
            inactive.removeAll()
        }
    }
    
    //MARK: - HealthKitManagerDelegate Methods
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
            
            if self.isQuestCompleted(quest) {
                
                sendQuestToInactiveArray(quest)
                delegate?.questDidComplete()
//                shouldReset()
//                sortQuest()
            }
        }
    }
}
