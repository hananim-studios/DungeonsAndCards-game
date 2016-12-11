//
//  ItemCell.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 12/8/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import UIKit

class ItemCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    var item: Item?
    
    func setItem(_ item: Item?) {
        
        self.item = item
        
        if let item = item {
            
            self.imageView.image = UIImage(named: item.image)
        } else {
            
            self.imageView.image = nil
        }
    }
}
