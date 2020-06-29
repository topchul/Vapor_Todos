//
//  CreateCorpCode.swift
//  App
//
//  Created by irontop on 2020/06/30.
//

import Fluent

struct CreateCorpCode: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(CorpCode.schema)
            .id()
            .field("corp_code",     .string, .required)
            .field("corp_name",     .string, .required)
            .field(.definition(name: .key("stock_code"), dataType: .string, constraints: []))
            .field("modify_date",   .string, .required)
            .unique(on: .string("corp_code"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(CorpCode.schema).delete()
    }
}
