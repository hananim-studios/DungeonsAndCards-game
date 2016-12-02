//
//  ItemsJSON.swift
//  DungeonsAndCards
//
//  Created by Gabriela de Carvalho Barros Bezerra on 01/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import SwiftyJSON

class ItemsJSON {
    
    static var json: JSON? = nil
    
    static func load() -> Bool {
        
        do {
            
            let path = Bundle.main.path(forResource: "items", ofType: "json")
            
            let data = try NSData(contentsOf: NSURL(fileURLWithPath: path!) as URL, options: .mappedIfSafe)
            
            self.json = JSON(data: data as Data)
            
            print("loaded Items JSON")
            
            return true
            
        } catch {
            
            return false
        }
    }
    
    static func cardAtGroup(name: String) -> Item? {
        
        if let json = self.json {
            return Item(json: json["items"][name])
        }
        
        return nil
    }
    
    static func heroesCount() -> Int {
        
        if let json = self.json {
            return json["items"].count
        }
        
        return -1
    }
    
}

