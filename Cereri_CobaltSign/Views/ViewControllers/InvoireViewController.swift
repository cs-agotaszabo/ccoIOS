//
//  InvoireViewController.swift
//  Cereri_CobaltSign
//
//  Created by Valentina Vențel on 23/10/2020.
//

import Foundation
import UIKit

class InvoireViewController: UIViewController {
    @IBOutlet weak var datePikerView: UIDatePicker!
    @IBOutlet weak var firstHour: UIDatePicker!
    @IBOutlet weak var secondHour: UIDatePicker!
    @IBOutlet weak var reasonText: UITextView!
    @IBOutlet weak var recoveryProgramText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        saveRequest()
    }
    
    fileprivate func saveRequest() {
        let defaults = UserDefaults.standard
        
        let firstname = defaults.string(forKey: "firstname") ?? ""
        let lastname = defaults.string(forKey: "lastname") ?? ""
        let name = "\(lastname) \(firstname)"
        let job = defaults.string(forKey: "job") ?? ""
        let (dd, mm, yy) = dateComponents(date: datePikerView.date)
        let (ddT, mmT, yyT) = dateComponents(date: Date())
        let period = "\(firstHour.date) - \(secondHour.date)"
        
        var newImage = textToImage(drawText: name, inImage: UIImage(named: "invoire")!, atPoint: CGPoint(x: 270.0, y: 630.03))
        newImage = textToImage(drawText: job, inImage: newImage, atPoint: CGPoint(x: 500.0, y: 695.03))
        newImage = textToImage(drawText: "\(dd)", inImage: newImage, atPoint: CGPoint(x: 565.0, y: 760.03))
        newImage = textToImage(drawText: "\(mm)", inImage: newImage, atPoint: CGPoint(x: 630.0, y: 760.03))
        newImage = textToImage(drawText: "\(yy)", inImage: newImage, atPoint: CGPoint(x: 703.0, y: 760.03))
        newImage = textToImage(drawText: "\(period)", inImage: newImage, atPoint: CGPoint(x: 70.0, y: 820.03))
        
        newImage = textToImage(drawText: "\(reasonText.text)", inImage: newImage, atPoint: CGPoint(x: 70.0, y: 880.03))
        newImage = textToImage(drawText: "\(recoveryProgramText.text)", inImage: newImage, atPoint: CGPoint(x: 70.0, y: 1070.03))
        newImage = textToImage(drawText: "\(ddT)", inImage: newImage, atPoint: CGPoint(x: 170.0, y: 1380.03))
        newImage = textToImage(drawText: "\(mmT)", inImage: newImage, atPoint: CGPoint(x: 230.0, y: 1380.03))
        newImage = textToImage(drawText: "\(yyT)", inImage: newImage, atPoint: CGPoint(x: 305.0, y: 1380.03))
        
        // save new image
        let bottomImage = newImage
        let topImage = getSavedImage(named: "signature.png")!

        let newSize = newImage.size // set this to what you need
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)

        bottomImage.draw(in: CGRect(origin: .zero,
                                    size: newSize))
        topImage.draw(in: CGRect(origin: CGPoint(x: 720, y: 1370),
                                 size: CGSize(width: 100, height: 40)))

        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        _ = saveImage(image: finalImage!,
                      name: "pauseRequest.png")
        
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let docURL = documentDirectory.appendingPathComponent("pauseRrequest.pdf")

        createPDF(image: finalImage!)?.write(to: docURL, atomically: true)
        
        
    }
}
