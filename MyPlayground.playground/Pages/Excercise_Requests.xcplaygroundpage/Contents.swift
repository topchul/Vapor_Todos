//: [Previous](@previous)

/// 1. 기업개황 가져오기 : corp_code --> stock_code 등을 가져올 수 있다.
///     - api명세: https://opendart.fss.or.kr/guide/detail.do?apiGrpCd=DS001&apiId=2019002
///     - https://opendart.fss.or.kr/api/company.json?crtfc_key=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx&corp_code=00356370
/// 2. 공시검색 가져오기 : bgn_de(시작일)과 dsp_tp(공시타입)를 활용하여 모든 정기공시들을 볼 수 있는 url을 만들고, 이것을 json 형태로 받는다.
///     - api명세: https://opendart.fss.or.kr/guide/detail.do?apiGrpCd=DS001&apiId=2019001
///     - https://opendart.fss.or.kr/api/list.json?crtfc_key=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx&corp_code=00356370&
///       bgn_de=20100101&last_reprt_at=Y&pblntf_detail_ty=A001&corp_cls=Y&page_no=1&page_count=100
///
/// 3. 보고서 분석

import Foundation

let rcpNo = "20150813000996"

// 보고서 문서번호 획득:
//   http://dart.fss.or.kr/dsaf001/main.do?rcpNo=\(rcpNo)
//   http://dart.fss.or.kr/dsaf001/main.do?rcpNo=20150813000996


var string = String(contentsOf: URL(string: "http://dart.fss.or.kr/dsaf001/main.do?rcpNo=\(rcpNo)")!)
//let string = """
//<a href="#download" onclick="openPdfDownload('20150813000996', '4765431'); return false;" ><img src="/images/common/viewer_down.gif" style="cursor:pointer;" alt="다운로드" title="다운로드" /></a>
//"""

// <a href="#download" onclick="openPdfDownload('20150813000996', '4765431')
// openPdfDownload('20150813000996', '4765431');
let regEx = NSRegularExpression(pattern: "openPdfDownload[^a-z0-9]+\(rcpNo)[^a-z0-9]+\\b([0-9]{7})\\b[^a-z0-9]+;", options: [])

let matches = regEx.matches(in: string, options: .reportProgress, range: NSRange(location: 0, length: string.count))
print(matches.count)
print(matches[0].numberOfRanges)
print(matches[0].components)

let dcmNo = (string as NSString).substring(with: matches[0].range(at: 1))
print((string as NSString).substring(with: matches[0].range(at: 0)))
print(dcmNo)

string = "7654321 openPdfDownload('20150813000996', '4765431'); 1234567"
let interestRange = string.range(of: "openPdfDownload[^a-z0-9]+\(rcpNo)[^a-z0-9]+\\b([0-9]{7})\\b[^a-z0-9]+;", options: .regularExpression)
print(interestRange)
let targetRange = string.range(of: "\\b([0-9]{7})\\b", options: [.regularExpression], range: interestRange)
print(targetRange)
let targetString = string[targetRange!]
print(targetString)

//let targetRange = interestString



// 보고서 페이지 조회
// - queryItem 처리하기
// http://dart.fss.or.kr/report/viewer.do?rcpNo=20150813000996&dcmNo=4765431&length=20000&offset=20000&eleId=7
// - pages
//  -  7: 4. 주식의 총수 등
//  -  9: 6. 배당에 관한 사항 등
//  - 13: 2. 연결재무제표
var urlComp = URLComponents()
urlComp.scheme = "http"
urlComp.host = "dart.fss.or.kr"
urlComp.path = "/report/viewer.do"
urlComp.queryItems = [ URLQueryItem(name: "rcpNo", value: rcpNo),
                       URLQueryItem(name: "dcmNo", value: dcmNo),
                       URLQueryItem(name: "length", value: "20000"),
                       URLQueryItem(name: "offset", value: "20000"),
                       URLQueryItem(name: "eleId", value: "7") ]
let pageURL = urlComp.url!

let pageContents = String(contentsOf: pageURL)
print(pageContents)

//: [Next](@next)
