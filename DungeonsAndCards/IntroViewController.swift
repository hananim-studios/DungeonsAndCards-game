//
//  IntroViewController.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 24/11/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    //MARK - Variables
    override var prefersStatusBarHidden: Bool{ return true }

    //MARK - IBOutlets
    @IBOutlet weak var backgroundImage: UIImageView!

    //MARK - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - IBOulet Actions
    @IBAction func skipIntroButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "IntroToManageParty", sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    
    
}
