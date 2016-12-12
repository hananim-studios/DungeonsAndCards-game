//
//  InterfaceController.swift
//  DungeonsAndCardsWatch Extension
//
//  Created by Matheus Vasconcelos de Sousa on 24/11/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController, QuestManagerDelegate {

    @IBOutlet var emptyMessageLabel: WKInterfaceLabel!
    @IBOutlet var questsTable: WKInterfaceTable!
    var array = QuestManager.sharedInstance.quests
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        //ConnectionManager.sharedConnectionManager.delegate = self
        self.emptyMessageLabel.setHidden(true)
        QuestManager.sharedInstance.delegate = self
        questsTable.setNumberOfRows(self.array.count, withRowType: "QuestRow")
        populateTable(self.questsTable)
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func questsDidUpdate() {
        populateTable(self.questsTable)
    }
    
    //MARK: - QuestManagerDelegate Methods
    func didInvalidateTimer() {
        self.questsTable.setHidden(true)
        self.emptyMessageLabel.setHidden(false)
    }
    
    func questSorted(quest: Quest) {
        var index: Int?
        for element in array{
            if element == quest {
                element.active = true
                quest.active = true
                index = array.index(of: element)
            }
        }
        if let i = index {
            array.remove(at: i)
            array.insert(quest, at: 0)
        }
    }
    
    func questRemoved(_ quest: Quest) {
        var index: Int?
        for element in self.array{
            if element == quest {
                index = self.array.index(of: element)
            }
        }
        if let i = index {
            self.array.remove(at: i)
            print("Quest: \(quest.name) was removed from VIEW (size: \(self.array.count)")
        }
        populateTable(self.questsTable)
    }
    
    func refillQuestArray(array: [Quest]) {
        self.array.removeAll()
        for quest in array {
            self.array.append(quest)
        }
    }
    
    func didUpdateQuests(withExercise exercise: Double, Move move: Double, Stand stand: Double, andTap tap: Double) {
        
        questsTable.setNumberOfRows(self.array.count, withRowType: "QuestRow")
        
        for (index, content) in self.array.enumerated() {
            
            let controller = questsTable.rowController(at: index) as! QuestRowController
            
            controller.ringQuest.setBackgroundImageNamed("quest")
            controller.mainLabel.setText(content.name)
            if(content.active == true){
                let nextValue: Double?
                switch content.questType {
                case .exercise:
                    nextValue = exercise
                case .move:
                    nextValue = move
                case .stand:
                    nextValue = stand
                case .tap:
                    nextValue = tap
                }
                print("Quest: \(content.name)")
                print("current:\(content.currentQuestObjective) , next:\(nextValue!) ")
                print("Current%: \(Int(content.currentQuestObjective*100/content.questObjective)), next %: \(Int(nextValue!*100/content.questObjective))")
                
                if nextValue! > 0 && nextValue! != content.currentQuestObjective {
                    controller.ringQuest.startAnimatingWithImages(in:
                        NSMakeRange(
                            Int(content.completionPercentage*100),
                            Int(nextValue!*100/content.questObjective)),
                                                                  duration: 0.5,
                                                                  repeatCount: 1)
                }
            }
            else {
                controller.mainLabel.setAlpha(0.5)
            }
        }
    }
    
    //MARK: - Convenience Methods
    func populateTable(_ table: WKInterfaceTable) {
                
        table.setNumberOfRows(self.array.count, withRowType: "QuestRow")
        
        for (index, content) in self.array.enumerated() {
            
            let controller = table.rowController(at: index) as! QuestRowController
            
            controller.ringQuest.setBackgroundImageNamed("quest")
            controller.mainLabel.setText(content.name)
            if(content.active == true){

            }
            else {
                controller.mainLabel.setAlpha(0.5)
            }
        }
    }


}
