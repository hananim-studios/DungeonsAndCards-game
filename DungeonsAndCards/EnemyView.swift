//
//  EnemyView.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 12/8/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import Foundation
import UIKit

class EnemyView: UICollectionViewCell, DIOCollectionViewDestination {
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var enemyImageView: UIImageView!
    
    var enemy: Enemy?
    
    var onAttackedByHero: ((_ hero: Hero) -> Void)?
    
    override func awakeFromNib() {
        self.isUserInteractionEnabled = true
    }
    
    func receivedDragWithDragInfo(_ dragInfo: DIODragInfo?, andDragState dragState: DIODragState) {
        
        switch dragState {
        case let .ended(location):
            handleDragEnded(dragInfo: dragInfo, atLocation: location)
        default:
            break
        }
    }
    
    func handleDragEnded(dragInfo: DIODragInfo?, atLocation location: CGPoint) {
        self.onAttackedByHero?(dragInfo?.userData as! Hero)
    }
    
    func setEnemy(enemy: Enemy?) {
        
        if let enemy = enemy {
            self.healthLabel.text = enemy.health.description
            self.attackLabel.text = enemy.damage.description
            self.enemyImageView.image = UIImage(named: enemy.pic)
        } else {
            self.healthLabel.text = "?"
            self.attackLabel.text = "?"
            self.enemyImageView.image = nil
        }
    }
}
