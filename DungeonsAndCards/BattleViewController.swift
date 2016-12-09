//
//  BattleViewController.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 01/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController, UICollectionViewDataSource {

    // Model
    let game = Game.sharedInstance
    
    // MARK: - Variables
    override var prefersStatusBarHidden: Bool{ return true }
    // MARK: - IBOutlets
    
    @IBOutlet weak var goldButton: UIButton!
    @IBOutlet weak var partyCollectionView: HeroCollectionView!
    
    
    //MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        partyCollectionView.dataSource = self
        partyCollectionView.register(UINib(nibName: "HeroItemCell", bundle: Bundle.main), forCellWithReuseIdentifier: "HeroItemCell")
        
        self.game.delegate = self
        
        updateGold()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Button Actions
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == partyCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroItemCell",
                                                          for: indexPath) as! HeroItemCell
            
            cell.setHero(self.game.party.heroes[indexPath.row])
            cell.setItem(self.game.itemShop.items[indexPath.row])
            
            return cell
        }
        
        fatalError("collectionView not implemented")
    }
    
    func updateGold() {
        self.goldButton.setTitle(self.game.gold.description, for: .normal)
    }

}

extension BattleViewController: GameDelegate {
    
    func game(_ game: Game, changedGoldTo gold: Int) {
        updateGold()
    }
    
    func game(_ game: Game, didAttack slot: Int){
        
    }
}
