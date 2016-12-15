//
//  ItemItemShopViewController.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 25/11/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit

class ItemShopViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK - Model
    var context: ItemShopContext!
    
    //MARK - Variables
    override var prefersStatusBarHidden: Bool{ return true }
    
    //MARK - IBOutlets
    @IBOutlet weak var partyCollectionView: DACCollectionView!
    @IBOutlet weak var shopCollectionView: DACCollectionView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var goldButton: UIButton!
    
    //MARK - ViewController
    
    override func viewWillAppear(_ animated: Bool) {
        // INIT AND BIND UI
        
        self.partyCollectionView.reloadData()
        self.partyCollectionView.layoutIfNeeded()
        self.shopCollectionView.reloadData()
        self.shopCollectionView.layoutIfNeeded()
        
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
        
        // shop
        let updateItemAtIndex = { (item: Item, index: Int) -> Void in
            
            let indexPath = IndexPath(row: index, section: 0)
            self.shopCollectionView.reloadItems(at: [indexPath])
        }
        
        context.game.itemShop.onSetItemAtIndex = updateItemAtIndex
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.partyCollectionView.reloadData()
        self.partyCollectionView.layoutIfNeeded()
        self.shopCollectionView.reloadData()
        self.shopCollectionView.layoutIfNeeded()
        
        partyCollectionView.scrollToItem(at: IndexPath.init(row:partyCollectionView.numberOfItems(inSection: 0)/2, section: 0), at: .centeredHorizontally, animated: false)
        shopCollectionView.scrollToItem(at: IndexPath.init(row:shopCollectionView.numberOfItems(inSection: 0)/2, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(context != nil, "loaded without context")
        
        //shopCollectionView.backgroundColor = UIColor.clear
        shopCollectionView.setScaledDesginParam(scaledPattern: .HorizontalCenter, maxScale: 2.2, minScale: 0.8, maxAlpha: 1.0, minAlpha: 0.85)
        
        shopCollectionView.delegate = self
        shopCollectionView.dataSource = self
        shopCollectionView.dioDataSource = self
        shopCollectionView.dioDelegate = self
        shopCollectionView.register(UINib(nibName: "ItemCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ItemCell")
        shopCollectionView.dacDelegate = self
        
        //partyCollectionView.backgroundColor = UIColor.clear
        //partyCollectionView.setScaledDesginParam(scaledPattern: .HorizontalCenter, maxScale: 1.0, minScale: 1.0, maxAlpha: 1.0, minAlpha: 1.0)
        
        partyCollectionView.delegate = self
        partyCollectionView.dataSource = self
        partyCollectionView.dioDataSource = self
        partyCollectionView.dioDelegate = self
        //partyCollectionView.heroDelegate = self
        partyCollectionView.receiveDrag = true
        partyCollectionView.allowFeedback = true
        partyCollectionView.register(UINib(nibName: "HeroItemCell", bundle: Bundle.main), forCellWithReuseIdentifier: "HeroItemCell")
        partyCollectionView.dacDelegate = self
        
        //self.game.delegate = self
        updateGold()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - IBOulet Actions
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "battle") as! BattleViewController
        vc.context = BattleContext(withGame: context.game)
        
        let nav = self.navigationController!
        nav.popViewController(animated: false)
        nav.pushViewController(vc, animated: false)
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func goldButtonPressed(_ sender: Any) {
        //Img and Label Function
    }
    
    //MARK - CollectionView DataSources
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == shopCollectionView {
            
            return context.game.itemShop.itemCount
        }
        
        if collectionView == partyCollectionView {
            
            return context.game.party.slotCount
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == shopCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell",
                                                          for: indexPath) as! ItemCell
            
            let item = context.game.itemShop.item(atIndex: indexPath.row)
            cell.displayItem(item)
            
            return cell
        }
        
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
        
        fatalError("collectionView not implemented")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == shopCollectionView {
            
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
        return UIEdgeInsetsMake(0, leftInset*0.5, 0, rightInset*0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == shopCollectionView {
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
    func updateGold() {
        self.goldButton.setTitle(context.game.money.description, for: .normal)
    }
}

extension ItemShopViewController: DIOCollectionViewDataSource, DIOCollectionViewDelegate {
    
    // DIOCollectionView DataSource
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, userDataForItemAtIndexPath indexPath: IndexPath) -> Any? {
        
        if dioCollectionView == shopCollectionView {
            return context.shop.item(atIndex: indexPath.row)
        }
        
        return nil
    }
    
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, shouldDragItemAtIndexPath indexPath: IndexPath) -> Bool {
        if dioCollectionView == partyCollectionView {
            return context.party.slot(atIndex: indexPath.row).hasItem
        }
        
        if dioCollectionView == shopCollectionView {
            
            return context.canBuyItem(atShopIndex: indexPath.row) == .success
        }
        
        fatalError("viewController not implemented")
    }
    
    // DIOCollectionView Delegate
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, draggedItemAtIndexPath indexPath: IndexPath, withDragState dragState: DIODragState) {
        
        if dioCollectionView == partyCollectionView {
            
            guard let cell = dioCollectionView.cellForItem(at: indexPath) as? HeroItemCell else {
                assertionFailure("wrong cell type in collectionView")
                return
            }
            
            switch dragState {
            case .cancelled:
                
                dioCollectionView.dragView?.removeFromSuperview()
            case .began:
                
                cell.hideItem()
            case .ended:
                
                dioCollectionView.dragView?.removeFromSuperview()
                
                if context.canRemoveItem(atPartyIndex: indexPath.row) == .success {
                    context.removeItem(atPartyIndex: indexPath.row)
                    
                    guard let cell = dioCollectionView.cellForItem(at: indexPath) as? HeroItemCell else {
                        assertionFailure("wrong cell type in collectionView")
                        return
                    }
                    
                    cell.hideItem()
                } else {
                    
                    cell.displayItem(context.party.slot(atIndex: indexPath.row).getItem())
                }
            default:
                break
            }
        }
        
        if dioCollectionView == shopCollectionView {
            
            switch dragState {
            case .cancelled:
                dioCollectionView.dragView?.removeFromSuperview()
                
            case .ended:
                dioCollectionView.dragView?.removeFromSuperview()
                
            default:
                break
            }
        }
    }
    
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, viewForItemAtIndexPath indexPath: IndexPath) -> UIView {
        
        if(dioCollectionView == partyCollectionView) {
            
            return UIImageView(image: UIImage(named: context.party.slot(atIndex: indexPath.row).getItem().image))
        }
        
        if(dioCollectionView == shopCollectionView) {
            return UIImageView(image: UIImage(named: context.shop.item(atIndex: indexPath.row).image))
        }
        
        fatalError("collectionView not implemented")
    }
    
}

extension ItemShopViewController: DACCollectionViewDelegate {
    
    func dacCollectionView(_ dacCollectionView: DACCollectionView, dragEndedWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath) {
        
        guard let dragInfo = dragInfo else { return }
        
        if dacCollectionView == partyCollectionView {
            
            let partyIndex = indexPath.row
            let shopIndex = dragInfo.indexPath.row
            
            
            guard context.canBuyItem(toPartyIndex: indexPath.row) == .success else {
                // TODO: - Feedback
                // could not buy hero to party index
                
                return
            }
            
            context.buyItem(atShopIndex: shopIndex, toPartyIndex: partyIndex)
        }
    }
    
    func dacCollectionView(_ dacCollectionView: DACCollectionView, dragEnteredWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath) {
        
    }
    
    func dacCollectionView(_ dacCollectionView: DACCollectionView, dragLeftWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath) {
        
    }
}
