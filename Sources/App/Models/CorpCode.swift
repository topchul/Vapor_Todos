//
//  CorpCode.swift
//  App
//
//  Created by irontop on 2020/06/29.
//
//    corp_code   기업코드
//    corp_name   정식명칭
//    stock_code  상장회사인 경우 주식의 종목코드
//    modify_date 변경일

import Fluent
import Foundation
import Vapor

final class CorpCode: Model, Content {
    struct Input: Content {
        var corp_code:   String?
        var corp_name:   String?
        var stock_code:  String?
        var modify_date: String?
    }
    
    static let schema = "corpcode"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "corp_code")
    var corp_code: String
    @Field(key: "corp_name")
    var corp_name: String
    @Field(key: "stock_code")
    var stock_code: String?
    @Field(key: "modify_date")
    var modify_date: String
    
    init() { }
    
    init(_ input: Input) {
        self.corp_code   = input.corp_code!
        self.corp_name   = input.corp_name!
        self.stock_code  = input.stock_code
        self.modify_date = input.modify_date!
    }
}

extension CorpCode {
    static func corpCode(forCorpCode corp_code: String, on database: FluentKit.Database) -> EventLoopFuture<CorpCode?> {
        return self.query(on: database)
            .filter(\.$corp_code == corp_code)
            .first()
    }
    static func corpCode(forStockCode stock_code: String, on database: FluentKit.Database) -> EventLoopFuture<CorpCode?> {
        return self.query(on: database)
            .filter(\.$stock_code == stock_code)
            .first()
    }
    func saveIfNotExists(on database: FluentKit.Database) -> EventLoopFuture<Void> {
        return CorpCode
            .corpCode(forCorpCode: corp_code, on: database)
            .flatMap { (corpCode: CorpCode?) -> EventLoopFuture<Void> in
                guard nil == corpCode else { return database.eventLoop.makeSucceededFuture(()) }
                return self.save(on: database)
            }
    }
}
