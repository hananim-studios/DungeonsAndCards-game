//
//  BattleViewController.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 01/12/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {

    // MARK: - Variables
    override var prefersStatusBarHidden: Bool{ return true }
    // MARK: - IBOutlets
    @IBOutlet weak var continueGameButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    
    //MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Button Actions
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
