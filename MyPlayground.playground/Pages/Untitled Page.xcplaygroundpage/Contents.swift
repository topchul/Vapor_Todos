//: [Previous](@previous)

import Foundation

var str = "Hello, playground"
let regExRange = str.range(of: "l{2}.*(pl)ay", options: .regularExpression, range: nil, locale: nil)
str[regExRange!]

func addIgnoreWhiteSpacePattern(pattern: String) -> String {
    var builder: [String] = []
    pattern.first.map { builder.append(String($0)) }
    for c in pattern[(pattern.index(pattern.startIndex, offsetBy: 1, limitedBy: pattern.endIndex) ?? pattern.endIndex)..<pattern.endIndex] {
        
        if c.isWhitespace {
            builder.append(String(c))
        } else {
            builder.append("\\s*")
            builder.append(String(c))
        }
    }
    return builder.joined()
}
addIgnoreWhiteSpacePattern(pattern: "")
addIgnoreWhiteSpacePattern(pattern: "abc")
addIgnoreWhiteSpacePattern(pattern: "한글")
addIgnoreWhiteSpacePattern(pattern: "한글한글한글한글동해물과백두산이마르고닳도록")

let a = "abc"
let b = a.reduce(into: "") { r, c in
    if r.isEmpty {
        r.append(c)
    } else {
        r.append("\\s*")
        r.append(c)
    }
}
b

let nf = NumberFormatter()
nf.numberStyle = .decimal
//nf.hasThousandSeparators = true
//nf.decimalSeparator = ","
nf.number(from: "123,456,789")
nf.string(from: 123_456_789)

//: [Next](@next)
