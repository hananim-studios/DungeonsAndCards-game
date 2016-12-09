//
//  ItemShop.swift
//  DungeonsAndCards
//
//  Created by Gabriela de Carvalho Barros Bezerra on 08/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import SwiftyJSON

class ItemShop {
    
    var items : [Item] = []
    
    init(){
        
        print("creating new shelf of items...")
        
        for i in 0...ItemsJSON.count()-1 {
          
            if let item = ItemsJSON.itemAtIndex(index:Int(i)) {
                    items.append(item)
                    print("  \(i) append '\(item.name)' succeeded")
            }
        }
        
    }
    
}

class ItemBag {
    
    var bag : [Item?] = [nil,nil,nil]    
}
