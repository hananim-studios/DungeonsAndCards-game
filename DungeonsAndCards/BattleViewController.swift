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
    @IBOutlet weak var partyCollectionView: DIOCollectionView!
    @IBOutlet weak var enemyView: EnemyView!
    
    //MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(context != nil, "loaded without context")
        
        partyCollectionView.register(UINib(nibName: "HeroItemCell", bundle: Bundle.main), forCellWithReuseIdentifier: "HeroItemCell")
        partyCollectionView.dataSource = self
        partyCollectionView.dioDelegate = self
        partyCollectionView.dioDataSource = self
        
        let oldView = enemyView
        enemyView = Bundle.main.loadNibNamed("EnemyView", owner: self, options: nil)![0] as! EnemyView
        enemyView.frame = oldView!.frame
        oldView!.removeFromSuperview()
        self.view.addSubview(enemyView)
        
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
            return true
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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == partyCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroItemCell",
                                                          for: indexPath) as! HeroItemCell
            
            cell.displayHero(context.party.slot(atIndex: indexPath.row).getHero())
            cell.displayItem(context.party.slot(atIndex: indexPath.row).getItem())
            
            return cell
        }
        
        fatalError("collectionView not implemented")
    }
}
