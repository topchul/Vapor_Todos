//
//  CreateListItem.swift
//  App
//
//  Created by irontop on 2020/06/28.
//

import Fluent

struct CreateListItem: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(ListItem.schema)
            .id()
            .field("corp_cls",   .string, .required)
            .field("corp_name",  .string, .required)
            .field("corp_code",  .string, .required)
            .field("stock_code", .string, .required)
            .field("report_nm",  .string, .required)
            .field("rcept_no",   .string, .required)
            .field("flr_nm",     .string, .required)
            .field("rcept_dt",   .string, .required)
            .field("rm",         .string, .required)
            .field(.definition(name: .key("dcm_no"), dataType: .string, constraints: []))
            .unique(on: .string("corp_code"), .string("rcept_no"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(ListItem.schema).delete()
    }
}
