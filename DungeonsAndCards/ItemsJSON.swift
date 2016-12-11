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
    static var loaded = false
    
    static func load() -> Bool {
        
        do {
            
            let path = Bundle.main.path(forResource: "items", ofType: "json")
            
            let data = try NSData(contentsOf: NSURL(fileURLWithPath: path!) as URL, options: .mappedIfSafe)
            
            ItemsJSON.json = JSON(data: data as Data)
            ItemsJSON.loaded = true
            
            return true
            
        } catch {
            
            return false
        }
    }
    
    static func itemAtIndex(index: Int) -> Item? {
        
        if let json = self.json {
            return Item(json: json["items"][index])
        }
        
        return nil
    }
    
    static func count() -> Int {
        
        if let json = self.json {
            return json["items"].count
        }
        
        return -1
    }
    
}

