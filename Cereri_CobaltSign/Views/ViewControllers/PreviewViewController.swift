//
//  TestViewController.swift
//  Cereri_CobaltSign
//
//  Created by Valentina Vențel on 24/10/2020.
//

import Foundation
import UIKit

class PreviewViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let newImage = textToImage(drawText: "Valentina Vențel", inImage: UIImage(named: "concediu")!, atPoint: CGPoint(x: 220.0, y: 652.03))
//        let newImage1 = textToImage(drawText: "Developer iOS", inImage: newImage, atPoint: CGPoint(x: 450.0, y: 710.03))
//        let newImage2 = textToImage(drawText: "22.11.2020 - 30.11.2020", inImage: newImage1, atPoint: CGPoint(x: 380.0, y: 850.03))
//        let newImage3 = textToImage(drawText: "10", inImage: newImage2, atPoint: CGPoint(x: 150.0, y: 980.03))
//
//        let newImage4 = textToImage(drawText: "22", inImage: newImage3, atPoint: CGPoint(x: 170.0, y: 1296.03))
//        let newImage5 = textToImage(drawText: "11", inImage: newImage4, atPoint: CGPoint(x: 235.0, y: 1296.03))
//        let newImage6 = textToImage(drawText: "2020", inImage: newImage5, atPoint: CGPoint(x: 310.0, y: 1296.03))
        
        var newImage = textToImage(drawText: "Valentina Vențel", inImage: UIImage(named: "concediu")!, atPoint: CGPoint(x: 220.0, y: 652.03))
        newImage = textToImage(drawText: "Developer iOS", inImage: newImage, atPoint: CGPoint(x: 450.0, y: 710.03))
        newImage = textToImage(drawText: "22.11.2020 - 30.11.2020", inImage: newImage, atPoint: CGPoint(x: 380.0, y: 850.03))
        newImage = textToImage(drawText: "10", inImage: newImage, atPoint: CGPoint(x: 150.0, y: 980.03))
        newImage = textToImage(drawText: "22", inImage: newImage, atPoint: CGPoint(x: 170.0, y: 1296.03))
        newImage = textToImage(drawText: "11", inImage: newImage, atPoint: CGPoint(x: 235.0, y: 1296.03))
        newImage = textToImage(drawText: "2020", inImage: newImage, atPoint: CGPoint(x: 310.0, y: 1296.03))
        
        image.image = newImage
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

