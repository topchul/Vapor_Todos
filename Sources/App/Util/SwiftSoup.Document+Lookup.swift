//
//  SwiftSoup.Document+Lookup.swift
//  App
//
//  Created by irontop on 2020/07/11.
//

import Foundation
import SwiftSoup

extension SwiftSoup.Document {
    func gr_tr(matches matchText: String, ignoreWhiteSpace: Bool = true) throws -> Elements? {
        let pattern = (ignoreWhiteSpace ? matchText.gr_regExAppendRuleAcceptAnyWhiteSpaces: matchText)
        let cssQuery = "tr:matches(\(pattern)"
        
        return try select(cssQuery).first()?.children()
    }
    func gr_tdValue(matches matchText: String, tdIndex: Int, ignoreWhiteSpace: Bool = true) throws -> String? {
        guard let tds = try gr_tr(matches: matchText, ignoreWhiteSpace: ignoreWhiteSpace) else { return nil }
        if tdIndex < 0 {
            return try tds[tds.count + tdIndex].text()
        } else {
            return try tds[tdIndex].text()
        }
    }
}

extension SwiftSoup.Elements.Element {
    func gr_elements(matches matchText: String, ignoreWhiteSpace: Bool = true) throws -> Elements {
        let pattern = (ignoreWhiteSpace ? matchText.gr_regExAppendRuleAcceptAnyWhiteSpaces: matchText)
        let cssQuery = ":matches(\(pattern)"
        
        return try select(cssQuery)
    }
}
