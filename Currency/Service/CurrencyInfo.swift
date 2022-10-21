//
//  CurrencyInfo.swift
//  Currency
//
//  Created by 안정흠 on 2022/10/20.
//

import Foundation

struct CurrencyInfo: Codable {
    let date: String
    let target: Double
    
    enum CodingKeys: String, CodingKey {
        case date
        case target = "krw"
    }
}

