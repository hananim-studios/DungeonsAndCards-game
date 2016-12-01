//
//  MainMenuViewController.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 24/11/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    // MARK: - Variables
    override var prefersStatusBarHidden: Bool{ return true }
    // MARK: - IBOutlets
    @IBOutlet weak var continueGameButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    
    //MARK: - ViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.newGameButton.alpha = 1;
        self.continueGameButton.alpha = 1;
        self.continueGameButton.isHidden = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let party = Party.init()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Button Actions
    @IBAction func continueGameButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "menuToManagePartySegue", sender: nil)
        UIView.animate(withDuration: 0.1, animations:{
            self.newGameButton.alpha = 0.0
            self.continueGameButton.alpha = 0.0
        })
    }
    
    @IBAction func newGameButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "mainMenuToIntro", sender: nil)
        UIView.animate(withDuration: 0.1, animations:{
            self.newGameButton.alpha = 0.0
            self.continueGameButton.alpha = 0.0
        })
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
