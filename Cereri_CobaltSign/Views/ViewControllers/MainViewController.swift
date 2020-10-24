//
//  ViewController.swift
//  Cereri_CobaltSign
//
//  Created by Valentina Vențel on 23/10/2020.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkSettings()
    }
    
    @IBAction func showSettings(_ sender: Any) {
        performSegue(withIdentifier: "settingsSegue", sender: nil)
    }
    
    fileprivate func checkSettings() {
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
       
        let firstname = defaults.string(forKey: "firstname") ?? ""
        let lastname = defaults.string(forKey: "lastname") ?? ""
        let job = defaults.string(forKey: "job") ?? ""
        
        if firstname == "" || lastname == "" || job == "" {
            performSegue(withIdentifier: "settingsSegue", sender: nil)
        }
    }
    
}

