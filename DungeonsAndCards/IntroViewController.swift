//
//  IntroViewController.swift
//  DungeonsAndCards
//
//  Created by Matheus Vasconcelos de Sousa on 24/11/16.
//  Copyright © 2016 hananim. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func skipIntroPressed(_ sender: Any) {
        performSegue(withIdentifier: "IntroToManageParty", sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue is CustomSegue {
            (segue as! CustomSegue).animationType = .fade
        }
    }
    
}
