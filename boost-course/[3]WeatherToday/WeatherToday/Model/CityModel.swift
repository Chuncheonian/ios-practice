//
//  CityManager.swift
//  WeatherToday
//
//  Created by dykoon on 2021/09/10.
//

import Foundation

struct CityModel {
    let cityName: String
    let celsius: Double
    let state: Int
    let rainfallProb: Int
    
    var celToFeh: String {
        return String(format: "%.1f", celsius * 9 / 5 + 32)
    }
    
    var imageSet: String {
        switch state {
        case 10:
            return "sunny"
        case 11:
            return "cloudy"
        case 12:
            return "rainy"
        case 13:
            return "snowy"
        default:
            return "sunny"
        }
    }
    
    var weatherText: String {
        switch state {
        case 10:
            return "맑음"
        case 11:
            return "흐림"
        case 12:
            return "비"
        case 13:
            return "눈"
        default:
            return "맑음"
        }
    }
}
