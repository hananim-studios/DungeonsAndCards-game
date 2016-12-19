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
            
            let viewId = UserDefaults.standard.string(forKey: "view") ?? "heroShop"
            let vc = self.storyboard!.instantiateViewController(withIdentifier: viewId) as! GameViewController
            
            switch(viewId) {
            case "heroShop":
                vc.baseContext = HeroShopContext(withGame: game)
            case "itemShop":
                vc.baseContext = ItemShopContext(withGame: game)
            case "battle":
                vc.baseContext = BattleContext(withGame: game)
            default:
                assertionFailure("unknown view id \(viewId)")
                vc.baseContext = HeroShopContext(withGame: game)
            }
            
            let nav = self.navigationController!
            nav.popViewController(animated: false)
            nav.pushViewController(vc, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.newGameButton.alpha = 1;
        //self.continueGameButton.alpha = 1;
        //self.continueGameButton.isHidden = false;
        
        // Soundtrack
        Soundtrack.sharedInstance.enableTracks(named: ["harp"], volume: 1, fade: false)
        Soundtrack.sharedInstance.enableTracks(named: ["percussion"], volume: 0.3, fade: false)
        
        // setup UI
        continueGameButton.isHidden = !Game.hasSavedGame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Button Actions
    @IBAction func continueGameButtonPressed(_ sender: Any) {
        menu.continueGame()
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
