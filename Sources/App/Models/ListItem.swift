//
//  ListItem.swift
//  App
//
//  Created by irontop on 2020/06/20.
//
//    corp_cls   법인구분      법인구분 : Y(유가), K(코스닥), N(코넥스), E(기타)
//    corp_name  종목명__법인명  공시대상회사의 종목명(상장사) 또는 법인명(기타법인)
//    corp_code  고유번호      공시대상회사의 고유번호(8자리)
//    stock_code 종목코드      상장회사의 종목코드(6자리)
//    report_nm  보고서명      공시구분+보고서명+기타정보
//                              공시구분: [기재정정] [첨부정정] [첨부추가] [변경등록] [연장결정] [발행조건확정] [정정명령부과] [정정제출요구]
//    rcept_no   접수번호      접수번호(14자리)
//                              'http://dart.fss.or.kr/dsaf001/main.do?rcpNo=접수번호'
//                              'http://m.dart.fss.or.kr/html_mdart/MD1007.html?rcpNo=접수번호'
//    flr_nm     공시_제출인명   공시 제출인명
//    rcept_dt   접수일자      공시 접수일자(YYYYMMDD)
//    rm         비고        조합된 문자로 각각은 아래와 같은 의미가 있음
//                              유(유가증권 소관)
//                              코(코스닥시장본부 소관)
//                              채(채권상장법인 공시)
//                              넥(코넥스시장 소관)
//                              공(공정거래위원회 소관)
//                              연(연결부분을 포함)
//                              정(정정된 관련 보고서 참조)
//                              철(철회신고서(철회간주안내)를 참고)
//  Unique
//    corp_code
//    year
//    report_type
//    rcept_no
//
//    modified
//    report_nm

import Fluent
import Foundation
import Vapor

final class ListItem: Model, Content {
    static let schema = "list_item"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "corp_cls")
    var corp_cls: String
    @Field(key: "corp_name")
    var corp_name: String
    @Field(key: "corp_code")
    var corp_code: String
    @Field(key: "stock_code")
    var stock_code: String
    @Field(key: "report_nm")
    var report_nm: String
    @Field(key: "rcept_no")
    var rcept_no: String
    @Field(key: "flr_nm")
    var flr_nm: String
    @Field(key: "rcept_dt")
    var rcept_dt: String
    @Field(key: "rm")
    var rm: String
    @Field(key: "dcm_no")
    var dcm_no: String?
    
    @Field(key: "year")
    var year: String
    @Field(key: "report_type")
    var report_type: String
    @Field(key: "modified")
    var modified: String
    
    init() { }
    
    init(corp_cls: String,
         corp_name: String,
         corp_code: String,
         stock_code: String,
         report_nm: String,
         rcept_no: String,
         flr_nm: String,
         rcept_dt: String,
         rm: String,
         dcm_no: String?,
         year: String,
         report_type: String,
         modified: String) {
        
        self.corp_cls   = corp_cls
        self.corp_name  = corp_name
        self.corp_code  = corp_code
        self.stock_code = stock_code
        self.report_nm  = report_nm
        self.rcept_no   = rcept_no
        self.flr_nm     = flr_nm
        self.rcept_dt   = rcept_dt
        self.rm         = rm
        self.dcm_no     = dcm_no
        
        self.year        = year
        self.report_type = report_type
        self.modified    = modified
    }
    
    var description: String {
        var builder: [String] = .init()
        builder.append("corp_name(\(corp_name))")
        builder.append("report_nm(\(report_nm))")
        builder.append("rcept_no(\(rcept_no))")
        builder.append("corp_code(\(corp_code))")
        builder.append("corp_cls(\(corp_cls))")
        builder.append("stock_code(\(stock_code))")
        builder.append("flr_nm(\(flr_nm))")
        builder.append("rcept_dt(\(rcept_dt))")
        builder.append("rm(\(rm))")
        builder.append("dcm_no(\(dcm_no ?? "<not yet>"))")
        
        builder.append("year\(year)")
        builder.append("report_type\(report_type)")
        builder.append("modified\(modified)")
        
        return "ListItem(" + builder.joined(separator: " ") + ")"
    }
}

extension ListItem {
    static func maxRceptDt(forCorpCode corp_code: String, on database: FluentKit.Database) -> EventLoopFuture<String?> {
        let maxRceptDtQuery = self.query(on: database)
            .filter(\.$corp_code == corp_code)
            .max(\.$rcept_dt)
        return maxRceptDtQuery
    }
    
    static func listItems(forCorpCode corp_code: String, fromRceptDt from_rcept_dt: String, toRceptDt to_rcept_dt: String, on database: FluentKit.Database) -> EventLoopFuture<[ListItem]> {
        
        return ListItem.query(on: database)
            .filter(\.$corp_code == corp_code)
            .filter(\.$rcept_dt >= from_rcept_dt)
            .filter(\.$rcept_dt <= to_rcept_dt)
            .all()
    }
    
    func saveIfNotExists(on database: FluentKit.Database) -> EventLoopFuture<Void> {
        return ListItem.query(on: database)
            .filter(\.$corp_code == corp_code)
            .filter(\.$rcept_no == rcept_no)
            .first()
            .flatMap { result in
                guard nil == result else { return database.eventLoop.makeSucceededFuture(()) }
                return self.save(on: database)
            }
    }
}
