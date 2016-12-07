//
//  HeroCell.swift
//  DungeonsAndCards
//
//  Created by Matheus Martins on 11/28/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit

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
            self.heroImageView.image = UIImage(named: hero.pic!)
            self.attackLabel.text = hero.damage?.description
            self.healthLabel.text = hero.health?.description
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
            self.heroImageView.image = UIImage(named: hero.pic!)
            self.titleLabel.text = hero.name
            self.attackLabel.text = hero.damage?.description
            self.healthLabel.text = hero.health?.description
            self.costLabel.text = hero.gold?.description
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

class HeroItemCell: UICollectionViewCell {
    
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var itemImageView: UIImageView!
    
    var hero: Hero?
    var item: Item?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        /*self.superview!.addConstraints([
         NSLayoutConstraint(item: self.imageView, attribute: .bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
         NSLayoutConstraint(item: self.imageView, attribute: .top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
         NSLayoutConstraint(item: self.imageView, attribute: .right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: .right, multiplier: 1, constant: 0),
         NSLayoutConstraint(item: self.imageView, attribute: .left, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)])*/
    }
    
    func setHero(_ hero: Hero?) {
        
        self.hero = hero
        
        if let hero = hero {
            self.heroImageView.image = UIImage(named: hero.pic!)
            self.itemImageView.image = UIImage(named: hero.pic!)
        } else {
            self.heroImageView.image = nil
            self.itemImageView.image = nil
        }
    }
    
    func setItem(_ item: Item?) {
        self.item = item
        
        if let item = item {
            self.itemImageView.image = UIImage(named: item.pic!)
        } else {
            self.itemImageView.image = nil
        }
    }
}
