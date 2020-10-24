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
        
        title = ""
        
        let defaults = UserDefaults.standard
       
        let firstname = defaults.string(forKey: "firstname") ?? ""
        let lastname = defaults.string(forKey: "lastname") ?? ""
        let name = "\(lastname) \(firstname)"
        let job = defaults.string(forKey: "job") ?? ""
        
        let period = "\(hrDate(date: startDate!)) - \(hrDate(date: endDate!))"
        let (workdays, _) = countDays(from: startDate!, to: endDate!)
        let (dd, mm, yy) = dateComponents(date: Date())
        
        var newImage = textToImage(drawText: name, inImage: UIImage(named: "concediu")!, atPoint: CGPoint(x: 270.0, y: 652.03))
        newImage = textToImage(drawText: job, inImage: newImage, atPoint: CGPoint(x: 500.0, y: 710.03))
        newImage = textToImage(drawText: period, inImage: newImage, atPoint: CGPoint(x: 380.0, y: 850.03))
        newImage = textToImage(drawText: "\(workdays)", inImage: newImage, atPoint: CGPoint(x: 200.0, y: 980.03))
        newImage = textToImage(drawText: "\(dd)", inImage: newImage, atPoint: CGPoint(x: 170.0, y: 1296.03))
        newImage = textToImage(drawText: "\(mm)", inImage: newImage, atPoint: CGPoint(x: 235.0, y: 1296.03))
        newImage = textToImage(drawText: "\(yy)", inImage: newImage, atPoint: CGPoint(x: 310.0, y: 1296.03))
        
        
        
        let x = imageView.bounds.width * 580.0 / newImage.size.width
        let y = (newImage.size.width/newImage.size.height) * imageView.bounds.height * 1280.0 / newImage.size.height
        
        let signImageView = UIImageView(frame: CGRect(x: x, y: y,
                                                      width: 100, height: 40))
        signImageView.image = getSavedImage(named: "signature.png")
        imageView.addSubview(signImageView)
        
        imageView.image = newImage
        
        
        // save new image
        let bottomImage = newImage
        let topImage = getSavedImage(named: "signature.png")!

        let newSize = newImage.size // set this to what you need
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)

        bottomImage.draw(in: CGRect(origin: .zero,
                                    size: newSize))
        topImage.draw(in: CGRect(origin: CGPoint(x: 720, y: 1280),
                                 size: CGSize(width: 100, height: 40)))

        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    
    func textToImage(drawText text: String,
                     inImage image: UIImage,
                     atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.red
        let textFont = UIFont(name: "Helvetica Bold", size: 24)!

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

}

