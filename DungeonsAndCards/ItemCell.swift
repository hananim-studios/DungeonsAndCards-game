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
    
    func setItem(_ item: Item?) {
        
        if let item = item {
            
            self.imageView.image = UIImage(named: item.pic)
        } else {
            
            self.imageView.image = nil
        }
    }
}
