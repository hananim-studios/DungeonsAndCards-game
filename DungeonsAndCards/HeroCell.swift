//
//  HeroCell.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 11/28/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit

class HeroItemCell: HeroCell {
    
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var itemImageView: UIImageView!
    
    var item: Item?
    
    override func awakeFromNib() {
        healthLabel.adjustsFontSizeToFitWidth = true
        attackLabel.adjustsFontSizeToFitWidth = true
    }
    
    override func setHero(_ hero: Hero?) {
        
        super.setHero(hero)
        
        if let hero = hero {
            self.heroImageView.image = UIImage(named: hero.pic)
            self.attackLabel.text = hero.damage.description
            self.healthLabel.text = hero.health.description
        } else {
            self.heroImageView.image = nil
            self.attackLabel.text = "?"
            self.healthLabel.text = "?"
        }
    }
    
    func setItem(_ item: Item?) {
        
        if let item = item {
            self.itemImageView.image = UIImage(named: item.pic)
        } else {
            self.heroImageView.image = nil
        }
    }
}

class HeroPartyCell: HeroCell {

    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    
    @IBOutlet weak var heroImageView: UIImageView!
    
    override func awakeFromNib() {
        healthLabel.adjustsFontSizeToFitWidth = true
        attackLabel.adjustsFontSizeToFitWidth = true
    }
    
    override func setHero(_ hero: Hero?) {
        
        super.setHero(hero)
        
        if let hero = hero {
            self.heroImageView.image = UIImage(named: hero.pic)
            self.attackLabel.text = hero.damage.description
            self.healthLabel.text = hero.health.description
        } else {
            self.heroImageView.image = nil
            self.attackLabel.text = "?"
            self.healthLabel.text = "?"
        }
    }
}

class HeroHandCell: HeroCell {
    
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
    
    override func setHero(_ hero: Hero?) {
        
        super.setHero(hero)
        
        if let hero = hero {
            self.heroImageView.image = UIImage(named: hero.pic)
            self.titleLabel.text = hero.name
            self.attackLabel.text = hero.damage.description
            self.healthLabel.text = hero.health.description
            self.costLabel.text = hero.gold.description
        } else {
            self.heroImageView.image = nil
            self.titleLabel.text = "???"
            self.attackLabel.text = "?"
            self.healthLabel.text = "?"
            self.costLabel.text = "?"
        }
    }
}

class HeroCell: UICollectionViewCell {
    
    weak var hero: Hero?

    func setHero(_ hero: Hero?) {
        self.hero = hero
    }
}
