//
//  InvoireViewController.swift
//  Cereri_CobaltSign
//
//  Created by Valentina Vențel on 23/10/2020.
//

import Foundation
import UIKit

class InvoireViewController: UIViewController {
    let canvas = Canvas()
    
//    override func loadView() {
//        self.view.addSubview(canvas)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        canvas.backgroundColor = .blue
        canvas.frame = view.frame
        // Do any additional setup after loading the view.

        canvas.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(canvas)

    }

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
