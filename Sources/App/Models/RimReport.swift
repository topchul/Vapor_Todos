//
//  RimReport.swift
//  App
//
//  Created by irontop on 2020/06/20.
//

import Foundation

struct RimReport {
    struct Q {}
    struct Y {}
    struct E {}
    
    let corp: Company
    var q: [Q] // 이전 12분기
    var y: [Y] // 이전  3년
    var e: [E] // 다음  1년
    
    var help = [
        "asset": "분/반기의 자산총계는 누적 수치입니다.",
        "equity": "분/반기의 자본(지배)총계는 누적 수치입니다.",
        "operatingIncome": "분/반기의 영업이익은 3개월 수치입니다.",
        "profit": "분/반기의 순이익(지배)은 3개월 수치입니다.",
    ]
}

struct QuarterReport {
    /// 자산: 분/반기의 자산총계는 누적 수치입니다.
    ///     - `p13.연결재무제표:자본.부채총계|부채.자본총계|자본.부채.총계|부채.자본.총계`
    var asset: Int64
    
    /// 자본(지배) : 분/반기의 자본(지배)총계는 누적 수치입니다.
    ///     - `p13.연결재무제표:자본총계|자본`
    var equity: Int64
    
    /// 영업이익: 분/반기의 영업이익은 3개월 수치입니다.
    ///     - `p13.연결재무제표:영업이익`
    var operatingIncome: Int64
    
    /// 순이익: 분/반기의 순이익(지배)은 3개월 수치입니다.
    ///     - Y:`p13.연결재무제표:당기순.익.*귀속|당기순.익|당기순.익`
    ///     - Q:`p13.연결재무제표:당기순.익.*귀속|당기순.익|분기순.익.*귀속|분기순.익|반기순.익.*귀속|반기순.익`
    var profit: Int64
    
    /// 매출
    ///     - `p13.연결재무제표:매출액|영업수익|I\.매출\s|매출\s`
    var sails: Int64
    
    /// 유통주식수
    ///     - `p7.주식의 총수 등:유통주식수`
    var shares: Int64
}

struct YearReport {
    /// 자산: 분/반기의 자산총계는 누적 수치입니다.
    ///     - `p13.연결재무제표:자본.부채총계|부채.자본총계|자본.부채.총계|부채.자본.총계`
    var asset: Int64
    
    /// 재무활동 현금흐름
    ///     - `p13.연결재무제표:재무활동.*현금흐름|재무활동.*현금흐름.합계`
    var cashflow_financing: Int64 // 'cashflow_financing': -218284527064,
    
    /// 투자활동 현금흐름
    ///     - `p13.연결재무제표:투자활동.*현금흐름|투자활동.*현금흐름.합계`
    var cashflow_investing: Int64 // 'cashflow_investing': -289677467354,
    
    /// 영업활동 현금흐름
    ///     - `p13.연결재무제표:영업활동.*현금흐름|영업활동.*현금흐름.합계`
    var cashflow_operating: Int64 // 'cashflow_operating': 553585083431,
    
    /// 현금배당수익률
    ///     - `p9:현금배당수익률`
    var dividend: Double
    
    /// 자본(지배) : 분/반기의 자본(지배)총계는 누적 수치입니다.
    ///     - `p13.연결재무제표:자본총계|자본`
    var equity: Int64
    
    /// 금융비용 / 금융원가
    ///     - `p13.연결재무제표:금융비용|금융.비용|금융원가|금융.원가`
    var interestExpense: Int64    // 'interestExpense': 12336806182,
    
    /// 영업이익: 분/반기의 영업이익은 3개월 수치입니다.
    ///     - `p13.연결재무제표:영업이익`
    var operatingIncome: Int64
    
    /// 순이익: 분/반기의 순이익(지배)은 3개월 수치입니다.
    ///     - Y:`p13.연결재무제표:당기순.익.*귀속|당기순.익|당기순.익`
    ///     - Q:`p13.연결재무제표:당기순.익.*귀속|당기순.익|분기순.익.*귀속|분기순.익|반기순.익.*귀속|반기순.익`
    var profit: Int64
    
    /// 하드코딩 '연'
    var rm: String
    
    /// 매출
    ///     - `p13.연결재무제표:매출액|영업수익|I\.매출\s|매출\s`
    var sails: Int64
    
    /// 주식의 총수 등
    ///     - `p7:유통주식수`
    var shares: Int64
}







     
