//
//  Helpers.swift
//  Cereri_CobaltSign
//
//  Created by Valentina Vențel on 24/10/2020.
//

import Foundation
import UIKit

// MARK: Image
func saveImage(image: UIImage) -> Bool {
    guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
        return false
    }
    guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
        return false
    }
    do {
        try data.write(to: directory.appendingPathComponent("signature.png")!)
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

