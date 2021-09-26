//
//  CoinData.swift
//  ByteCoin
//
//  Created by dykoon on 2021/09/05.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
