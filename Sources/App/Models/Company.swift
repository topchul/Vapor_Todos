//
//  Company.swift
//  App
//
//  Created by irontop on 2020/06/17.
//
//    status        에러 및 정보 코드                  (※메시지 설명 참조)
//    message       에러 및 정보 메시지                 (※메시지 설명 참조)
//    corp_name     정식명칭                        정식회사명칭
//    corp_name_eng 영문명칭                        영문정식회사명칭
//    stock_name    종목명(상장사) 또는 약식명칭(기타법인)      종목명(상장사) 또는 약식명칭(기타법인)
//    stock_code    상장회사인 경우 주식의 종목코드           상장회사의 종목코드(6자리)
//    ceo_nm        대표자명                        대표자명
//    corp_cls      법인구분                        법인구분 : Y(유가), K(코스닥), N(코넥스), E(기타)
//    jurir_no      법인등록번호                      법인등록번호
//    bizr_no       사업자등록번호                     사업자등록번호
//    adres         주소                          주소
//    hm_url        홈페이지                        홈페이지
//    ir_url        IR홈페이지                      IR홈페이지
//    phn_no        전화번호                        전화번호
//    fax_no        팩스번호                        팩스번호
//    induty_code   업종코드                        업종코드
//    est_dt        설립일(YYYYMMDD)               설립일(YYYYMMDD)
//    acc_mt        결산월(MM)                     결산월(MM)

import Fluent
import Foundation
import Vapor

final class Company: Model, Content {
    
    struct Input: Content {
        var status: String
        var message: String?
        
        var corp_code: String?
        var corp_name: String?
        var corp_name_eng: String?
        var stock_name: String?
        var stock_code: String?
        var ceo_nm: String?
        var corp_cls: String?
        var jurir_no: String?
        var bizr_no: String?
        var adres: String?
        var hm_url: String?
        var ir_url: String?
        var phn_no: String?
        var fax_no: String?
        var induty_code: String?
        var est_dt: String?
        var acc_mt: String?
    }
    
    static let schema = "company"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "corp_code")
    var corp_code: String
    @Field(key: "corp_name")
    var corp_name: String
    @Field(key: "corp_name_eng")
    var corp_name_eng: String
    @Field(key: "stock_name")
    var stock_name: String
    @Field(key: "stock_code")
    var stock_code: String
    @Field(key: "ceo_nm")
    var ceo_nm: String
    @Field(key: "corp_cls")
    var corp_cls: String
    @Field(key: "jurir_no")
    var jurir_no: String
    @Field(key: "bizr_no")
    var bizr_no: String
    @Field(key: "adres")
    var adres: String
    @Field(key: "hm_url")
    var hm_url: String
    @Field(key: "ir_url")
    var ir_url: String
    @Field(key: "phn_no")
    var phn_no: String
    @Field(key: "fax_no")
    var fax_no: String
    @Field(key: "induty_code")
    var induty_code: String
    @Field(key: "est_dt")
    var est_dt: String
    @Field(key: "acc_mt")
    var acc_mt: String
    
    init() { }
    
    init(_ input: Input) {
        self.corp_code     = input.corp_code ?? ""
        self.corp_name     = input.corp_name ?? ""
        self.corp_name_eng = input.corp_name_eng ?? ""
        self.stock_name    = input.stock_name ?? ""
        self.stock_code    = input.stock_code ?? ""
        self.ceo_nm        = input.ceo_nm ?? ""
        self.corp_cls      = input.corp_cls ?? ""
        self.jurir_no      = input.jurir_no ?? ""
        self.bizr_no       = input.bizr_no ?? ""
        self.adres         = input.adres ?? ""
        self.hm_url        = input.hm_url ?? ""
        self.ir_url        = input.ir_url ?? ""
        self.phn_no        = input.phn_no ?? ""
        self.fax_no        = input.fax_no ?? ""
        self.induty_code   = input.induty_code ?? ""
        self.est_dt        = input.est_dt ?? ""
        self.acc_mt        = input.acc_mt ?? ""
    }
}

extension Company {
    static func company(forCorpCode corp_code: String, on database: FluentKit.Database) -> EventLoopFuture<Company?> {
        return self.query(on: database)
            .filter(\.$corp_code == corp_code)
            .first()
        
    }
    
    func saveIfNotExists(on database: FluentKit.Database) -> EventLoopFuture<Void> {
        return Company
            .company(forCorpCode: corp_code, on: database)
            .flatMap { (company: Company?) -> EventLoopFuture<Void> in
                guard nil == company else { return database.eventLoop.makeSucceededFuture(()) }
                return self.save(on: database)
            }
    }
}
