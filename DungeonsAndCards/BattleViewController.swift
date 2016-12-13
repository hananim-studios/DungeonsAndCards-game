//
//  BattleViewController.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 25/11/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK - Model
    var context: BattleContext!
    
    //MARK - Variables
    override var prefersStatusBarHidden: Bool{ return true }
    
    //MARK - IBOutlets
    @IBOutlet weak var partyCollectionView: DACCollectionView!
    @IBOutlet weak var battleCollectionView: DACCollectionView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var goldButton: UIButton!
    
    //MARK - ViewController
    override func viewWillAppear(_ animated: Bool) {
        
        // INIT AND BIND UI
        
        self.partyCollectionView.reloadData()
        self.partyCollectionView.layoutIfNeeded()
        self.battleCollectionView.reloadData()
        self.battleCollectionView.layoutIfNeeded()
        
        // money
        let updateMoney = { (value: Int) -> Void in
            self.goldButton.setTitle(value.description, for: .normal)
        }
        updateMoney(context.game.money)
        context.game.onMoneyChanged = updateMoney
        
        // party
        for i in 0..<context.game.party.slotCount {
            let updateHero = { (hero: Hero) -> Void in
                
                let indexPath = IndexPath(row: i, section: 0)
                guard let cell = self.partyCollectionView.cellForItem(at: indexPath)
                    as? HeroPartyCell else {
                        assertionFailure("wrong cell type in collectionView")
                        return
                }
                
                cell.displayHero(hero)
            }
            
            let removeHero = {
                let indexPath = IndexPath(row: i, section: 0)
                guard let cell = self.partyCollectionView.cellForItem(at: indexPath)
                    as? HeroPartyCell else {
                        assertionFailure("wrong cell type in collectionView")
                        return
                }
                
                cell.hideHero()
            }
            
            let slot = context.game.party.slot(atIndex: i)
            
            slot.onSetHero = updateHero
            slot.onRemoveHero = removeHero
        }
        
        // battle
        let updateBattle = { (index: Int) -> Void in
            
            let indexPath = IndexPath(row: 0, section: 0)
            
            let cell = self.battleCollectionView.cellForItem(at: indexPath) as! EnemyCell
            
            if self.context.battle.hasEnemy {
                cell.displayEnemy(self.context.battle.currentEnemy())
            } else {
                cell.hideEnemy()
            }
            
            let hCell = self.partyCollectionView.cellForItem(at: IndexPath(row: index, section: 0)) as! HeroPartyCell
            
            let slot = self.context.game.party.slot(atIndex: index)
            if slot.hasHero {
                hCell.displayHero(slot.getHero())
            } else {
                hCell.hideHero()
            }
        }
        
        context.onAttackEnemyWithHeroAtIndex = updateBattle
    }
    override func viewDidAppear(_ animated: Bool) {
        
        partyCollectionView.scrollToItem(at: IndexPath.init(row:partyCollectionView.numberOfItems(inSection: 0)/2, section: 0), at: .centeredHorizontally, animated: false)
        battleCollectionView.scrollToItem(at: IndexPath.init(row:battleCollectionView.numberOfItems(inSection: 0)/2, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(context != nil, "loaded without context")
        
        //battleCollectionView.backgroundColor = UIColor.clear
        battleCollectionView.setScaledDesginParam(scaledPattern: .HorizontalCenter, maxScale: 1.0, minScale: 0.8, maxAlpha: 1.0, minAlpha: 0.85)
        
        battleCollectionView.delegate = self
        battleCollectionView.dataSource = self
        battleCollectionView.dioDataSource = self
        battleCollectionView.dioDelegate = self
        battleCollectionView.dacDelegate = self
        battleCollectionView.register(UINib(nibName: "EnemyCell", bundle: Bundle.main), forCellWithReuseIdentifier: "EnemyCell")
        
        //partyCollectionView.backgroundColor = UIColor.clear
        partyCollectionView.setScaledDesginParam(scaledPattern: .HorizontalCenter, maxScale: 1.0, minScale: 0.8, maxAlpha: 1.0, minAlpha: 0.85)
        
        partyCollectionView.delegate = self
        partyCollectionView.dataSource = self
        partyCollectionView.dioDataSource = self
        partyCollectionView.dioDelegate = self
        partyCollectionView.dacDelegate = self
        partyCollectionView.receiveDrag = true
        partyCollectionView.allowFeedback = false
        partyCollectionView.register(UINib(nibName: "HeroPartyCell", bundle: Bundle.main), forCellWithReuseIdentifier: "HeroPartyCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - IBOulet Actions
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "heroShop") as! HeroShopViewController
        vc.context = HeroShopContext(withGame: context.game)
        
        let nav = self.navigationController!
        nav.popViewController(animated: false)
        nav.pushViewController(vc, animated: false)
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        //_ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goldButtonPressed(_ sender: Any) {
        //Img and Label Function
    }
    
    @IBAction func callGold(_ sender: Any) {
        
    }
    
    //MARK - CollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == battleCollectionView {
            
            return 1
        }
        
        if collectionView == partyCollectionView {
            
            return context.game.party.slotCount
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
        
        if collectionView == partyCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroPartyCell",
                                                          for: indexPath) as! HeroPartyCell
            
            let slot = context.game.party.slot(atIndex: indexPath.row)
            if slot.hasHero {
                cell.displayHero(slot.getHero())
            } else {
                cell.hideHero()
            }
            
            
            return cell
        }
        
        fatalError("collectionView not implemented")
    }
    
    //MARK - UICollectionViewFlowLayoutDelegates
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let screenSize = UIScreen.main.bounds.width
        let collectionSize = collectionView.contentSize.width
        let leftInset = (screenSize - collectionSize)/2
        let rightInset = leftInset
        return UIEdgeInsetsMake(0, leftInset*0.5, 0, rightInset*0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == battleCollectionView {
            // size of hand cell
            //let width = collectionView.bounds.width
            //let height = 0.9*collectionView.bounds.height
            //return CGSize(width: CGFloat(Float(width)/Float(3)), height: height)
            let height = 0.9*collectionView.bounds.height
            
            return CGSize(width: height/2, height: height)
        }
        
        if collectionView == partyCollectionView {
            // size of party cell
            //let width = collectionView.bounds.width
            //let height = 0.9*collectionView.bounds.height
            //return CGSize(width: CGFloat(Float(width)/Float(3)), height: height)
            
            let height = 0.9*collectionView.bounds.height
            
            return CGSize(width: height/2, height: height)
        }
        
        return CGSize.zero
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // MARK: - Convenience Methods
    
}

extension BattleViewController: DIOCollectionViewDataSource, DIOCollectionViewDelegate {
    
    // DIOCollectionView DataSource
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, userDataForItemAtIndexPath indexPath: IndexPath) -> Any? {
        
        if dioCollectionView == partyCollectionView {
            return context.party.slot(atIndex: indexPath.row).getHero()
        }
        
        assertionFailure("collectionView not implemented")
        
        return nil
    }
    
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, shouldDragItemAtIndexPath indexPath: IndexPath) -> Bool {
        if dioCollectionView == partyCollectionView {
            
            if context.party.hasSlot(atIndex: indexPath.row) {
                
                return context.party.slot(atIndex: indexPath.row).hasHero
            }
            
            return false
        }
        
        if dioCollectionView == battleCollectionView {
            
            
            return false
        }
        
        fatalError("collectionView not implemented")
    }
    
    // DIOCollectionView Delegate
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, draggedItemAtIndexPath indexPath: IndexPath, withDragState dragState: DIODragState) {
        
        if dioCollectionView == partyCollectionView {
            
            guard let cell = dioCollectionView.cellForItem(at: indexPath) as? HeroPartyCell else {
                assertionFailure("wrong cell type in collectionView")
                return
            }
            
            switch dragState {
            case .cancelled:
                
                dioCollectionView.dragView?.removeFromSuperview()
                
            case .began:
                
                cell.hideHero()
                
            case .ended:
                
                dioCollectionView.dragView?.removeFromSuperview()
                    
                cell.displayHero(context.party.slot(atIndex: indexPath.row).getHero())
            default:
                break
            }
        }
    }
}

extension BattleViewController: DACCollectionViewDelegate {
    
    func dacCollectionView(_ dacCollectionView: DACCollectionView, dragEnteredWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath) {
        
        
    }
    
    func dacCollectionView(_ dacCollectionView: DACCollectionView, dragLeftWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath) {
        
        
    }
    
    func dacCollectionView(_ dacCollectionView: DACCollectionView, dragEndedWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath) {
        
        guard let dragInfo = dragInfo else { return }
        
        if dacCollectionView == battleCollectionView {
            
            if dragInfo.sender == partyCollectionView {
                
                let battleIndex = indexPath.row
                let partyIndex = dragInfo.indexPath.row
                
                context.attackEnemy(withHeroAtIndex: partyIndex)
                
                
                /*guard context.canBuyHero(toPartyIndex: indexPath.row) == .success else {
                    // TODO: - Feedback
                    // could not buy hero to party index
                    
                    return
                }
                
                context.buyHero(atShopIndex: shopIndex, toPartyIndex: partyIndex)*/
            }
            
        }
    }
}
