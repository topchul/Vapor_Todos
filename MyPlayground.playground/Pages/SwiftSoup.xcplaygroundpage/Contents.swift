//: [Previous](@previous)

import Foundation
import SwiftSoup

let html = String(contentsOf: URL(string: "http://dart.fss.or.kr/report/viewer.do?rcpNo=20150813000996&dcmNo=4765431&length=20000&offset=20000&eleId=7")!)
let doc: Document = try SwiftSoup.parse(html)
let tr = doc.select("tr")

print(tr.array())
print((try? tr[0].text()))

//: [Next](@next)
