//
//  OdihnaViewController.swift
//  Cereri_CobaltSign
//
//  Created by Valentina Vențel on 23/10/2020.
//

import Foundation
import UIKit

class OdihnaViewController: UIViewController {
    let EMPLOYEE_NAME_KEY = "{EMPLOYEE_NAME}"
    let EMPLOYEE_OCCUPIED_POSITION = "{EMPLOYEE_POSITION}"
    let START_DATE_KEY = "{START_DATE}"
    let END_DATE_KEY = "{END_DATE}"
    let NR_OF_DAYS_KEY = "{NR_OF_DAYS}"
    let LEAVE_DATE_KEY = "{LEAVE_DATE}"
    let START_TIME_KEY = "{START_TIME}"
    let END_TIME_KEY = "{END_TIME}"
    let REQUEST_REASON_KEY = "{REQUEST_REASON}"
    let RECUPERATION_PERIOD_KEY = "{RECUPERATION_PERIOD}"
    let FILL_DATE_KEY = "{SIGNED_DATE}"
    let SIGNATURE_KEY = "{SIGNATURE_IMAGE}"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(getHTML())
        print("-----------------")
//        let fullHTML = getHTML()
//        let fullHTMLArr = fullHTML.components(separatedBy: "{EMPLOYEE}")
//
//        for val in fullHTMLArr {
//            print(val)
//            print("----------------------------------")
//        }
        addHTML()
    }
    
    private func getHTML() -> String {
        var html = ""
        if let htmlPathURL = Bundle.main.url(forResource: "concediu", withExtension: "html"){
            do {
                html = try String(contentsOf: htmlPathURL, encoding: .utf8)
            } catch  {
                print("Unable to get the file.")
            }
        }

        return html
    }
    
    private func addHTML() {
        var html = ""
        if var htmlPathURL = Bundle.main.url(forResource: "newConcediu", withExtension: "html"){
            do {
                html = getHTML()
                htmlPathURL.appendPathComponent(html.replacingOccurrences(of: "{EMPLOYEE}", with: "OOOOOlalallala"))
                let html1 = try String(contentsOf: htmlPathURL, encoding: .utf8)
                print("--------------------")
                print(html1)
                print("--------------------")
            } catch  {
                print("Unable to get the file.")
            }
        }
    }

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
