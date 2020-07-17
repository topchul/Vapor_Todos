//
//  String+RegEx.swift
//  App
//
//  Created by irontop on 2020/07/11.
//

import Foundation

extension String {
    var gr_regExAppendRuleAcceptAnyWhiteSpaces: String {
        return reduce(into: "", { r, c in
            if r.isEmpty {
                r.append(c)
            } else if r.last == ".", c == "*" {
                r.append(c)
            } else if ["\\", "|", "?"].contains(r.last) {
                r.append(c)
            } else if ["|", ")", ">"].contains(c) {
                r.append(c)
            } else {
                r.append("\\s*")
                r.append(c)
            }
        })
    }
}
