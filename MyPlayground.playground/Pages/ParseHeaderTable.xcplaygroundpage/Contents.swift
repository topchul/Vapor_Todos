//: [Previous](@previous)

///    연결 재무상태표
///    제 51 기 1분기말 2019.03.31 현재
///    제 50 기말          2018.12.31 현재
///    (단위 : 백만원)
///    연결 손익계산서
///    제 51 기 1분기 2019.01.01 부터 2019.03.31 까지
///    제 50 기 1분기 2018.01.01 부터 2018.03.31 까지
///    (단위 : 백만원)
///    연결 포괄손익계산서
///    제 51 기 1분기 2019.01.01 부터 2019.03.31 까지
///    제 50 기 1분기 2018.01.01 부터 2018.03.31 까지
///    (단위 : 백만원)
///    연결 자본변동표
///    제 51 기 1분기 2019.01.01 부터 2019.03.31 까지
///    제 50 기 1분기 2018.01.01 부터 2018.03.31 까지
///    (단위 : 백만원)
///    연결 현금흐름표
///    제 51 기 1분기 2019.01.01 부터 2019.03.31 까지
///    제 50 기 1분기 2018.01.01 부터 2018.03.31 까지
///    (단위 : 백만원)
///
///    연결 재무상태표
///    제 51 기 반기말 2019.06.30 현재
///    제 50 기말        2018.12.31 현재
///    (단위 : 백만원)
///    연결 손익계산서
///    제 51 기 반기 2019.01.01 부터 2019.06.30 까지
///    제 50 기 반기 2018.01.01 부터 2018.06.30 까지
///    (단위 : 백만원)
///    연결 포괄손익계산서
///    제 51 기 반기 2019.01.01 부터 2019.06.30 까지
///    제 50 기 반기 2018.01.01 부터 2018.06.30 까지
///    (단위 : 백만원)
///    연결 자본변동표
///    제 51 기 반기 2019.01.01 부터 2019.06.30 까지
///    제 50 기 반기 2018.01.01 부터 2018.06.30 까지
///    (단위 : 백만원)
///    연결 현금흐름표
///    제 51 기 반기 2019.01.01 부터 2019.06.30 까지
///    제 50 기 반기 2018.01.01 부터 2018.06.30 까지
///    (단위 : 백만원)
///
///    연결 재무상태표
///    제 51 기 3분기말 2019.09.30 현재
///    제 50 기말          2018.12.31 현재
///    (단위 : 백만원)
///    연결 손익계산서
///    제 51 기 3분기 2019.01.01 부터 2019.09.30 까지
///    제 50 기 3분기 2018.01.01 부터 2018.09.30 까지
///    (단위 : 백만원)
///    연결 포괄손익계산서
///    제 51 기 3분기 2019.01.01 부터 2019.09.30 까지
///    제 50 기 3분기 2018.01.01 부터 2018.09.30 까지
///    (단위 : 백만원)
///    연결 자본변동표
///    제 51 기 3분기 2019.01.01 부터 2019.09.30 까지
///    제 50 기 3분기 2018.01.01 부터 2018.09.30 까지
///    (단위 : 백만원)
///    연결 현금흐름표
///    제 51 기 3분기 2019.01.01 부터 2019.09.30 까지
///    제 50 기 3분기 2018.01.01 부터 2018.09.30 까지
///    (단위 : 백만원)
///
///    연결 재무상태표
///    제 51 기          2019.12.31 현재
///    제 50 기          2018.12.31 현재
///    제 49 기          2017.12.31 현재
///    (단위 : 백만원)
///    연결 손익계산서
///    제 51 기 2019.01.01 부터 2019.12.31 까지
///    제 50 기 2018.01.01 부터 2018.12.31 까지
///    제 49 기 2017.01.01 부터 2017.12.31 까지
///    (단위 : 백만원)
///    연결 포괄손익계산서
///    제 51 기 2019.01.01 부터 2019.12.31 까지
///    제 50 기 2018.01.01 부터 2018.12.31 까지
///    제 49 기 2017.01.01 부터 2017.12.31 까지
///    (단위 : 백만원)
///    연결 자본변동표
///    제 51 기 2019.01.01 부터 2019.12.31 까지
///    제 50 기 2018.01.01 부터 2018.12.31 까지
///    제 49 기 2017.01.01 부터 2017.12.31 까지
///    (단위 : 백만원)
///    연결 현금흐름표
///    제 51 기 2019.01.01 부터 2019.12.31 까지
///    제 50 기 2018.01.01 부터 2018.12.31 까지
///    제 49 기 2017.01.01 부터 2017.12.31 까지
///    (단위 : 백만원)

import Foundation

extension String {
    static var gr_regExDateWithDot: String {
        return "\\d{4}\\.\\d{2}\\.\\d{2}"
    }
    
    var gr_regExWithInnerS: String {
        return reduce(into: "") { r, c in
            r.append("\\s*")
            r.append(c)
        }
    }
    
    func gr_regExGroupWithInnerS(title: String) -> String {
        return [ "(?<\(title)>", self.gr_regExWithInnerS, ")" ].joined()
    }
}

extension Array where Element == String {
    func gr_regExJoinedGroupWithEachInnerS(title: String? = nil) -> String {
        if let title = title {
            return [ "(?<\(title)>", self.map { $0.gr_regExWithInnerS }.joined(separator: "|"), ")" ].joined()
        } else {
            return [ "(", self.map { $0.gr_regExWithInnerS }.joined(separator: "|"), ")" ].joined()
        }
    }
    func gr_regExJoinedGroup(title: String? = nil) -> String {
        if let title = title {
            return [ "(?<\(title)>", self.joined(separator: "|"), ")"].joined()
        } else {
            return [ "(", self.joined(separator: "|"), ")"].joined()
        }
    }
    func gr_regExConcatenatedSingleGroupWithS(title: String? = nil) -> String {
        if let title = title {
            return [ "(?<\(title)>", self.joined(separator: "\\s*"), ")" ].joined()
        } else {
            return [ "(", self.joined(separator: "\\s*"), ")" ].joined()
        }
    }
}


func testRegEx(pattern: String, testCases: [String], reportMode: Bool = false) throws {
    func matchedIndices(_ result: NSTextCheckingResult) -> [Int] {
        var ranges: [NSRange] = .init()
        for index in stride(from: 0, to: result.numberOfRanges, by: 1) {
            ranges.append(result.range(at: index))
        }
        let indices = ranges
            .enumerated()
            .filter { NSNotFound != $0.element.location }
            .map { $0.offset }
        return indices
    }
    
    let titles = [ "unit", // type
                   "unitMillion",
                   "unitThousand",
                   "unitOne",
                   "reportTitle", // type
                   "reportIncome",
                   "reportFinancial",
                   "reportCompreIncome",
                   "reportCashflow",
                   "endOfPeriod", // type
                   "endOfPeriodName",
                   "endOfPeriodDate",
                   "period", // type
                   "periodName",
                   "periodFromDate",
                   "periodToDate"                     ]
    
    let regEx = try NSRegularExpression(pattern: pattern, options: [])
    print(pattern)
    for testCase in testCases {
        let results = regEx.matches(in: testCase, options: [], range: NSRange(location: 0, length: testCase.count))
        switch results.count {
        case 0:
            if reportMode {
                print("\"\(testCase)\" ->", "not matched")
            } else {
                print("\t", "! not matched  :", testCase)
            }
        case 1:
            if reportMode {
                let matched = titles
                    .map { results[0].range(withName: $0) }
                    .filter { NSNotFound != $0.location }
                    .map { (testCase as NSString).substring(with: $0) }
                    .map { $0.replacingOccurrences(of: "\\s", with: "", options: .regularExpression)}
                    .joined(separator: "|")
                print("\"\(testCase)\" ->", "(\(matched))")
            } else {
                let matched = titles
                    .map { results[0].range(withName: $0) }
                    .filter { NSNotFound != $0.location }
                    .map { (testCase as NSString).substring(with: $0) }
                    .joined(separator: "|")
                print("\t", "* matched      : \"\(testCase)\" ->",
                    "(\(matched))",
                    Array<String>(repeating: " ", count: 50 - testCase.count).joined(),
                    results[0].numberOfRanges, matchedIndices(results[0]),
                    "")
            }
        default:
            if reportMode {
                print("\"\(testCase)\" ->", "invalid matched")
            } else {
                print("\t", "invalid matched:", testCase)
                for result in results {
                    print("\t\t", result.numberOfRanges, matchedIndices(result))
                }
            }
        }
    }
}

let allTestStrings = [
    "(단위 : 백만원)",
    "연결 손익계산서",
    "연결 자본변동표",
    "연결 재무상태표",
    "연결 포괄손익계산서",
    "연결 현금흐름표",
    "제 49 기          2017.12.31 현재",
    "제 49 기 2017.01.01 부터 2017.12.31 까지",
    "제 50 기          2018.12.31 현재",
    "제 50 기 1분기 2018.01.01 부터 2018.03.31 까지",
    "제 50 기 2018.01.01 부터 2018.12.31 까지",
    "제 50 기 3분기 2018.01.01 부터 2018.09.30 까지",
    "제 50 기 반기 2018.01.01 부터 2018.06.30 까지",
    "제 50 기말          2018.12.31 현재",
    "제 50 기말        2018.12.31 현재",
    "제 51 기          2019.12.31 현재",
    "제 51 기 1분기 2019.01.01 부터 2019.03.31 까지",
    "제 51 기 1분기말 2019.03.31 현재",
    "제 51 기 2019.01.01 부터 2019.12.31 까지",
    "제 51 기 3분기 2019.01.01 부터 2019.09.30 까지",
    "제 51 기 3분기말 2019.09.30 현재",
    "제 51 기 반기 2019.01.01 부터 2019.06.30 까지",
    "제 51 기 반기말 2019.06.30 현재",
]

let caseStrings = [
    "(단위 : 백만원)",
    "(단위 : 천원)",
    "(단위 : 원)",
    "연결 손익계산서",
    "연결 재무상태표",
    "연결 포괄손익계산서",
    "연결 현금흐름표",
    "제 49 기          2017.12.31 현재",
    "제 50 기말          2018.12.31 현재",
    "제 51 기 1분기말 2019.03.31 현재",
    "제 51 기 반기말 2019.06.30 현재",
    "제 51 기 3분기말 2019.09.30 현재",
    "제 49 기 2017.01.01 부터 2017.12.31 까지",
    "제 50 기 1분기 2018.01.01 부터 2018.03.31 까지",
    "제 50 기 반기 2018.01.01 부터 2018.06.30 까지",
    "제 50 기 3분기 2018.01.01 부터 2018.09.30 까지",
]

print("unitRegEx")
let unitRegEx =
    [ "단위", ":",
      [ "백만원".gr_regExGroupWithInnerS(title: "unitMillion"),
        "천원".gr_regExGroupWithInnerS(title: "unitThousand"),
        "원".gr_regExGroupWithInnerS(title: "unitOne")
      ].gr_regExJoinedGroup()
    ].gr_regExConcatenatedSingleGroupWithS(title: "unit")
testRegEx(pattern: unitRegEx, testCases: caseStrings)

print("titleRegEx")
let titleRegEx = [ [".*", "손익계산서".gr_regExWithInnerS].gr_regExConcatenatedSingleGroupWithS(title: "reportIncome"),
                   [".*", "재무상태표".gr_regExWithInnerS].gr_regExConcatenatedSingleGroupWithS(title: "reportFinancial"),
                   [".*", "포괄손익계산서".gr_regExWithInnerS].gr_regExConcatenatedSingleGroupWithS(title: "reportCompreIncome"),
                   [".*", "현금흐름표".gr_regExWithInnerS].gr_regExConcatenatedSingleGroupWithS(title: "reportCashflow")
    ].gr_regExJoinedGroup(title: "reportTitle")
testRegEx(pattern: titleRegEx, testCases: caseStrings)

let endingRegEx = [
    "(?<endOfPeriodName>.*)",
    "(?<endOfPeriodDate>\(String.gr_regExDateWithDot))",
    "현재"
].gr_regExConcatenatedSingleGroupWithS(title: "endOfPeriod")
testRegEx(pattern: endingRegEx, testCases: caseStrings)

let periodRegEx = [
    "(?<periodName>.*)",
    "(?<periodFromDate>\(String.gr_regExDateWithDot))",
    "부터",
    "(?<periodToDate>\(String.gr_regExDateWithDot))",
    "까지"
].gr_regExConcatenatedSingleGroupWithS(title: "period")
testRegEx(pattern: periodRegEx, testCases: caseStrings)


let joinedRegEx = [unitRegEx, titleRegEx, endingRegEx, periodRegEx].gr_regExJoinedGroup()
testRegEx(pattern: joinedRegEx, testCases: caseStrings)

testRegEx(pattern: joinedRegEx, testCases: allTestStrings, reportMode: true)

//: [Next](@next)
