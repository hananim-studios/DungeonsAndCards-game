//
//  ManagePartyViewController.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 25/11/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit

class ManagePartyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    //MARK - Variables
    private let chooseCardsCellIdentifier = "chooseCardsCollectionCell"
    private let setCardsCellIdentifier = "setCardsCollectionCell"
    
    //MARK - IBOutlets
    @IBOutlet weak var setCardsCollectionView: UICollectionView!
    @IBOutlet weak var chooseCardsCollectionView: UICollectionView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //MARK - ViewController
    override func viewDidAppear(_ animated: Bool) {
        chooseCardsCollectionView.scrollToItem(at: IndexPath.init(row: 1, section: 0), at: .centeredHorizontally, animated: false)
        setCardsCollectionView.scrollToItem(at: IndexPath.init(row: 1, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseCardsCollectionView.tag = 0
        setCardsCollectionView.tag = 1
        
        chooseCardsCollectionView.backgroundColor = UIColor.clear
        chooseCardsCollectionView.setScaledDesginParam(scaledPattern: .HorizontalCenter, maxScale: 1.2, minScale: 0.8, maxAlpha: 1.0, minAlpha: 0.85)
        
        setCardsCollectionView.backgroundColor = UIColor.clear
        setCardsCollectionView.setScaledDesginParam(scaledPattern: .HorizontalCenter, maxScale: 1.0, minScale: 1.0, maxAlpha: 1.0, minAlpha: 1.0)
        
        chooseCardsCollectionView.delegate = self
        chooseCardsCollectionView.dataSource = self
        
        setCardsCollectionView.delegate = self
        setCardsCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK - CollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 0 {
            //Choose Cards Collection View
            return 5
        }
        else {
            //Set Cards Collection View
            return 5
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            //Choose Cards Collection View
            let cell: AnyObject = collectionView.dequeueReusableCell(withReuseIdentifier: chooseCardsCellIdentifier, for: indexPath as IndexPath)
            return cell as! UICollectionViewCell
        }
        else {
            //Set Cards Collection View
            let cell: AnyObject = collectionView.dequeueReusableCell(withReuseIdentifier: setCardsCellIdentifier, for: indexPath as IndexPath)
            return cell as! UICollectionViewCell
        }
    }
    
    //MARK - ScrollView Delegates
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        chooseCardsCollectionView.scaledVisibleCells()
        setCardsCollectionView.scaledVisibleCells()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue is CustomSegue {
            (segue as! CustomSegue).animationType = .fade
        }
    }
 
    // MARK: - Convenience Methods
    
}
