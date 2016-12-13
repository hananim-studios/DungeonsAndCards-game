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
    func questRemoved(_ quest: Quest)
    func refillQuestArray( array: [Quest])
    func questSorted(quest: Quest)
    func didInvalidateTimer()
}

class QuestManager: HeathKitManagerDelegate {

    var delegate: QuestManagerDelegate?
    let healthKitManager = HealthKitManager()
    static let sharedInstance = QuestManager()
    var quests: [Quest]
    var inactive: [Quest]
    
    private init(){
        
        let exerciseQuest = Quest(with: .exercise)
        let moveQuest = Quest(with: .move)
        let standQuest = Quest(with: .stand)
        //let tapQuest = Quest(with: .tap)
        
        self.quests = [exerciseQuest, moveQuest, standQuest/*, tapQuest*/]
        self.inactive = [Quest]()
        sortQuest()
        healthKitManager.delegate = self
    }
    
    //MARK: - Methods
    private func sortQuest(){
        
        if quests.count > 0 {
            //Randomize a quest
            print(quests)
            let index = Int(arc4random_uniform(UInt32(quests.count)))
            let quest = quests[index]
            
            //Initialize a quest
            initQuest(quest)
            
            //Add quest in the beginning of array
            quests.remove(at: index)
            quests.insert(quest, at: 0)
            
            //Inform Delegate
            self.delegate?.questSorted(quest: quest)
        }

    }
    
    private func initQuest(_ quest :Quest){

        for element in quests {
            if quest == element {
                quest.active = true
                element.active = true
            }
        }
    }
    
    private func isQuestCompleted(_ quest: Quest) -> Bool {
       
        if quest.active == true {
            
            if quest.currentQuestObjective >= quest.questObjective {
                print("Quest: \(quest.name) is completed with current Objective: \(quest.currentQuestObjective)")
                return true
            }
        }
        return false
    }
    
    private func setInactive(_ quest: Quest) {
       
        if quest.active == true {
        
            print("Quest: \(quest.name) was set inactive")
            quest.currentQuestObjective = 0
            quest.active = false
        }
    }
    
    private func sendQuestToInactiveArray(_ quest: Quest){
        
        if quest.active == true {
        
            var index: Int?
            for element in quests{
                if element == quest {
                   index = quests.index(of: element)
                }
            }
            if let i = index {
                quests.remove(at: i)
                setInactive(quest)
                delegate?.questRemoved(quest)
                inactive.append(quest)
                print("Quest: \(quest.name) was removed from quests array (size: \(quests.count) and sent to inactiveArray (size: \(inactive.count))")
            }
        }
    }
    
    private func shouldReset() {
      
        if quests.count == 0 {
            healthKitManager.timer.invalidate()
            DispatchQueue.main.async {
                self.delegate?.didInvalidateTimer()
            }
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
                shouldReset()
                sortQuest()
            }
        }
    }
}
