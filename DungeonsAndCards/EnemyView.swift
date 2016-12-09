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
    
    var onAttackedByHero: ((_ hero: Hero) -> Void)?
    
    override func awakeFromNib() {
        
    }
    
    func receivedDragWithDragInfo(_ dragInfo: DIODragInfo?, andDragState dragState: DIODragState) {
        self.onAttackedByHero?(dragInfo!.userData as! Hero)
    }
}
