//: [Previous](@previous)

import Foundation

// rcept_no: 등록번호
// dcm_no: 문서번호
// report_nm: [기재정정]분기보고서 (2017.03)
// --> 기재정정 | 분기 | 2017 | 03
// --> 기재정정 | 1Q | 2017 | 분기보고서
// ==> 2016 | 4A |
// ==> 2017 | 1Q | M
// ==> 2017 | 2S |
// ==> 2017 | 3Q |
// ==> 2017 | 4A |
// --> year, type, modified
// account: 계정과목
// amount

var titles = [ "사업보고서 (2016.12)",
               "[기재정정]분기보고서 (2017.03)",
               "반기보고서 (2017.06)",
               "분기보고서 (2017.09)",
               "사업보고서 (2017.12)",
               "분기보고서 (2018.03)",
               "반기보고서 (2018.06)",
               "분기보고서 (2018.09)",
               "사업보고서 (2018.12)",
               "분기보고서 (2019.03)",
               "반기보고서 (2019.06)",
               "분기보고서 (2019.09)",
               "사업보고서 (2019.12)",
               "분기보고서 (2020.03)",
]

for title in titles {
    // 0(전체), 1(분기|반기|사업), 2(년), 3(월)
    let modifiedRegEx = NSRegularExpression(pattern: "기\\s*재\\s*정\\s*정", options: [])
    let reportTypeRegEx = NSRegularExpression(pattern: "(분기|반기|사업).*([0-9]{4}).([0-9]{2})", options: [])
    
    let matches = reportTypeRegEx.matches(in: title, options: .reportCompletion, range: NSRange(location: 0, length: (title as NSString).length))
    print("matches.count:", matches.count)
    let match = matches[0]
    print(title.count)
    print(match)

    print("range?:", (title as NSString).substring(with: match.range), match.range)
    for i in 0..<match.numberOfRanges {
        let range = match.range(at: i)
        print("index\(i)", ":", (title as NSString).substring(with: range), range)
    }
    
    print("기재정정:", modifiedRegEx.matches(in: title, options: .reportCompletion, range: NSRange(location: 0, length: (title as NSString).length)).count > 0)
}


//: [Next](@next)
