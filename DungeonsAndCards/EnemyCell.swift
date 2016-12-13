//
//  EnemyCell.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 12/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import UIKit

class EnemyCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    
    @IBOutlet weak var enemyImageView: UIImageView!
    
    override func awakeFromNib() {
        
        titleLabel.adjustsFontSizeToFitWidth = true
        healthLabel.adjustsFontSizeToFitWidth = true
        attackLabel.adjustsFontSizeToFitWidth = true
    }
    
    func displayEnemy(_ e: Enemy) {
        
        self.enemyImageView.image = UIImage(named: e.image)
        self.titleLabel.text = e.name
        self.attackLabel.text = e.attack.description
        self.healthLabel.text = e.health.description
    }
    
    func hideEnemy() {
        
        self.subviews.forEach {
            $0.isHidden = true
        }
    }
}
