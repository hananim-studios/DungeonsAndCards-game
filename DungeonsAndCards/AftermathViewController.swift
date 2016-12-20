//
//  AftermathViewController.swift
//  DungeonsAndCards
//
//  Created by Gabriela de Carvalho Barros Bezerra on 19/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit

class AftermathViewController: GameViewController {
    
    var context: AftermathContext {
        get {
            return super.baseContext as! AftermathContext
        }
        set {
            self.baseContext = newValue
        }
    }
    
    var onDismiss: (() -> Void)?
    
    @IBOutlet weak var battleResultLabel: UILabel!
    @IBOutlet weak var winnerImage: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var rewardValueLabel: UILabel!
    
    override func viewDidLoad() {
        if !self.context.lose {
            self.battleResultLabel.text = "You Win"
            self.winnerImage.image = UIImage(named: "win")
            self.rewardLabel.isHidden = false
            self.rewardValueLabel.isHidden = false
        } else {
            self.battleResultLabel.text = "You Lose"
            self.winnerImage.image = UIImage(named: "lose")
            self.rewardLabel.isHidden = true
            self.rewardValueLabel.isHidden = true
        }
            
        switch(self.context.game.level) {
            case 1: self.levelLabel.text = "\(self.context.game.level)st"
            break;
            case 2: self.levelLabel.text = "\(self.context.game.level)nd"
            break;
            case 3: self.levelLabel.text = "\(self.context.game.level)rd"
            break;
            default: self.levelLabel.text = "\(self.context.game.level)th"
            break;
        }
    }
    
    @IBAction func tap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        onDismiss?()
    }
}
