import UIKit

let year = Calendar(identifier: .gregorian).component(.year, from: Date())
let bgn_de = "\(year)0101"

let opendart_fss_or_kr__api = URL(string: "https://opendart.fss.or.kr/api/")!

let queryItem: URLQueryItem = .init(name: "a한=_", value: "값이다.!!@#!%!&^%=&#$%^TR><MNK")
queryItem.description

var urlComponents = URLComponents()
urlComponents.queryItems = [queryItem]
urlComponents.percentEncodedQuery
urlComponents.path
//urlComponents.scheme = "https"
//urlComponents.host = "irontop.com"
//urlComponents.path = "/haha/hoho"

urlComponents.url(relativeTo: nil)
let url = urlComponents.url(relativeTo: opendart_fss_or_kr__api)
print(url?.absoluteString)

//urlComponents
//    .percentEncodedQueryItems
//    .compactMap { $0. }

let stringAnyDicList: [[String: Any]] = [["a": "b"], ["a": "d"]]
type(of: stringAnyDicList)
let stringStringDicList = stringAnyDicList as? [[String: String]]
