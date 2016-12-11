//
//  ShopViewController.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 25/11/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK - Model
    var game = Game.newGame()
    
    //MARK - Variables
    override var prefersStatusBarHidden: Bool{ return true }
    
    //MARK - IBOutlets
    @IBOutlet weak var partyCollectionView: HeroCollectionView!
    @IBOutlet weak var itemCollectionView: HeroCollectionView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var goldButton: UIButton!
    
    //MARK - ViewController
    
    override func viewDidAppear(_ animated: Bool) {
        partyCollectionView.scrollToItem(at: IndexPath.init(row: 1, section: 0), at: .centeredHorizontally, animated: false)
        itemCollectionView.scrollToItem(at: IndexPath.init(row: 1, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemCollectionView.backgroundColor = UIColor.clear
        itemCollectionView.setScaledDesginParam(scaledPattern: .HorizontalCenter, maxScale: 2.2, minScale: 0.8, maxAlpha: 1.0, minAlpha: 0.85)
        
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.dioDataSource = self
        itemCollectionView.dioDelegate = self
        itemCollectionView.register(UINib(nibName: "ItemCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ItemCell")
        itemCollectionView.heroDelegate = self
        
        partyCollectionView.backgroundColor = UIColor.clear
        partyCollectionView.setScaledDesginParam(scaledPattern: .HorizontalCenter, maxScale: 1.0, minScale: 1.0, maxAlpha: 1.0, minAlpha: 1.0)
        
        partyCollectionView.delegate = self
        partyCollectionView.dataSource = self
        partyCollectionView.dioDataSource = self
        partyCollectionView.dioDelegate = self
        //partyCollectionView.heroDelegate = self
        partyCollectionView.receiveDrag = true
        partyCollectionView.allowFeedback = true
        partyCollectionView.register(UINib(nibName: "HeroItemCell", bundle: Bundle.main), forCellWithReuseIdentifier: "HeroItemCell")
        partyCollectionView.heroDelegate = self
        
        self.game.delegate = self
        updateGold()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - IBOulet Actions
    @IBAction func nextButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goldButtonPressed(_ sender: Any) {
        //Img and Label Function
    }
    
    //MARK - CollectionView DataSources
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == itemCollectionView {
            
            return 5
        }
        
        if collectionView == partyCollectionView {
            
            return 3
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == itemCollectionView {
            // cell for hand
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell",
                                                          for: indexPath) as! ItemCell
            
            cell.setItem(ItemsJSON.itemAtIndex(index: 0))
            
            return cell
        }
        
        if collectionView == partyCollectionView {
            // cell for party
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroItemCell",
                                                      for: indexPath) as! HeroItemCell
        
            cell.setHero(self.game.party.slot(atIndex: indexPath.row).hero)
            cell.setItem(self.game.party.slot(atIndex: indexPath.row).item) // TODO: SET ITEM
        
            return cell
        }
        
        fatalError("collectionView not implemented")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == itemCollectionView {
            
            return 1
        }
        
        if collectionView == partyCollectionView {
            
            return 1
        }
        
        return 0
    }
    
    //MARK - UICollectionViewFlowLayoutDelegates
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let screenSize = UIScreen.main.bounds.width
        let collectionSize = collectionView.contentSize.width
        let leftInset = (screenSize - collectionSize)/2
        let rightInset = leftInset
        print(rightInset)
        return UIEdgeInsetsMake(0, leftInset*0.5, 0, rightInset*0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == itemCollectionView {
            // size of hand cell
            //let width = collectionView.bounds.width
            let height = 0.9*collectionView.bounds.height
            return CGSize(width: height/3, height: height)
        }
        
        if collectionView == partyCollectionView {
            // size of party cell
            let width = collectionView.bounds.width
            let height = 0.8*collectionView.bounds.height
            return CGSize(width: 0.80*CGFloat(Float(width)/Float(3)), height: height)
        }
        
        return CGSize.zero
    }
    
    //MARK - ScrollView Delegates
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        itemCollectionView.scaledVisibleCells()
        partyCollectionView.scaledVisibleCells()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // MARK: - Convenience Methods
    func updateGold() {
        self.goldButton.setTitle(self.game.money.description, for: .normal)
    }
}

extension ShopViewController: DIOCollectionViewDataSource, DIOCollectionViewDelegate {
    
    // DIOCollectionView DataSource
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, userDataForItemAtIndexPath indexPath: IndexPath) -> Any? {
        
        if dioCollectionView == itemCollectionView {
            return self.game.itemShop.items[indexPath.row]
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
    
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, viewForItemAtIndexPath indexPath: IndexPath) -> UIView {
        
        if(dioCollectionView == partyCollectionView) {
            return UIImageView(image: UIImage(named: (dioCollectionView.cellForItem(at: indexPath) as! HeroItemCell).item!.image))
        }
        
        if(dioCollectionView == itemCollectionView) {
            return UIImageView(image: UIImage(named: (dioCollectionView.cellForItem(at: indexPath) as! ItemCell).item!.image))
        }
        
        fatalError("collectionView not implemented")
    }
    
}

extension ShopViewController: HeroCollectionViewDelegate {
    
    func heroCollectionView(_ heroCollectionView: HeroCollectionView, dragEndedWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath) {
        
        guard let dragInfo = dragInfo else { return }
        guard let item = dragInfo.userData as? Item else { return }
        guard let cell = heroCollectionView.cellForItem(at: indexPath) as? HeroItemCell else { return }
        
        let senderView = dragInfo.sender
        
        if(senderView == self.itemCollectionView) { // DRAGGED FROM HAND
            if cell.item == nil {
                
                
                if(heroCollectionView == self.partyCollectionView) { // TO PARTY
                    
                    // - MARK: EVENT: PLAYER DRAGGED HERO FROM HAND TO PARTY
                    // REFACTOR HINT: DELEGATE THIS BEHAVIOR
                    
                    dragInfo.sender.dragView?.isHidden = true
                    
                    fatalError()//self.game.buyItem(item: item, atSlot: indexPath.row)
                    cell.setItem(item)
                }
            }
        }
        
        if(senderView == self.partyCollectionView) { // DRAGGED FROM PARTY
            if cell.hero == nil {
                
                
                if(heroCollectionView == self.partyCollectionView) { // TO PARTY
                    
                    // - MARK: EVENT: PLAYER DRAGGED HERO FROM PARTY TO PARTY
                    // REFACTOR HINT: DELEGATE THIS BEHAVIOR
                    
                    dragInfo.sender.dragView?.isHidden = true
                    
                    //self.game.partyHeroes[indexPath.row] = hero
                    //cell.setHero(hero)
                    
                    print("entered \(indexPath)")
                }
            }
        }
    }
    
    func heroCollectionView(_ heroCollectionView: HeroCollectionView, dragEnteredWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath) {
        
    }
    
    func heroCollectionView(_ heroCollectionView: HeroCollectionView, dragLeftWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath) {
        
    }
}

extension ShopViewController: GameDelegate {
    
    func game(_ game: Game, didAttack hero: Hero, onHeroAtSlot slot: Int) {
        
    }
    
    func game(_ game: Game, changedGoldTo gold: Int) {
        updateGold()
    }
    
    func game(_ game: Game, didHireHero hero: Hero, atSlot slot: Int) {
        
    }
    
    func game(_ game: Game, didDismissHero hero: Hero, atSlot slot: Int) {
        
    }
    
    func game(_ game: Game, didSwapHero selectedHeroIndex: Int, swapHeroIndex: Int) {
        
    }
    
    func game(_ game: Game, didUseItem item: Item, onHeroAtSlot slot: Int) {
        
    }
    
    func game(_ game: Game, didBuyItem item: Item, atSlot slot: Int) {
        
    }
}
