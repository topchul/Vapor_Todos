//: [Previous](@previous)

import Foundation

extension String {
    public subscript(range: Range<Int>) -> Substring {
        return self[index(startIndex, offsetBy: range.lowerBound)..<index(startIndex, offsetBy: range.upperBound)]
    }
}

func existsReportIn3Months(rceptDt: String) -> Bool {
    let calendar = Calendar(identifier: .gregorian)
    let before3Months = calendar.date(byAdding: .month, value: -3, to: Date())!
    
    guard let year = Int(rceptDt[0..<4]),
        let month = Int(rceptDt[4..<6]),
        let day = Int(rceptDt[6..<8]),
        let receptionDate = DateComponents(calendar: calendar, year: year, month: month, day: day).date
        else {
            return false
    }
        
    print(receptionDate)
    print(before3Months)
    
    return before3Months < receptionDate
}
existsReportIn3Months(rceptDt: "20200401")



var str = "20200515"
let formatter = DateFormatter()
formatter.dateFormat = "yyyyMMdd"
formatter.date(from: str)

//let year = Int(str[0..<4])
//let month = Int(str[4..<6])
//let day = Int(str[6..<8])

//let dateComponents = DateComponents(calendar: .init(identifier: .gregorian), timeZone: .current, year: year, month: month, day: day)

//: [Next](@next)
