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
