//
//  APIInfo.swift
//  Currency
//
//  Created by 안정흠 on 2022/10/20.
//

import Foundation
// "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/jpy/krw.json"
struct APIInfo {
    static let host = "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/"
    static let path = "/currencies"
    static let tail = ".json"
}

//struct APIList {
//    static let krw = "/krw"
//    static let jpy = "/jpy"
//    static let usd = "/usd"
//    static let eur = "/eur"
//    static let aud = "/aud"
//}
