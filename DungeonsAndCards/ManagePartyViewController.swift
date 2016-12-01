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
        
    }
    override func viewDidAppear(_ animated: Bool) {
        partyCollectionView.scrollToItem(at: IndexPath.init(row: 1, section: 0), at: .centeredHorizontally, animated: false)
        handCollectionView.scrollToItem(at: IndexPath.init(row: 1, section: 0), at: .centeredHorizontally, animated: false)
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
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }    
    
    @IBAction func goldButtonPressed(_ sender: Any) {
        //Img and Label Function
    }
    
    @IBAction func callGold(_ sender: Any) {
    
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
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCell",
                                                          for: indexPath) as! HeroCell
            
            cell.setHero(self.game.handHeroes[indexPath.row])
            
            return cell
        }
        
        if collectionView == partyCollectionView {
            
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
    func dioCollectionView(_ dioCollectionView: DIOCollectionView, userDataForItemAtIndexPath indexPath: IndexPath) -> Any? {
        
        if dioCollectionView == handCollectionView {
            return self.game.handHeroes[indexPath.row]
        }
            
        if dioCollectionView == partyCollectionView {
            return self.game.partyHeroes[indexPath.row]
        }
        
        return nil
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
        
        if dioCollectionView == handCollectionView {
            
        }
        
        if dioCollectionView == partyCollectionView {
            switch(dragState) {
            case .began:
                
                // - MARK: EVENT: PLAYER DISCARDED HERO
                self.game.partyHeroes[indexPath.row] = nil
                cell.setHero(nil)
                
            default:
                break
            }
        }
    }
    
}

extension ManagePartyViewController: HeroCollectionViewDelegate {
    
    func heroCollectionView(_ heroCollectionView: HeroCollectionView, dragEnteredWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath) {
        
        if(heroCollectionView == self.partyCollectionView) {
            if (dragInfo?.userData as? Hero) != nil {
            
                if let cell = heroCollectionView.cellForItem(at: indexPath) as? HeroCell {
            
                    if cell.hero == nil {
                        
                        UIView.animate(withDuration: 0.4, animations: {
                            dragInfo?.sender.dragView?.alpha = 1.0
                            dragInfo?.sender.dragView?.transform = CGAffineTransform.transformFromRect(from: dragInfo!.sender.dragView!.frame, toRect: cell.frame)
                        })
        
                        //cell.imageView.image = UIImage(named: hero.template)
                    }
                }
            }
        }
    }
    
    func heroCollectionView(_ heroCollectionView: HeroCollectionView, dragLeftWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath) {
        
        if(heroCollectionView == self.partyCollectionView) {
            
            if let cell = heroCollectionView.cellForItem(at: indexPath) as? HeroCell {
                
                if cell.hero == nil {
                    
                    UIView.animate(withDuration: 0.4, animations: {
                        dragInfo?.sender.dragView?.alpha = 0.95
                        dragInfo?.sender.dragView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                    })
                }
            }
        }
    }
    
    func heroCollectionView(_ heroCollectionView: HeroCollectionView, dragEndedWithDragInfo dragInfo: DIODragInfo?, atIndexPath indexPath: IndexPath) {
        
        guard let dragInfo = dragInfo else { return }
        guard let hero = dragInfo.userData as? Hero else { return }
        guard let cell = heroCollectionView.cellForItem(at: indexPath) as? HeroCell else { return }
        
        let senderView = dragInfo.sender
        
        if(senderView == self.handCollectionView) { // DRAGGED FROM HAND
            if cell.hero == nil {
                
                
                if(heroCollectionView == self.partyCollectionView) { // TO PARTY
                    
                    // - MARK: EVENT: PLAYER DRAGGED HERO FROM HAND TO PARTY
                    // REFACTOR HINT: DELEGATE THIS BEHAVIOR
                    
                    dragInfo.sender.dragView?.isHidden = true
                    
                    self.game.handHeroes[dragInfo.indexPath.row] = Hero(withTemplate: "shiny_wizard")
                    senderView.reloadItems(at: [dragInfo.indexPath])
                    senderView.reloadData()
                    
                    self.game.partyHeroes[indexPath.row] = hero
                    cell.setHero(hero)
                    
                    print("entered \(indexPath)")
                }
            }
        }
        
        if(senderView == self.partyCollectionView) { // DRAGGED FROM PARTY
            if cell.hero == nil {
                
                
                if(heroCollectionView == self.partyCollectionView) { // TO PARTY
                    
                    // - MARK: EVENT: PLAYER DRAGGED HERO FROM PARTY TO PARTY
                    // REFACTOR HINT: DELEGATE THIS BEHAVIOR
                    
                    dragInfo.sender.dragView?.isHidden = true
                    
                    self.game.partyHeroes[indexPath.row] = hero
                    cell.setHero(hero)
                    
                    print("entered \(indexPath)")
                }
            }
        }
    }
}
