//
//  ManagePartyViewController.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 25/11/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let arraySize = 3
    
    //MARK - Variables
    override var prefersStatusBarHidden: Bool{ return true }
    private let cardsCellIdentifier = "cardsCollectionCell"
    private let itemsCellIdentifier = "itemsCollectionCell"
    
    //MARK - IBOutlets
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK - ViewController
    override func viewDidAppear(_ animated: Bool) {
        
        
        cardsCollectionView.scrollToItem(at: IndexPath.init(row: 1, section: 0), at: .centeredHorizontally, animated: false)
        itemsCollectionView.scrollToItem(at: IndexPath.init(row: 1, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsCollectionView.tag = 1
        itemsCollectionView.tag = 0
        
        cardsCollectionView.backgroundColor = UIColor.clear
        cardsCollectionView.setScaledDesginParam(scaledPattern: .HorizontalCenter, maxScale: 2.2, minScale: 0.8, maxAlpha: 1.0, minAlpha: 0.85)
        
        itemsCollectionView.backgroundColor = UIColor.clear
        itemsCollectionView.setScaledDesginParam(scaledPattern: .HorizontalCenter, maxScale: 1.0, minScale: 1.0, maxAlpha: 1.0, minAlpha: 1.0)
        
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        
        itemsCollectionView.delegate = self
        itemsCollectionView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK: - IBOulet Actions
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "managePartyToItemsSegue", sender: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "itemsToManagePartySegue", sender: nil)
    }
    
    @IBAction func goldButtonPressed(_ sender: Any) {
        //Img and Label Function
    }
    
    //MARK - CollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 0 {
            //Items
            return arraySize
        }
        else {
            //Cards
            return arraySize
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            //Items
            let cell: AnyObject = collectionView.dequeueReusableCell(withReuseIdentifier: itemsCellIdentifier, for: indexPath as IndexPath)
            return cell as! UICollectionViewCell
        }
        else {
            //Cards
            let cell: AnyObject = collectionView.dequeueReusableCell(withReuseIdentifier: cardsCellIdentifier, for: indexPath as IndexPath)
            return cell as! UICollectionViewCell
        }
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
        
        if collectionView.tag == 0 {
            //items
            let width = collectionView.bounds.width
            let height = 0.8*collectionView.bounds.height
            return CGSize(width: CGFloat(Float(width)/Float(arraySize)), height: height)
        }
        else {
            //cards
            let width = collectionView.bounds.width
            let height = 0.8*collectionView.bounds.height
            return CGSize(width: 0.80*CGFloat(Float(width)/Float(arraySize)), height: height)
        }
    }
    
    //MARK - ScrollView Delegates
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        cardsCollectionView.scaledVisibleCells()
        itemsCollectionView.scaledVisibleCells()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue is CustomSegue {
            (segue as! CustomSegue).animationType = .fade
        }
    }
    
    @IBAction func returnFromSegueActions(sender: UIStoryboardSegue){
        if sender is CustomUnwindSegue {
            (sender as! CustomUnwindSegue).animationType = .fade
        }
    }
    // MARK: - Convenience Methods
    
}
