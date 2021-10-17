//
//  CityData.swift
//  WeatherToday
//
//  Created by dykoon on 2021/09/10.
//

import Foundation

//{
//    "city_name":"뉴욕",
//    "state":10,
//    "celsius":-2.6,
//    "rainfall_probability":0
//}

struct CityData: Codable {
    let city_name: String
    let state: Int
    let celsius: Double
    let rainfall_probability: Int
}
