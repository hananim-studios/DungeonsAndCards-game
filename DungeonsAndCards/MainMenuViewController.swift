//
//  MainMenuViewController.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 24/11/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit
import WatchConnectivity

// MARK: - UIViewController
class MainMenuViewController: UIViewController {
    
    // MARK: - Model
    var menu = MainMenu()

    // MARK: - Variables
    override var prefersStatusBarHidden: Bool{ return true }
    
    // MARK: - IBOutlets
    @IBOutlet weak var continueGameButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    
    //MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup model
        menu.onStartGame = {
            game in
            
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "heroShop") as! HeroShopViewController
            vc.context = HeroShopContext(withGame: game)
            
            let nav = self.navigationController!
            nav.popViewController(animated: false)
            nav.pushViewController(vc, animated: false)
        }
        
        menu.onContinueGame = {
            game in
            
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "heroShop") as! HeroShopViewController
            vc.context = HeroShopContext(withGame: game)
            
            let nav = self.navigationController!
            nav.popViewController(animated: false)
            nav.pushViewController(vc, animated: false)
        }
        
        // setup UI
        continueGameButton.isEnabled = Game.hasSavedGame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.newGameButton.alpha = 1;
        self.continueGameButton.alpha = 1;
        self.continueGameButton.isHidden = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Button Actions
    @IBAction func continueGameButtonPressed(_ sender: Any) {
        /*performSegue(withIdentifier: "menuToManagePartySegue", sender: nil)
        UIView.animate(withDuration: 0.1, animations:{
            self.newGameButton.alpha = 0.0
            self.continueGameButton.alpha = 0.0
        })*/
    }
    
    @IBAction func newGameButtonPressed(_ sender: Any) {

        menu.startGame()
        
        /*performSegue(withIdentifier: "mainMenuToIntro", sender: nil)
        UIView.animate(withDuration: 0.1, animations:{
            self.newGameButton.alpha = 0.0
            self.continueGameButton.alpha = 0.0
        })*/
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /*if let gameViewController = segue.destination as? GameViewController {
            gameViewController.context
        }*/
    }
}
