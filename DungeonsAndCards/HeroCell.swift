//
//  HeroCell.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 11/28/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit

class HeroItemCell: UICollectionViewCell {
    
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var itemImageView: UIImageView!
    
    var item: Item?
    
    override func awakeFromNib() {
        
        self.subviews.forEach {
            $0.isHidden = true
        }
    }
    
    func displayHero(_ hero: Hero) {
        
        self.subviews.forEach {
            $0.isHidden = false
        }
        
        self.heroImageView.image = UIImage(named: hero.image)
        self.attackLabel.text = hero.attack.description
        self.healthLabel.text = hero.health.description
    }
    
    func hideHero() {
        
        self.subviews.forEach {
            $0.isHidden = true
        }
    }
    
    func displayItem(_ item: Item) {
        
        self.itemImageView.image = UIImage(named: item.image)
    }
    
    func hideItem() {
        
        self.itemImageView.image = nil
    }
}

class HeroPartyCell: UICollectionViewCell {

    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    
    @IBOutlet weak var heroImageView: UIImageView!
    
    override func awakeFromNib() {
        self.subviews.forEach {
            $0.isHidden = true
        }
        
        healthLabel.adjustsFontSizeToFitWidth = true
        attackLabel.adjustsFontSizeToFitWidth = true
    }
    
    func displayHero(_ hero: Hero) {
        
        self.subviews.forEach {
            $0.isHidden = false
        }
        
        self.heroImageView.image = UIImage(named: hero.image)
        self.attackLabel.text = hero.attack.description
        self.healthLabel.text = hero.health.description
    }
    
    func hideHero() {
        
        self.subviews.forEach {
            $0.isHidden = true
        }
    }
}

class HeroShopCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    @IBOutlet weak var heroImageView: UIImageView!
    
    override func awakeFromNib() {
        titleLabel.adjustsFontSizeToFitWidth = true
        healthLabel.adjustsFontSizeToFitWidth = true
        attackLabel.adjustsFontSizeToFitWidth = true
    }
    
    func displayHero(_ hero: Hero) {
        
        self.heroImageView.image = UIImage(named: hero.image)
        self.titleLabel.text = hero.name
        self.attackLabel.text = hero.attack.description
        self.healthLabel.text = hero.health.description
        self.costLabel.text = hero.price.description
    }
}
