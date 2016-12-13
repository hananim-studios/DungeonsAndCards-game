//
//  BattleViewController.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 01/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {

    //MARK - Model
    var context: BattleContext!
    
    // MARK: - Variables
    override var prefersStatusBarHidden: Bool{ return true }
    // MARK: - IBOutlets
    
    @IBOutlet weak var goldButton: UIButton!
    @IBOutlet weak var battleCollectionView: DACCollectionView!
    @IBOutlet weak var partyCollectionView: DACCollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        // INIT AND BIND UI
        
        self.partyCollectionView.reloadData()
        self.partyCollectionView.layoutIfNeeded()
        
        // money
        let updateMoney = { (value: Int) -> Void in
            self.goldButton.setTitle(value.description, for: .normal)
        }
        updateMoney(context.game.money)
        context.game.onMoneyChanged = updateMoney
        
        // party
        for i in 0..<context.game.party.slotCount {
            let updateItem = { (item: Item) -> Void in
                
                let indexPath = IndexPath(row: i, section: 0)
                guard let cell = self.partyCollectionView.cellForItem(at: indexPath)
                    as? HeroItemCell else {
                        assertionFailure("wrong cell type in collectionView")
                        return
                }
                
                cell.displayItem(item)
            }
            
            let removeItem = {
                let indexPath = IndexPath(row: i, section: 0)
                guard let cell = self.partyCollectionView.cellForItem(at: indexPath)
                    as? HeroItemCell else {
                        assertionFailure("wrong cell type in collectionView")
                        return
                }
                
                cell.hideItem()
            }
            
            let slot = context.game.party.slot(atIndex: i)
            
            slot.onSetItem = updateItem
            slot.onRemoveItem = removeItem
        }
        
        // enemy
        let updateEnemy = { (enemy: Enemy) -> Void in
            
            //enemyView.displayEnemy(enemy)
        }
        
        //context.battle.onAddEnemy.onSetItemAtIndex = updateItemAtIndex
    }
    
    //MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(context != nil, "loaded without context")
        
        battleCollectionView.dataSource = self
        
        partyCollectionView.register(UINib(nibName: "HeroItemCell", bundle: Bundle.main), forCellWithReuseIdentifier: "HeroItemCell")
        partyCollectionView.dataSource = self
        partyCollectionView.dioDelegate = self
        partyCollectionView.dioDataSource = self
        
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
        self.goldButton.setTitle(context.game.money.description, for: .normal)
    }

}


extension BattleViewController: DIOCollectionViewDataSource, DIOCollectionViewDelegate {
    
    // DIOCollectionView DataSource
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, userDataForItemAtIndexPath indexPath: IndexPath) -> Any? {
        
        if dioCollectionView == partyCollectionView {
            return context.party.slot(atIndex: indexPath.row).getHero()
        }
        
        return nil
    }
    
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, shouldDragItemAtIndexPath indexPath: IndexPath) -> Bool {
        if dioCollectionView == partyCollectionView {
            return context.party.slot(atIndex: indexPath.row).hasHero
        }
        else {
            return false
        }
    }
    
    // DIOCollectionView Delegate
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, draggedItemAtIndexPath indexPath: IndexPath, withDragState dragState: DIODragState) {
        
    }
}

extension BattleViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == partyCollectionView {
            return context.party.slotCount
        }
        
        if collectionView == battleCollectionView {
            return 0//1
        }
        
        assertionFailure("collectionView not implemented")
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == partyCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroItemCell",
                                                          for: indexPath) as! HeroItemCell
            
            let slot = context.game.party.slot(atIndex: indexPath.row)
            if slot.hasItem {
                cell.displayItem(slot.getItem())
            } else {
                cell.hideItem()
            }
            
            if slot.hasHero {
                cell.displayHero(slot.getHero())
            } else {
                cell.hideHero()
            }
            
            return cell
        }
        
        if collectionView == battleCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EnemyCell",
                                                          for: indexPath) as! EnemyCell
            
            if context.battle.hasEnemy {
                cell.displayEnemy(context.battle.currentEnemy())
            } else {
                cell.hideEnemy()
            }
            
            return cell
        }
        
        fatalError("collectionView not implemented")
    }
}
