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

    @IBOutlet var questsTable: WKInterfaceTable!
    var array = QuestManager.sharedInstance.quests
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
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
    
    func didUpdateQuests(withExercise exercise: Double, Move move: Double, Stand stand: Double, andTap tap: Double) {
        
        //Configuring Table Cells
        
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
                print("current:\(nextValue!) , next:\(content.currentQuestObjective) ")
                if nextValue! > 0 && nextValue! != content.currentQuestObjective {
                    controller.ringQuest.startAnimatingWithImages(in: NSMakeRange(Int(content.currentQuestObjective), Int(nextValue!)), duration: 0.5, repeatCount: 1)
                }
            }
            else {
                controller.mainLabel.setAlpha(0.5)
            }
            
        }
    }
    
    func populateTable(_ table: WKInterfaceTable) {
        
        //Configuring Table Cells
        
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
