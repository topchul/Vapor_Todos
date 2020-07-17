//
//  CreateDocument.swift
//  App
//
//  Created by irontop on 2020/07/04.
//

import Fluent

struct CreateDocument: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Document.schema)
            .id()
            .field("corp_code",          .string, .required)
            .field("rcept_no",           .string, .required)
            .field("dcm_no",             .string, .required)
            .field("report_nm",          .string, .required)
            .field("year",               .string, .required)
            .field("report_type",        .string, .required)
            .field("modified",           .string, .required)
            
            .field("asset",              .int64,  .required)
            .field("cashflow_financing", .int64)
            .field("cashflow_investing", .int64)
            .field("cashflow_operating", .int64)
            .field("dividend",           .double)
            .field("equity",             .int64,  .required)
            .field("interestExpense",    .int64)
            .field("operatingIncome",    .int64,  .required)
            .field("profit",             .int64,  .required)
            .field("sails",              .int64,  .required)
            .field("shares",             .int64,  .required)
            .unique(on: .string("corp_code"),
                    .string("year"),
                    .string("report_type"),
                    .string("dcm_no"),
                    .string("report_nm"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Document.schema).delete()
    }
}
