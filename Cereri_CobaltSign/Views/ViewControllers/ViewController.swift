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
    
    fileprivate func checkSettings() {
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        defaults.set("Vali", forKey: "firstname")
        
        let firstname = defaults.string(forKey: "firstname") ?? ""
        print("firstname = \(firstname)")
        let lastname = defaults.string(forKey: "lastname") ?? ""
        print("lastname = \(lastname)")
        let job = defaults.string(forKey: "job") ?? ""
        print("job = \(job)")
        
        if firstname == "" || lastname == "" || job == "" {
            performSegue(withIdentifier: "settingsSegue", sender: nil)
        }
    }
    
}

