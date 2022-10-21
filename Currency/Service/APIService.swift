//
//  APIService.swift
//  Currency
//
//  Created by 안정흠 on 2022/10/20.
//

import Foundation
import Alamofire

class APIService {
    static var sharedObject = APIService()
    private var dateFormatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "YYYY-MM-dd"
        return format
    }()
    
    func currencyCheck(to: String, from: String, date: Date, completion: @escaping (CurrencyInfo)->Void) {
        let url = APIInfo.host + dateFormatter.string(from: date) + APIInfo.path + "/" + to + "/" + from + APIInfo.tail
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType:["application/json"])
            .responseData(completionHandler: { response in
            switch response.result {
            case let .success(data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(CurrencyInfo.self, from: data)
                    completion(result)
                } catch {
                    print("\(#file.split(separator: "/").last!)-\(#function)[\(#line)]")
                }
            case let .failure(error):
                print("\(error) \(#file.split(separator: "/").last!)-\(#function)[\(#line)]")
            }
        })
    }
    
}
