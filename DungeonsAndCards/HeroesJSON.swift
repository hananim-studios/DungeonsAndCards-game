//
//  HeroesJSON.swift
//  DungeonsAndCards
//
//  Created by Gabriela de Carvalho Barros Bezerra on 01/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import SwiftyJSON

class HeroesJSON {
    
    static var json: JSON? = nil
    
    static func load() -> JSON {
        
        do {
            
            let path = Bundle.main.path(forResource: "heroes", ofType: "json")
            
            let data = try NSData(contentsOf: NSURL(fileURLWithPath: path!) as URL, options: .mappedIfSafe)
            
            print("Loaded Heroes JSON")

            self.json = JSON(data: data as Data)
            
            return JSON(data: data as Data)
            
        } catch {
            
            return false
        }
    }
    
    static func heroAtIndex(index: Int) -> Hero? {
        
        if let json = self.json {
            return Hero(json: json["heroes"][index])
        }
        
        return nil
    }
    
    static func count() -> Int {
        
        if let json = self.json {
            return json["heroes"].count
        }
        
        return -1
    }
    
}
