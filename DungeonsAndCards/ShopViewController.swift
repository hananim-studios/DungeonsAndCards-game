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
    var game = Game.sharedInstance
    
    //MARK - Variables
    override var prefersStatusBarHidden: Bool{ return true }
    
    //MARK - IBOutlets
    @IBOutlet weak var partyCollectionView: HeroCollectionView!
    @IBOutlet weak var itemCollectionView: ItemCollectionView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
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
        
        partyCollectionView.backgroundColor = UIColor.clear
        partyCollectionView.setScaledDesginParam(scaledPattern: .HorizontalCenter, maxScale: 1.0, minScale: 1.0, maxAlpha: 1.0, minAlpha: 1.0)
        
        partyCollectionView.delegate = self
        partyCollectionView.dataSource = self
        partyCollectionView.dioDataSource = self
        partyCollectionView.dioDelegate = self
        //partyCollectionView.heroDelegate = self
        partyCollectionView.receiveDrag = true
        partyCollectionView.allowFeedback = true
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
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCell",
                                                          for: indexPath) as! HeroCell
            
            cell.setHero(self.game.hand.heroes[indexPath.row])
            
            return cell
        }
        
        if collectionView == partyCollectionView {
            // cell for party
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroItemCell",
                                                      for: indexPath) as! HeroItemCell
        
            cell.setHero(self.game.party.heroes[indexPath.row])
        
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
            let width = collectionView.bounds.width
            let height = 0.8*collectionView.bounds.height
            return CGSize(width: CGFloat(Float(width)/Float(3)), height: height)
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
    
}

extension ShopViewController: DIOCollectionViewDataSource, DIOCollectionViewDelegate {
    
    // DIOCollectionView DataSource
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, userDataForItemAtIndexPath indexPath: IndexPath) -> Any? {
        
        if dioCollectionView == itemCollectionView {
            return nil// item //self.game.party.heroes[indexPath.row]
        }
        
        return nil
    }
    
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, shouldDragItemAtIndexPath indexPath: IndexPath) -> Bool {
        if dioCollectionView == partyCollectionView {
            return self.game.party.heroes[indexPath.row] != nil
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
            case .ended:
                
                // - MARK: EVENT: PLAYER DISCARDED HERO
                self.game.party.dismissHero(hero: cell.hero!, atSlot: indexPath.row)
                
            default:
                break
            }
        }
    }
    
}
