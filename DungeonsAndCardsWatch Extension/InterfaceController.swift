//
//  InterfaceController.swift
//  DungeonsAndCardsWatch Extension
//
//  Created by Matheus Vasconcelos de Sousa on 24/11/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet var questsTable: WKInterfaceTable!
    var array = ["a", "b", "c"]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
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
    
    func populateTable(_ table: WKInterfaceTable) {
        
        //Configuring Table Cells
        
        table.setNumberOfRows(self.array.count, withRowType: "QuestRow")
        
        for (index, content) in self.array.enumerated() {
            
            let controller = table.rowController(at: index) as! QuestRowController
            
            controller.mainLabel.setText(content)
            
        }
    }

}
