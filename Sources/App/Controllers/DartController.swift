//
//  DartController.swift
//  App
//
//  Created by irontop on 2020/06/28.
//

import Foundation

struct DartController {
    static func existsReportIn3Months(rceptDt: String) -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let before3Months = calendar.date(byAdding: .month, value: -3, to: Date())!
        
        guard let year = Int(rceptDt[rceptDt.index(rceptDt.startIndex, offsetBy: 0)..<rceptDt.index(rceptDt.startIndex, offsetBy: 4)]),
            let month = Int(rceptDt[rceptDt.index(rceptDt.startIndex, offsetBy: 4)..<rceptDt.index(rceptDt.startIndex, offsetBy: 6)]),
            let day = Int(rceptDt[rceptDt.index(rceptDt.startIndex, offsetBy: 6)..<rceptDt.index(rceptDt.startIndex, offsetBy: 8)]),
            let receptionDate = DateComponents(calendar: calendar, year: year, month: month, day: day).date
            else {
                return false
        }
        return before3Months < receptionDate
    }
    
}
