//
//  Helpers.swift
//  Cereri_CobaltSign
//
//  Created by Valentina Vențel on 24/10/2020.
//

import Foundation
import UIKit

// MARK: Image
func saveImage(image: UIImage, name: String) -> Bool {
    guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
        return false
    }
    guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
        return false
    }
    do {
        try data.write(to: directory.appendingPathComponent(name)!)
        return true
    } catch {
        print(error.localizedDescription)
        return false
    }
}

func getSavedImage(named: String) -> UIImage? {
    if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
        return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
    }
    return nil
}

//MARK: Date
extension Calendar {
    static let iso8601 = Calendar(identifier: .iso8601)
}

extension Date {
    var isDateInWeekend: Bool {
        return Calendar.iso8601.isDateInWeekend(self)
    }
    var tomorrow: Date {
        return Calendar.iso8601.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.iso8601.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
}

func countDays(from start: Date, to end: Date) -> (workingDays: Int, weekendDays: Int) {
    guard start < end else { return (0,0) }
    var workingDays = 0
    var weekendDays = 0
    var date = start.noon
    repeat {
        if date.isDateInWeekend {
            weekendDays +=  1
        } else {
            workingDays += 1
        }
        date = date.tomorrow
    } while date < end
    return (workingDays, weekendDays)
}

func hrDate(date: Date) -> String {
    let formatter = DateFormatter()
    //formatter.dateStyle = .medium
    formatter.dateFormat = "dd MMM yyyy"
    return formatter.string(from: date)
}

func dateComponents(date: Date) -> (d: Int, m: Int, y: Int) {
    let cal = Calendar.current
    let comp = cal.dateComponents([.day, .month, .year], from: date)
    return (comp.day!, comp.month!, comp.year!)

}

func timeComponents(date: Date) -> (h: Int, m: Int) {
    let cal = Calendar.current
    let comp = cal.dateComponents([.hour, .minute], from: date)
    return (comp.hour!, comp.minute!)
}

// MARK: Text
func textToImage(drawText text: String,
                 inImage image: UIImage,
                 atPoint point: CGPoint) -> UIImage {
    let textColor = UIColor(named: "CobaltSignColor")
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


// MARK: PDF

func createPDF(image: UIImage) -> NSData? {

    let pdfData = NSMutableData()
    let pdfConsumer = CGDataConsumer(data: pdfData as CFMutableData)!

    var mediaBox = CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height)

    let pdfContext = CGContext(consumer: pdfConsumer, mediaBox: &mediaBox, nil)!

    pdfContext.beginPage(mediaBox: &mediaBox)
    pdfContext.draw(image.cgImage!, in: mediaBox)
    pdfContext.endPage()

    return pdfData
}
