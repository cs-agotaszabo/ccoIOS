//
//  OdihnaViewController.swift
//  Cereri_CobaltSign
//
//  Created by Valentina Vențel on 23/10/2020.
//

import Foundation
import UIKit
import MessageUI

class OdihnaViewController: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    var pdfData: NSData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doSend(_ sender: Any) {
        if hrDate(date: startDatePicker.date) == hrDate(date: endDatePicker.date) && startDatePicker.date.isDateInWeekend {
            let alert = UIAlertController(title: "Oops",
                                          message: "Date invalide",
                                          preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            self.present(alert, animated: true)
            return
        }
//        saveRequest()
        
        sendEmail()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        saveRequest()
        
        if segue.identifier == "previewSegue" {
            let previewVC = segue.destination as! PreviewViewController
            previewVC.startDate = startDatePicker.date
            previewVC.endDate = endDatePicker.date
        }
    }
    
    //MARK: Mail
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["valentina.ventel@cobaltsign.com"])
            mail.setSubject("Cerere")
            mail.setMessageBody("Salut, Arthur, \n\nTe rog să-mi aprobi cererea anexată. \n\nMulțumesc! ", isHTML: false)
            
//            let imageData: NSData = getSavedImage(named: "request.png")!.pngData()! as NSData
//            mail.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "request.png")
//
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let docURL = documentDirectory.appendingPathComponent("request.pdf")
//            let pdfData = NSData(contentsOfFile: docURL.absoluteString)!
            pdfData = NSData.init(contentsOf: docURL)
            mail.addAttachmentData(pdfData! as Data, mimeType: "application/pdf", fileName: "cerere.pdf")
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    // MARK: Private
    fileprivate func saveRequest() {
        let defaults = UserDefaults.standard
        
        let startDate = startDatePicker.date
        let endDate = endDatePicker.date
       
        let firstname = defaults.string(forKey: "firstname") ?? ""
        let lastname = defaults.string(forKey: "lastname") ?? ""
        let name = "\(lastname) \(firstname)"
        let job = defaults.string(forKey: "job") ?? ""
        
        let period = "\(hrDate(date: startDate)) - \(hrDate(date: endDate))"
        let (workdays, _) = countDays(from: startDate, to: endDate)
        let (dd, mm, yy) = dateComponents(date: Date())
        
        var newImage = textToImage(drawText: name, inImage: UIImage(named: "concediu")!, atPoint: CGPoint(x: 270.0, y: 652.03))
        newImage = textToImage(drawText: job, inImage: newImage, atPoint: CGPoint(x: 500.0, y: 710.03))
        newImage = textToImage(drawText: period, inImage: newImage, atPoint: CGPoint(x: 380.0, y: 850.03))
        newImage = textToImage(drawText: "\(workdays)", inImage: newImage, atPoint: CGPoint(x: 200.0, y: 980.03))
        newImage = textToImage(drawText: "\(dd)", inImage: newImage, atPoint: CGPoint(x: 170.0, y: 1296.03))
        newImage = textToImage(drawText: "\(mm)", inImage: newImage, atPoint: CGPoint(x: 235.0, y: 1296.03))
        newImage = textToImage(drawText: "\(yy)", inImage: newImage, atPoint: CGPoint(x: 310.0, y: 1296.03))
        
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
        
        _ = saveImage(image: finalImage!,
                      name: "request.png")
        
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let docURL = documentDirectory.appendingPathComponent("request.pdf")

        createPDF(image: finalImage!)?.write(to: docURL, atomically: true)
        
        
    }

}
