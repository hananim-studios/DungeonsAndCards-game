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
    
    // MARK: - IBOutlets
    @IBOutlet weak var continueGameButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.newGameButton.alpha = 1;
        self.continueGameButton.isHidden = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Button Actions
    @IBAction func continueGameButtonPressed(_ sender: Any) {
    }
    
    @IBAction func newGameButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "mainMenuToIntro", sender: nil)
        
        UIView.animate(withDuration: 0.1, animations:{
           self.newGameButton.alpha = 0.0
        })
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue is CustomSegue {
            (segue as! CustomSegue).animationType = .slowFade
        }
    }
    
 

}
