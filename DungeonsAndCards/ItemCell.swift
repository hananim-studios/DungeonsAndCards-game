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
    
    func displayItem(_ item: Item) {
        
        self.subviews.forEach {
            $0.isHidden = false
        }
        
        self.imageView.image = UIImage(named: item.image)
        
    }
    
    func hideItem() {
        
        self.subviews.forEach {
            $0.isHidden = true
        }
    }
}
