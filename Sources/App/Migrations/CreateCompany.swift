//
//  CreateCompany.swift
//  App
//
//  Created by irontop on 2020/06/18.
//

import Fluent

struct CreateCompany: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Company.schema)
            .id()
            .field("corp_code",     .string, .required)
            .field("corp_name",     .string, .required)
            .field("corp_name_eng", .string, .required)
            .field("stock_name",    .string, .required)
            .field("stock_code",    .string, .required)
            .field("ceo_nm",        .string, .required)
            .field("corp_cls",      .string, .required)
            .field("jurir_no",      .string, .required)
            .field("bizr_no",       .string, .required)
            .field("adres",         .string, .required)
            .field("hm_url",        .string, .required)
            .field("ir_url",        .string, .required)
            .field("phn_no",        .string, .required)
            .field("fax_no",        .string, .required)
            .field("induty_code",   .string, .required)
            .field("est_dt",        .string, .required)
            .field("acc_mt",        .string, .required)
            .unique(on: .string("corp_code"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Company.schema).delete()
    }
}
