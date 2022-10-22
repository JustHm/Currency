//
//  CurrencyCellInfo.swift
//  Currency
//
//  Created by 안정흠 on 2022/10/22.
//

import Foundation
//        좌측 국가, 우측 국가,
//        좌측 환율, 우측 환율
var currencyList: [CurrencyCellInfo] = []
struct CurrencyCellInfo: Codable {
    var leftCountry: String
    var rightCountry: String
    var leftCurrency: Double
    var rightCurrency: Double
}
