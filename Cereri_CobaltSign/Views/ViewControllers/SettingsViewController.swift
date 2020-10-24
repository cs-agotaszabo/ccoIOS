//
//  SettingsViewController.swift
//  Cereri_CobaltSign
//
//  Created by Valentina Vențel on 24/10/2020.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var canvasView: Canvas!
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var lastnameTextfield: UITextField!
    @IBOutlet weak var firstnameTextfield: UITextField!
    @IBOutlet weak var jobTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        lastnameTextfield.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0,
                                                          width: 10.0, height: 2.0))
        lastnameTextfield.leftViewMode = .always
        firstnameTextfield.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0,
                                                           width: 10.0, height: 2.0))
        firstnameTextfield.leftViewMode = .always
        jobTextfield.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0,
                                                     width: 10.0, height: 2.0))
        jobTextfield.leftViewMode = .always
        
        
        firstnameTextfield.text = defaults.string(forKey: "firstname")
        lastnameTextfield.text = defaults.string(forKey: "lastname")
        jobTextfield.text = defaults.string(forKey: "job")
        
        let signatureImage = getSavedImage(named: "signature.png")
        if let signature = signatureImage {
            let imageView = UIImageView()
            imageView.frame = canvasView.bounds
            imageView.image = signature
            //view.addSubview(imageView)
        }
    }
    

    fileprivate func doDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doSave(_ sender: Any) {
        validateDataInTextFIelds()
        
        doDismiss()
    }
    
    func validateDataInTextFIelds() {
       
        defaults.set(firstnameTextfield.text, forKey: "firstname")
        defaults.set(lastnameTextfield.text, forKey: "lastname")
        defaults.set(jobTextfield.text, forKey: "job")

        defaults.synchronize()
        
        let signImage = canvasView.asImage()
        saveImage(image: signImage)
        
    }
    
    

}

extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
