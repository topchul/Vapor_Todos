//
//  Document.swift
//  App
//
//  Created by irontop on 2020/07/04.
//
//  Unique
//    corp_code
//    dcm_no
//    report_nm
//    year
//    report_type
//    modified
//
//    /// 자산: 분/반기의 자산총계는 누적 수치입니다.
//    ///     - `p13.연결재무제표:자본.부채총계|부채.자본총계|자본.부채.총계|부채.자본.총계`
//    var asset: Int64
//
//    /// 재무활동 현금흐름
//    ///     - `p13.연결재무제표:재무활동.*현금흐름|재무활동.*현금흐름.합계`
//    var cashflow_financing: Int64 // 'cashflow_financing': -218284527064,
//
//    /// 투자활동 현금흐름
//    ///     - `p13.연결재무제표:투자활동.*현금흐름|투자활동.*현금흐름.합계`
//    var cashflow_investing: Int64 // 'cashflow_investing': -289677467354,
//
//    /// 영업활동 현금흐름
//    ///     - `p13.연결재무제표:영업활동.*현금흐름|영업활동.*현금흐름.합계`
//    var cashflow_operating: Int64 // 'cashflow_operating': 553585083431,
//
//    /// 현금배당수익률
//    ///     - `p9:현금배당수익률`
//    var dividend: Double
//
//    /// 자본(지배) : 분/반기의 자본(지배)총계는 누적 수치입니다.
//    ///     - `p13.연결재무제표:자본총계|자본`
//    var equity: Int64
//
//    /// 금융비용 / 금융원가
//    ///     - `p13.연결재무제표:금융비용|금융.비용|금융원가|금융.원가`
//    var interestExpense: Int64    // 'interestExpense': 12336806182,
//
//    /// 영업이익: 분/반기의 영업이익은 3개월 수치입니다.
//    ///     - `p13.연결재무제표:영업이익`
//    var operatingIncome: Int64
//
//    /// 순이익: 분/반기의 순이익(지배)은 3개월 수치입니다.
//    ///     - Y:`p13.연결재무제표:당기순.익.*귀속|당기순.익|당기순.익`
//    ///     - Q:`p13.연결재무제표:당기순.익.*귀속|당기순.익|분기순.익.*귀속|분기순.익|반기순.익.*귀속|반기순.익`
//    var profit: Int64
//
//    /// 하드코딩 '연'
//    var rm: String
//
//    /// 매출
//    ///     - `p13.연결재무제표:매출액|영업수익|I\.매출\s|매출\s`
//    var sails: Int64
//
//    /// 주식의 총수 등
//    ///     - `p7:유통주식수`
//    var shares: Int64

import Fluent
import Foundation
import Vapor

final class Document: Model, Content {
    static let schema = "document"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "corp_code")
    var corp_code: String
    @Field(key: "dcm_no")
    var dcm_no: String
    @Field(key: "report_nm")
    var report_nm: String
    @Field(key: "year")
    var year: String
    @Field(key: "report_type")
    var report_type: String
    @Field(key: "modified")
    var modified: String
    
    /// 자산 - `p13.연결재무제표:자본.부채총계|부채.자본총계|자본.부채.총계|부채.자본.총계`
    @Field(key: "asset")
    var asset: Int64

    /// 재무활동 현금흐름 - `p13.연결재무제표:재무활동.*현금흐름|재무활동.*현금흐름.합계`
    @Field(key: "cashflow_financing")
    var cashflow_financing: Int64?

    /// 투자활동 현금흐름 - `p13.연결재무제표:투자활동.*현금흐름|투자활동.*현금흐름.합계`
    @Field(key: "cashflow_investing")
    var cashflow_investing: Int64?

    /// 영업활동 현금흐름 - `p13.연결재무제표:영업활동.*현금흐름|영업활동.*현금흐름.합계`
    @Field(key: "cashflow_operating")
    var cashflow_operating: Int64?

    /// 현금배당수익률 - `p9:현금배당수익률`
    @Field(key: "dividend")
    var dividend: Double?

    /// 자본(지배) - `p13.연결재무제표:자본총계|자본`
    @Field(key: "equity")
    var equity: Int64

    /// 금융비용 / 금융원가 - `p13.연결재무제표:금융비용|금융.비용|금융원가|금융.원가`
    @Field(key: "interestExpense")
    var interestExpense: Int64?

    /// 영업이익- `p13.연결재무제표:영업이익`
    @Field(key: "operatingIncome")
    var operatingIncome: Int64

    /// 순이익: - Y:`p13.연결재무제표:당기순.익.*귀속|당기순.익|당기순.익` - Q:`p13.연결재무제표:당기순.익.*귀속|당기순.익|분기순.익.*귀속|분기순.익|반기순.익.*귀속|반기순.익`
    @Field(key: "profit")
    var profit: Int64

    /// 매출 - `p13.연결재무제표:매출액|영업수익|I\.매출\s|매출\s`
    @Field(key: "sails")
    var sails: Int64

    /// 주식의 총수 등 - `p7:유통주식수`
    @Field(key: "shares")
    var shares: Int64
    
    init() { }
    
    init(corp_code: String,
         report_nm: String,
         dcm_no: String,
         year: String,
         report_type: String,
         modified: String,
         asset: Int64,
         cashflow_financing: Int64?,
         cashflow_investing: Int64?,
         cashflow_operating: Int64?,
         dividend: Double?,
         equity: Int64,
         interestExpense: Int64?,
         operatingIncome: Int64,
         profit: Int64,
         sails: Int64,
         shares: Int64) {
        
        self.corp_code  = corp_code
        self.dcm_no     = dcm_no
        self.report_nm  = report_nm
        self.year        = year
        self.report_type = report_type
        self.modified    = modified
        
        self.asset              = asset
        self.cashflow_financing = cashflow_financing
        self.cashflow_investing = cashflow_investing
        self.cashflow_operating = cashflow_operating
        self.dividend           = dividend
        self.equity             = equity
        self.interestExpense    = interestExpense
        self.operatingIncome    = operatingIncome
        self.profit             = profit
        self.sails              = sails
        self.shares             = shares
    }
    
    var description: String {
        var builder: [String] = .init()
        builder.append("corp_code(\(corp_code))")
        builder.append("dcm_no(\(dcm_no))")
        builder.append("report_nm(\(report_nm))")
        
        builder.append("year(\(year))")
        builder.append("report_type(\(report_type))")
        builder.append("modified(\(modified))")
        
        builder.append("asset(\(asset)")
        builder.append("cashflow_financing(\(cashflow_financing?.description ?? "nil")")
        builder.append("cashflow_investing(\(cashflow_investing?.description ?? "nil")")
        builder.append("cashflow_operating(\(cashflow_operating?.description ?? "nil")")
        builder.append("dividend(\(dividend?.description ?? "nil")")
        builder.append("equity(\(equity)")
        builder.append("interestExpense(\(interestExpense?.description ?? "nil")")
        builder.append("operatingIncome(\(operatingIncome)")
        builder.append("profit(\(profit)")
        builder.append("sails(\(sails)")
        builder.append("shares(\(shares)")
        
        return "Document(" + builder.joined(separator: " ") + ")"
    }
}

//corp_code
//dcm_no
//report_nm
//year
//report_type
//modified
//asset
//cashflow_financing
//cashflow_investing
//cashflow_operating
//dividend
//equity
//interestExpense
//operatingIncome
//profit
//sails
//shares
