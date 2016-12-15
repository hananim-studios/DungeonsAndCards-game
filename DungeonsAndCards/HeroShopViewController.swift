//
//  HeroShopViewController.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 25/11/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit

class HeroShopViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK - Soundtrack
    let enabledTracks = ["guitar"]
    let disabledTracks = ["drums1","drums2","drums3","erhu","strings"]
    
    //MARK - Model
    var context: HeroShopContext!
    
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
        
        // shop
        let updateHeroAtIndex = { (hero: Hero, index: Int) -> Void in
            
            let indexPath = IndexPath(row: index, section: 0)
            self.shopCollectionView.reloadItems(at: [indexPath])
        }
        
        context.game.heroShop.onSetHeroAtIndex = updateHeroAtIndex
    }
    override func viewDidAppear(_ animated: Bool) {
        
        partyCollectionView.scrollToItem(at: IndexPath.init(row:partyCollectionView.numberOfItems(inSection: 0)/2, section: 0), at: .centeredHorizontally, animated: false)
        shopCollectionView.scrollToItem(at: IndexPath.init(row:shopCollectionView.numberOfItems(inSection: 0)/2, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Soundtrack
        Soundtrack.sharedInstance.disableTracks(named: disabledTracks, withFade: true)
        Soundtrack.sharedInstance.enableTracks(named: enabledTracks, volume: 0.3, fade: true)
        
        assert(context != nil, "loaded without context")
        
        //shopCollectionView.backgroundColor = UIColor.clear
        shopCollectionView.setScaledDesginParam(scaledPattern: .HorizontalCenter, maxScale: 2.2, minScale: 0.8, maxAlpha: 1.0, minAlpha: 0.85)
        
        shopCollectionView.delegate = self
        shopCollectionView.dataSource = self
        shopCollectionView.dioDataSource = self
        shopCollectionView.dioDelegate = self
        shopCollectionView.register(UINib(nibName: "HeroShopCell", bundle: Bundle.main), forCellWithReuseIdentifier: "HeroShopCell")
        
        //partyCollectionView.backgroundColor = UIColor.clear
        partyCollectionView.setScaledDesginParam(scaledPattern: .HorizontalCenter, maxScale: 1.0, minScale: 1.0, maxAlpha: 1.0, minAlpha: 1.0)
        
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
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "itemShop") as! ItemShopViewController
        vc.context = ItemShopContext(withGame: context.game)
        
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
        
        if collectionView == shopCollectionView {
            
            return context.game.heroShop.heroCount
        }
        
        if collectionView == partyCollectionView {
            
            return context.game.party.slotCount
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == shopCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroShopCell",
                                                          for: indexPath) as! HeroShopCell
            
            let hero = context.game.heroShop.hero(atIndex: indexPath.row)
            cell.displayHero(hero)
            
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
    
}

extension HeroShopViewController: DIOCollectionViewDataSource, DIOCollectionViewDelegate {
    
    // DIOCollectionView DataSource
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, userDataForItemAtIndexPath indexPath: IndexPath) -> Any? {
        
        if dioCollectionView == shopCollectionView {
            return context.shop.hero(atIndex: indexPath.row)
        }
            
        if dioCollectionView == partyCollectionView {
            return context.party.slot(atIndex: indexPath.row).hasHero
        }
        
        fatalError("collectionView not implemented")
    }
    
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, shouldDragItemAtIndexPath indexPath: IndexPath) -> Bool {
        if dioCollectionView == partyCollectionView {
            
            if context.party.hasSlot(atIndex: indexPath.row) {
                
                return context.party.slot(atIndex: indexPath.row).hasHero
            }
            
            return false
        }
            
        if dioCollectionView == shopCollectionView {
            
            
            guard context.canBuyHero(atShopIndex: indexPath.row) == .success else {
                // TODO: - Feedback
                // could not buy hero at shop index
                
                return false
            }
            
            return true
        }
        
        fatalError("collectionView not implemented")
    }
    
    // DIOCollectionView Delegate
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, draggedItemAtIndexPath indexPath: IndexPath, withDragState dragState: DIODragState) {
        
        if dioCollectionView == partyCollectionView {
            
            switch dragState {
            case .cancelled:
                
                dioCollectionView.dragView?.removeFromSuperview()
                
            case .ended:
                
                dioCollectionView.dragView?.removeFromSuperview()
                
                if context.canRemoveHero(atPartyIndex: indexPath.row) == .success {
                    context.removeHero(atPartyIndex: indexPath.row)
                    
                    guard let cell = dioCollectionView.cellForItem(at: indexPath) as? HeroPartyCell else {
                        assertionFailure("wrong cell type in collectionView")
                        return
                    }
                    
                    cell.hideHero()
                }
            default:
                break
            }
        }
    }
}

extension HeroShopViewController: DACCollectionViewDelegate {
    
    func dacCollectionView(_ dacCollectionView: DACCollectionView, dragEnteredWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath) {
        
        
    }
    
    func dacCollectionView(_ dacCollectionView: DACCollectionView, dragLeftWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath) {
        
        
    }
    
    func dacCollectionView(_ dacCollectionView: DACCollectionView, dragEndedWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath) {
        
        guard let dragInfo = dragInfo else { return }
        
        if dacCollectionView == partyCollectionView {
            
            if dragInfo.sender == shopCollectionView {
                
                let partyIndex = indexPath.row
                let shopIndex = dragInfo.indexPath.row
                
                
                guard context.canBuyHero(toPartyIndex: indexPath.row) == .success else {
                    // TODO: - Feedback
                    // could not buy hero to party index
                    
                    return
                }
            
                context.buyHero(atShopIndex: shopIndex, toPartyIndex: partyIndex)
            }
            
        }
    }
}
