//
//  ManagePartyViewController.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 25/11/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit

class ManagePartyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK - Model
    var game = Game()
    
    //MARK - Variables
    override var prefersStatusBarHidden: Bool{ return true }
    
    //MARK - IBOutlets
    @IBOutlet weak var partyCollectionView: HeroCollectionView!
    @IBOutlet weak var handCollectionView: HeroCollectionView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK - ViewController
    
    override func viewWillAppear(_ animated: Bool) {
        partyCollectionView.scrollToItem(at: IndexPath.init(row: 1, section: 0), at: .centeredHorizontally, animated: false)
        handCollectionView.scrollToItem(at: IndexPath.init(row: 1, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handCollectionView.backgroundColor = UIColor.clear
        handCollectionView.setScaledDesginParam(scaledPattern: .HorizontalCenter, maxScale: 2.2, minScale: 0.8, maxAlpha: 1.0, minAlpha: 0.85)
        
        handCollectionView.delegate = self
        handCollectionView.dataSource = self
        handCollectionView.dioDataSource = self
        handCollectionView.dioDelegate = self
        
        partyCollectionView.backgroundColor = UIColor.clear
        partyCollectionView.setScaledDesginParam(scaledPattern: .HorizontalCenter, maxScale: 1.0, minScale: 1.0, maxAlpha: 1.0, minAlpha: 1.0)
        
        partyCollectionView.delegate = self
        partyCollectionView.dataSource = self
        partyCollectionView.dioDataSource = self
        partyCollectionView.dioDelegate = self
        partyCollectionView.heroDelegate = self
        partyCollectionView.receiveDrag = true
        partyCollectionView.allowFeedback = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - IBOulet Actions
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "managePartyToItemsSegue", sender: nil)
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
    }    
    
    @IBAction func goldButtonPressed(_ sender: Any) {
        //Img and Label Function
    }
    
    //MARK - CollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == handCollectionView {
            
            return 5
        }
        
        if collectionView == partyCollectionView {
            
            return 3
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == handCollectionView {
            // cell for hand
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCell",
                                                          for: indexPath) as! HeroCell
            
            cell.setHero(self.game.handHeroes[indexPath.row])
            
            return cell
        }
        
        if collectionView == partyCollectionView {
            // cell for party
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCell",
                                                          for: indexPath) as! HeroCell
            
            cell.setHero(self.game.partyHeroes[indexPath.row])
            
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
        print(rightInset)
        return UIEdgeInsetsMake(0, leftInset*0.5, 0, rightInset*0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == handCollectionView {
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
        handCollectionView.scaledVisibleCells()
        partyCollectionView.scaledVisibleCells()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    
    // MARK: - Convenience Methods
    
}

extension ManagePartyViewController: DIOCollectionViewDataSource, DIOCollectionViewDelegate {
    
    // DIOCollectionView DataSource
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, dragInfoForItemAtIndexPath indexPath: IndexPath) -> DIODragInfo {
        
        if dioCollectionView == handCollectionView {
            return DIODragInfo(withUserData: self.game.handHeroes[indexPath.row])
        }
        
        if dioCollectionView == partyCollectionView {
            return DIODragInfo(withUserData: self.game.partyHeroes[indexPath.row])
        }
        
        return DIODragInfo(withUserData: nil)
    }
    
    // DIOCollectionView Delegate
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, draggedItemAtIndexPath indexPath: IndexPath, withDragState dragState: DIODragState) {
        
        switch(dragState) {
        case .ended:
            dioCollectionView.dragView?.removeFromSuperview()
        default:
            break
        }
        
        if dioCollectionView == handCollectionView {

        }
        
        if dioCollectionView == partyCollectionView {
            switch(dragState) {
            case .began:
                let cell = partyCollectionView.cellForItem(at: indexPath) as? HeroCell
                self.game.partyHeroes[indexPath.row] = nil
                cell?.setHero(nil)
            default:
                break
            }
        }
    }
    
}

extension ManagePartyViewController: HeroCollectionViewDelegate {
    
    func heroCollectionView(_ heroCollectionView: HeroCollectionView, dragEnteredWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath) {
        
        if(heroCollectionView == self.partyCollectionView) {
            if let hero = dragInfo?.userData as? Hero {
            
                if let cell = heroCollectionView.cellForItem(at: indexPath) as? HeroCell {
            
                    if cell.hero == nil {
                        
                        dragInfo?.sender?.dragView?.isHidden = true
        
                        cell.imageView.image = UIImage(named: hero.template)
                    }
                }
            }
        }
    }
    
    func heroCollectionView(_ heroCollectionView: HeroCollectionView, dragLeftWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath) {
        
        if(heroCollectionView == self.partyCollectionView) {
            if let _ = dragInfo?.userData as? Hero {
                
                if let cell = heroCollectionView.cellForItem(at: indexPath) as? HeroCell {
                    
                    if cell.hero == nil {
                        
                        dragInfo?.sender?.dragView?.isHidden = false
                        
                        cell.imageView.image = nil
                    }
                }
            }
        }
    }
    
    func heroCollectionView(_ heroCollectionView: HeroCollectionView, dragEndedWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath) {
        
        if(heroCollectionView == self.partyCollectionView) {
            if let hero = dragInfo?.userData as? Hero {
                
                if let cell = heroCollectionView.cellForItem(at: indexPath) as? HeroCell {
                    
                    if cell.hero == nil {
                        dragInfo?.sender?.dragView?.isHidden = true
                        
                        self.game.partyHeroes[indexPath.row] = hero
                        cell.setHero(hero)
                        
                        print("entered \(indexPath)")
                    }
                }
            }
        }
    }
}
