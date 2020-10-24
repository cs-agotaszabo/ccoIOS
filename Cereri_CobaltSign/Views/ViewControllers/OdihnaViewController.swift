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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
        sendEmail()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "previewSegue" {
            let previewVC = segue.destination as! PreviewViewController
            previewVC.startDate = startDatePicker.date
            previewVC.endDate = endDatePicker.date
        }
    }
    
    //MARK: Private
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["valentina.ventel@cobaltsign.com"])
            mail.setSubject("Cerere")
            mail.setMessageBody("Salut, Arthur, \n\nTe rog să-mi aprobi cererea anexată. \n\nMulțumesc! ", isHTML: false)

            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

}
