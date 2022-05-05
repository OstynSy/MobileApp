//
//  ViewController.swift
//  SteamApp
//
//  Created by JPL-ST-SPRING2021 on 5/3/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBAction func specials(_ sender: UIStoryboardSegue){
            performSegue(withIdentifier: "ToGameDescriptionSegue", sender: "Specials")
    }
    
    @IBAction func topSeller(_ sender: Any){
        performSegue(withIdentifier: "ToGameDescriptionSegue", sender: "TopSellers")
    }
    
    @IBAction func newReleases(_ sender: Any){
        performSegue(withIdentifier: "ToGameDescriptionSegue", sender: "NewReleases")
    }
    
    @IBAction func comingSoon(_ sender: Any){
        performSegue(withIdentifier: "ToGameDescriptionSegue", sender: "ComingSoon")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let TodoViewController = segue.destination as? TodoViewController else {
            return
        }
        guard let button = sender as? String else {
            return
        }
        TodoViewController.buttonClick = button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
}

