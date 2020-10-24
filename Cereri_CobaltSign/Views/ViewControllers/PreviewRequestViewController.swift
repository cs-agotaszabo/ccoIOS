//
//  PreviewRequest.swift
//  Cereri_CobaltSign
//
//  Created by Valentina Vențel on 25/10/2020.
//

import Foundation
import UIKit

class PreviewRequestViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = getSavedImage(named: "pauseRequest.png")
    }
}
