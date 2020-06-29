//
//  DartClient.swift
//  App
//
//  Created by irontop on 2020/06/15.
//
//  구현전략
//      일단 프랭코드의 접근 방법과 동일하게 진행해보자. 조금 중복이나더라도. 조금 이상하더라도.

import Foundation

struct DartURLs {
    
}
//let unitest: Corperation = .init(corp_code: "00540447", corp_name: "유니테스트", stock_code: "086390")
//let crtfc_key_1 = "6b0d8da093bdc9a7f62fa77f33dd2838d196c040" // frank
let crtfc_key = "9e8dbcdef95ee4a5bfcf3d8b432fb6ff1c98c616" // gregory
let opendart_fss_or_kr = "opendart.fss.or.kr"
//let opendart_fss_or_kr__api = "https://opendart.fss.or.kr/api/"
let dart_fss_or_kr = "dart.fss.or.kr"

// page_count = '100'
// pblntf_A = 'A'
// pblntf_I = 'I001'
// last_reprt_at = 'Y'
// price_unit = 1
// targeted_return = targeted_return()
// bgn_de = '{}0101'.format(datetime.today().year - 3)
// dividend_rate = 1.19

class JSONLoader {
    static let shared: JSONLoader = .init()
    
    class RequestHistory {
        let limit = (forSec: TimeInterval(60), numberOfRequests: Int(90))
//        let limit = (forSec: TimeInterval(60), numberOfRequests: Int(2))

        private(set) var history: [Date] = []
        func addHistory(at: Date = Date()) {
            history.append(at)
        }
        var canRequest: Bool {
            guard history.count >= limit.numberOfRequests else {
                return true
            }
            while history.count > limit.numberOfRequests {
                history.removeFirst(history.count - limit.numberOfRequests)
            }
            guard let lastRequestAt = history.first else {
                return true
            }
            if (-lastRequestAt.timeIntervalSinceNow) > limit.forSec {
                return true
            } else {
                print(Date(), ":request exceed: waiting until:", lastRequestAt + limit.forSec)
                return false
            }
        }
    }
    var requestHistory: RequestHistory = .init()
    
    func loadDictionary(_ url: URL?) -> [String: Any]? {
        guard requestHistory.canRequest else { return nil }

        guard let url = url else { return nil }
        requestHistory.addHistory()
        guard let data = try? Data(contentsOf: url) else { return nil }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return nil }
        return jsonObject
    }
    func loadList(_ url: URL?) -> [Any]? {
        guard requestHistory.canRequest else { return nil }
        
        guard let url = url else { return nil }
        requestHistory.addHistory()
        guard let data = try? Data(contentsOf: url) else { return nil }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any] else { return nil }
        return jsonObject
    }
    func loadString(_ url: URL?) -> String? {
        guard requestHistory.canRequest else { return nil }
        
        guard let url = url else { return nil }
        requestHistory.addHistory()
        guard let string = try? String(contentsOf: url, encoding: .utf8) else { return nil }
        return string
    }
    
    func loadDictionary(scheme: String = "https", host: String, path: String, parameters: [String: String]?) -> [String: Any]? {
        loadDictionary(_apiURL(scheme: scheme, host: host, path: path, parameters: parameters))
    }
    func loadList(scheme: String = "https", host: String, path: String, parameters: [String: String]?) -> [Any]? {
        loadList(_apiURL(scheme: scheme, host: host, path: path, parameters: parameters))
    }
    func loadString(scheme: String = "https", host: String, path: String, parameters: [String: String]?) -> String? {
        loadString(_apiURL(scheme: scheme, host: host, path: path, parameters: parameters))
    }
    
    func _apiURL(scheme: String = "https", host: String, path: String = "", parameters: [String: String]?) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = parameters.flatMap { $0.map { URLQueryItem(name: $0.key, value: $0.value) } }
        return urlComponents.url
    }
}

class DartClient {
    let loader: JSONLoader = .shared
    
    /// 기업개황 가져오기: `corp_code --> [stock_code, stock_name, ...]`
    ///   - api명세: https://opendart.fss.or.kr/guide/detail.do?apiGrpCd=DS001&apiId=2019002
    func getCompany(corp_code: String) -> Company? {
        // Basic / corp_code와 crtfc_key를 활용하여 기업 개황을 알 수 있는 url을 만들고, 이것을 json 형태로 받는다.
        // https://opendart.fss.or.kr/api/company.json?crtfc_key=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx&corp_code=00356370
        // {
        //     "acc_mt":        "12",
        //     "adres":         "경기도 용인시 기흥구  기곡로 27 (주)유니테스트",
        //     "bizr_no":       "1298133266",
        //     "ceo_nm":        "김종현",
        //     "corp_cls":      "K', ← 아마도 코"탁
        //     "corp_code":     "00540447",
        //     "corp_name":     "주)유니테스트",
        //     "corp_name_eng": "UniTestInc.",
        //     "est_dt":        "20000321",
        //     "fax_no":        "031-203-5886",
        //     "hm_url":        "www.uni-test.com",
        //     "induty_code":   "29271",
        //     "ir_url":        "a",
        //     "jurir_no":      "1311110047356",
        //     "message":       "정상",
        //     "phn_no":        "031-205-6111",
        //     "status":        "000",
        //     "stock_code":    "086390",
        //     "stock_name":    "유니테스트",
        // }
        let parameters = ["crtfc_key": crtfc_key,
                          "corp_code": corp_code ]
        guard let jsonObject = loader.loadDictionary(host: opendart_fss_or_kr, path: "/api/company.json", parameters: parameters),
            let status = jsonObject["status"] as? String
            else {
                return nil
        }
        let companyInput = Company.Input(status: status,
                                         message: jsonObject["message"] as? String,
                                         corp_code: corp_code,
                                         corp_name: jsonObject["corp_name"] as? String,
                                         corp_name_eng: jsonObject["corp_name_eng"] as? String,
                                         stock_name: jsonObject["stock_name"] as? String,
                                         stock_code: jsonObject["stock_code"] as? String,
                                         ceo_nm: jsonObject["ceo_nm"] as? String,
                                         corp_cls: jsonObject["corp_cls"] as? String,
                                         jurir_no: jsonObject["jurir_no"] as? String,
                                         bizr_no: jsonObject["bizr_no"] as? String,
                                         adres: jsonObject["adres"] as? String,
                                         hm_url: jsonObject["hm_url"] as? String,
                                         ir_url: jsonObject["ir_url"] as? String,
                                         phn_no: jsonObject["phn_no"] as? String,
                                         fax_no: jsonObject["fax_no"] as? String,
                                         induty_code: jsonObject["induty_code"] as? String,
                                         est_dt: jsonObject["est_dt"] as? String,
                                         acc_mt: jsonObject["acc_mt"] as? String)
        let company = Company(companyInput)
        return company
    }
    
    /// 공시검색 가져오기: `corp_code --> [보고서]`
    ///     - api명세: https://opendart.fss.or.kr/guide/detail.do?apiGrpCd=DS001&apiId=2019001
    func getListItems(corp_code: String) -> [ListItem]? {
        // Basic / bgn_de(시작일)과 dsp_tp(공시타입)를 활용하여 모든 정기공시들을 볼 수 있는 url을 만들고, 이것을 json 형태로 받는다.
        // https://opendart.fss.or.kr/api/list.json?crtfc_key=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx&corp_code=00356370&bgn_de=20100101&last_reprt_at=Y&pblntf_detail_ty=A001&corp_cls=Y&page_no=1&page_count=100
        // [
        //    "list":[
        //       [ "rcept_no":"20200515001781", "report_nm":"분기보고서 (2020.03)"        , "rm":"", "corp_cls":"Y", "corp_code":"00170558", "corp_name":"코웨이", "flr_nm":"코웨이", "rcept_dt":"20200515", "stock_code":"021240" ],
        //       [ "rcept_no":"20200330002548", "report_nm":"사업보고서 (2019.12)"        , "rm":"연", "corp_cls":"Y", "corp_code":"00170558", "corp_name":"코웨이", "flr_nm":"코웨이", "rcept_dt":"20200330", "stock_code":"021240" ],
        //       [ "rcept_no":"20191114001151", "report_nm":"분기보고서 (2019.09)"        , "rm":"", "corp_cls":"Y", "corp_code":"00170558", "corp_name":"코웨이", "flr_nm":"코웨이", "rcept_dt":"20191114", "stock_code":"021240" ],
        //       [ "rcept_no":"20190814002918", "report_nm":"반기보고서 (2019.06)"        , "rm":"", "corp_cls":"Y", "corp_code":"00170558", "corp_name":"코웨이", "flr_nm":"코웨이", "rcept_dt":"20190814", "stock_code":"021240" ],
        //       [ "rcept_no":"20190814001499", "report_nm":"[기재정정]분기보고서 (2019.03)", "rm":"", "corp_cls":"Y", "corp_code":"00170558", "corp_name":"코웨이", "flr_nm":"코웨이", "rcept_dt":"20190814", "stock_code":"021240" ],
        //       [ "rcept_no":"20190814001347", "report_nm":"[기재정정]사업보고서 (2018.12)", "rm":"연", "corp_cls":"Y", "corp_code":"00170558", "corp_name":"코웨이", "flr_nm":"코웨이", "rcept_dt":"20190814", "stock_code":"021240" ],
        //       ...
        //    ],
        //    "message":"정상",
        //    "page_count":100,
        //    "page_no":1,
        //    "status":"000",
        //    "total_count":14,
        //    "total_page":1
        // ]
        // https://opendart.fss.or.kr/api/list.json
        //     crtfc_key=6b0d8da093bdc9a7f62fa77f33dd2838d196c040&
        //     corp_code=00170558& <--
        //     bgn_de=20170101& <-- 3년 전 1/1
        //     last_reprt_at=Y&
        //     pblntf_ty=A&
        //     page_no=1&
        //     page_count=100
        
        let gregorian = Calendar(identifier: .gregorian)
        let bgn_date = gregorian.date(byAdding: .year, value: -3, to: Date())!
        let yearBefore3Years = gregorian.component(.year, from: bgn_date)
        let parameters = [ "crtfc_key": crtfc_key,
                           "corp_code": corp_code,
                           "bgn_de": "\(yearBefore3Years)0101",
                           "last_reprt_at": "Y",
                           "pblntf_ty": "A",
                           "page_no": "1",
                           "page_count": "100"
        ]
        guard let jsonObject = loader.loadDictionary(host: opendart_fss_or_kr, path: "/api/list.json", parameters: parameters),
            let list = jsonObject["list"] as? [[String: String]]
            else {
                return nil
        }
        
        var items: [ListItem] = .init()
        for item in list {
            let dcmNo = getDcmNo(rcpNo: item["rcept_no"]!)
            
            items.append(ListItem(corp_cls:   item["corp_cls"]!,
                                  corp_name:  item["corp_name"]!,
                                  corp_code:  item["corp_code"]!,
                                  stock_code: item["stock_code"]!,
                                  report_nm:  item["report_nm"]!,
                                  rcept_no:   item["rcept_no"]!,
                                  flr_nm:     item["flr_nm"]!,
                                  rcept_dt:   item["rcept_dt"]!,
                                  rm:         item["rm"]!,
                                  dcm_no:     dcmNo))
        }
        
        return items
    }
        
    /// 보고서 문서번호  가져오기
    ///     - 문서 RootURL: http://dart.fss.or.kr/dsaf001/main.do?rcpNo=\(rcpNo)
    func getDcmNo(rcpNo: String) -> String? {
        // <a href="#download" onclick="openPdfDownload('20150813000996', '4765431'); return false;" ><img src="/images/common/viewer_down.gif" style="cursor:pointer;" alt="다운로드" title="다운로드" /></a>
        //                              ---------------------------------------------
        // openPdfDownload('20150813000996', '4765431');
        //                                    -------
        // 4765431
        
//        // NSRegularExpression 을 사용할 수 없다. (눈물)
//        let regEx = try? NSRegularExpression(pattern: "openPdfDownload[^a-z0-9]+\(rcpNo)[^a-z0-9]+\\b([0-9]{7})\\b[^a-z0-9]+;", options: [])
//        let matches = regEx.matches(in: string, options: .reportProgress, range: NSRange(location: 0, length: string.count))
//        print(matches.count)             // 1
//        print(matches[0].numberOfRanges) // 2
//        print(matches[0].components)     // nil
//        print((string as NSString).substring(with: matches[0].range(at: 0))) // openPdfDownload('20150813000996', '4765431');
//        print((string as NSString).substring(with: matches[0].range(at: 1))) // 4765431

        let parameters = [ "rcpNo": rcpNo ]
        guard let string = loader.loadString(scheme: "http", host: dart_fss_or_kr, path: "/dsaf001/main.do", parameters: parameters),
            let interestRange = string.range(of: "openPdfDownload[^a-z0-9]+\(rcpNo)[^a-z0-9]+\\b([0-9]{7})\\b[^a-z0-9]+;", options: .regularExpression),
            let targetRange = string[interestRange].range(of: "\\b([0-9]{7})\\b", options: [.regularExpression, .backwards])
            else {
                return nil
        }
        return String(string[targetRange])
    }
    
    /// 고유번호(CorpCode) 가져오기
    ///     - api명세: https://opendart.fss.or.kr/guide/detail.do?apiGrpCd=DS001&apiId=2019018
    func getCorpCode() -> [CorpCode] {
        // Basic / bgn_de(시작일)과 dsp_tp(공시타입)를 활용하여 모든 정기공시들을 볼 수 있는 url을 만들고, 이것을 json 형태로 받는다.
        // https://opendart.fss.or.kr/api/corpCode.xml?crtfc_key=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        // <result>
        //     <list>
        //         <corp_code>00434003</corp_code>
        //         <corp_name>다코</corp_name>
        //         <stock_code> </stock_code>
        //         <modify_date>20170630</modify_date>
        //     </list>
        //     <list>
        //         <corp_code>00434456</corp_code>
        //         <corp_name>일산약품</corp_name>
        //         <stock_code> </stock_code>
        //         <modify_date>20170630</modify_date>
        //     </list>
        //         ...
        // </result>
        
//        let parameters = ["crtfc_key": crtfc_key]
//        guard let xmlString = loader.loadString(host: opendart_fss_or_kr, path: "/api/corpCode.xml", parameters: parameters) else {
        guard let xmlString = try? String(contentsOfFile: "/Users/irontop/Library/Developer/Xcode/DerivedData/Todos-dzeoxedchjefexdcptvuwxxddyge/Build/Products/Debug/CORPCODE.xml") else {
            print("getCorpCode() failed to load corpCode.xml")
            return []
        }
        
        var extractedItems: [CorpCode] = []
        var curItem: CorpCode.Input!
        var range = xmlString.startIndex..<xmlString.endIndex
        while let subRange = xmlString.range(of: "<list>|</list>|<(corp_code|corp_name|stock_code|modify_date)>[^<]*", options: .regularExpression, range: range) {
            let element = xmlString[subRange]
            switch element {
            case "<list>":
                curItem = .init()
                
            case "</list>":
                extractedItems.append(CorpCode(curItem))
                curItem = nil

            default:
                let nodes = element.split(separator: ">")
                switch nodes[0] {
                case "<corp_code":   curItem.corp_code   = nodes[1].trimmingCharacters(in: .whitespacesAndNewlines)
                case "<corp_name":   curItem.corp_name   = nodes[1].trimmingCharacters(in: .whitespacesAndNewlines)
                case "<stock_code":  curItem.stock_code  = nodes[1].trimmingCharacters(in: .whitespacesAndNewlines)
                case "<modify_date": curItem.modify_date = nodes[1].trimmingCharacters(in: .whitespacesAndNewlines)
                default:
                    fatalError()
                }
            }
            range = subRange.upperBound..<range.upperBound
        }
        
        return extractedItems
    }
}
