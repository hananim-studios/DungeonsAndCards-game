//
//  HeroCell.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 11/28/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit

class HeroCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    func setHero(_ hero: Hero) {
        self.imageView.image = UIImage(named: hero.template)
    }
}
