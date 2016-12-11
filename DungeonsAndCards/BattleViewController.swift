//
//  BattleViewController.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 01/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {

    // Model
    let game = Game.newGame()
    
    // MARK: - Variables
    override var prefersStatusBarHidden: Bool{ return true }
    // MARK: - IBOutlets
    
    @IBOutlet weak var goldButton: UIButton!
    @IBOutlet weak var partyCollectionView: DIOCollectionView!
    @IBOutlet weak var enemyView: EnemyView!
    
    //MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        partyCollectionView.register(UINib(nibName: "HeroItemCell", bundle: Bundle.main), forCellWithReuseIdentifier: "HeroItemCell")
        partyCollectionView.dataSource = self
        partyCollectionView.dioDelegate = self
        partyCollectionView.dioDataSource = self
        
        let oldView = enemyView
        enemyView = Bundle.main.loadNibNamed("EnemyView", owner: self, options: nil)![0] as! EnemyView
        enemyView.frame = oldView!.frame
        oldView!.removeFromSuperview()
        self.view.addSubview(enemyView)
        
        
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
    
    func updateGold() {
        self.goldButton.setTitle(self.game.money.description, for: .normal)
    }

}


extension BattleViewController: DIOCollectionViewDataSource, DIOCollectionViewDelegate {
    
    // DIOCollectionView DataSource
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, userDataForItemAtIndexPath indexPath: IndexPath) -> Any? {
        
        if dioCollectionView == partyCollectionView {
            return self.game.party.slot(atIndex: indexPath.row).hero
        }
        
        return nil
    }
    
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, shouldDragItemAtIndexPath indexPath: IndexPath) -> Bool {
        if dioCollectionView == partyCollectionView {
            return self.game.party.slot(atIndex: indexPath.row).hasHero
        }
        else {
            return true
        }
    }
    
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, viewForItemAtIndexPath indexPath: IndexPath) -> UIView {
        return UIImageView(image: UIImage(named: (dioCollectionView.cellForItem(at: indexPath) as! HeroCell).hero!.image))
    }
    
    // DIOCollectionView Delegate
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, draggedItemAtIndexPath indexPath: IndexPath, withDragState dragState: DIODragState) {
        
        guard let cell = partyCollectionView.cellForItem(at: indexPath) as? HeroCell else { return }
        
        switch(dragState) {
        case .ended:
            dioCollectionView.dragView?.removeFromSuperview()
        default:
            break
        }
        
        if dioCollectionView == partyCollectionView {
            switch(dragState) {
            //case .ended:
                
                // - MARK: EVENT: PLAYER DISCARDED HERO
                //self.game.dismissHero(hero: cell.hero!, atSlot: indexPath.row)
                
            default:
                break
            }
        }
    }
}

extension BattleViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
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
            
            cell.setHero(self.game.party.slot(atIndex: indexPath.row).hero)
            cell.setItem(self.game.party.slot(atIndex: indexPath.row).item)
            
            return cell
        }
        
        fatalError("collectionView not implemented")
    }
}

extension BattleViewController: GameDelegate {
    
    func game(_ game: Game, changedGoldTo gold: Int) {
        updateGold()
    }
    
    func game(_ game: Game, didAttack slot: Int){
        
    }
}
