//: [Previous](@previous)

import Foundation
import PlaygroundSupport
let path = playgroundSharedDataDirectory.appendingPathComponent("CORPCODE.xml")
let contents = try String(contentsOf: path)

struct Item {
    var corp_code: String = ""
    var corp_name: String = ""
    var stock_code: String = ""
    var modify_date: String = ""
    var isValid: Bool {
        return
            !corp_code.isEmpty &&
            !corp_name.isEmpty &&
            !modify_date.isEmpty
    }
}
var extractedItems: [Item] = []
var curItem: Item!
var range = contents.startIndex..<contents.endIndex
while let subRange = contents.range(of: "<list>|</list>|<(corp_code|corp_name|stock_code|modify_date)>[^<]*", options: .regularExpression, range: range) {
    let element = contents[subRange]
    switch element {
    case "<list>":
        curItem = .init()
        
    case "</list>":
        extractedItems.append(curItem)
        if !curItem.isValid {
            print("invalid:", curItem)
        }
        if !curItem.stock_code.isEmpty {
            print("stock:", curItem)
        }
        curItem = nil

    default:
        let nodes = element.split(separator: ">")
        switch nodes[0] {
        case "<corp_code":   curItem.corp_code   = nodes[1].trimmingCharacters(in: .whitespacesAndNewlines)
        case "<corp_name":   curItem.corp_name   = nodes[1].trimmingCharacters(in: .whitespacesAndNewlines)
        case "<stock_code":  curItem.stock_code  = nodes[1].trimmingCharacters(in: .whitespacesAndNewlines)
        case "<modify_date": curItem.modify_date = nodes[1].trimmingCharacters(in: .whitespacesAndNewlines)
        default:
            fatalError()
        }
    }
    range = subRange.upperBound..<range.upperBound
    
    if 10_000 <= extractedItems.count {
        break
    }
}


//
// MARK: parsing exercise
//       ----------------
let xml = """
<result>
 <list>
     <corp_code>00434003</corp_code>
     <corp_name>다코</corp_name>
     <stock_code> </stock_code>
     <modify_date>20170630</modify_date>
 </list>
 <list>
     <corp_code>00434456</corp_code>
     <corp_name>일산약품</corp_name>
     <stock_code> </stock_code>
     <modify_date>20170630</modify_date>
 </list>
 <list>
     <corp_code>00430964</corp_code>
     <corp_name>굿앤엘에스</corp_name>
     <stock_code> </stock_code>
     <modify_date>20170630</modify_date>
 </list>
</result>
"""

range = xml.startIndex..<xml.endIndex
while let subRange = xml.range(of: "<list>|</list>|<(corp_code|corp_name|stock_code|modify_date)>[^<]*", options: .regularExpression, range: range) {
    print(xml[subRange])
    range = max(range.lowerBound, subRange.upperBound)..<range.upperBound
}

//: [Next](@next)
