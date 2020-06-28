//: [Previous](@previous)

import Foundation

var str = "Hello, playground"
let regExRange = str.range(of: "l{2}.*(pl)ay", options: .regularExpression, range: nil, locale: nil)
str[regExRange!]

//: [Next](@next)
