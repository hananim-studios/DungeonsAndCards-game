//
//  EnemiesJSON.swift
//  DungeonsAndCards
//
//  Created by Gabriela de Carvalho Barros Bezerra on 01/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import SwiftyJSON

class EnemiesJSON {
    
    static var json: JSON? = nil
    
    static func load() -> Bool {
        
        do {
            
            let path = Bundle.main.path(forResource: "enemies", ofType: "json")
            
            let data = try NSData(contentsOf: NSURL(fileURLWithPath: path!) as URL, options: .mappedIfSafe)
            
            self.json = JSON(data: data as Data)
            
            print("loaded Enemies JSON")
            
            return true
            
        } catch {
            
            return false
        }
    }
    
    static func enemyAtIndex(index: Int) ->  Enemy? {
        
        if let json = self.json {
            return Enemy(json: json["enemies"][index])
        }
        
        return nil
    }
    
    static func count() -> Int {
        
        if let json = self.json {
            return json["enemies"].count
        }
        
        return -1
    }
    
}
