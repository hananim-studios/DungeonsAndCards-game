//
//  QuestManager.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 02/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation

class QuestManager {
    static let sharedInstance = QuestManager()
    var quests: [Quest]
    
    init(){
        quests = [Quest(with: .exercise), Quest(with: .move), Quest(with: .stand), Quest(with: .tap)]
        
        //Randomize a quest
        let index = Int(arc4random_uniform(UInt32(quests.count)) + 1)
        let quest = quests[index]
        
        //Inicia uma quest
        initQuest(quest)
        
        //Adiciona quest no início do array
        quests.remove(at: index)
        quests.insert(quest, at: 0)
        
    }
    
    func initQuest(_ quest :Quest){
        for element in quests {
            if quest == element {
                element.active = true
            }
            else {
                print("quest doesn't exist")
            }
        }
    }
    
    func isQuestCompleted(_ quest: Quest) -> Bool {
        return true
    }
    
}
