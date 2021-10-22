//
//  Movies.swift
//  BoxOffice
//
//  Created by dykoon on 2021/09/29.
//

import Foundation

struct APIResponse: Codable {
    let movies: [Movie]
}

struct Movie: Codable {
    let id: String
    let title: String
    let grade: Int
    let user_rating: Double
    let thumb: String
    let date: String
    let reservation_grade: Int
    let reservation_rate: Double
    
    var movieTableInfo: String {
        return "평점 : \(user_rating) 예매순위 : \(reservation_grade) 예매율 : \(reservation_rate)"
    }
    
    var setGradeImageName: String {
        if grade == 0 {
            return "ic_allages"
        } else {
            return "ic_\(grade)"
        }
    }
}
