//
//  TestViewController.swift
//  Cereri_CobaltSign
//
//  Created by Valentina Vențel on 24/10/2020.
//

import Foundation
import UIKit

class PreviewViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var startDate: Date?
    var endDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = getSavedImage(named: "request.png")
    }
}

