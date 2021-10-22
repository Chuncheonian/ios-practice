//
//  MovieInfo.swift
//  BoxOffice
//
//  Created by dykoon on 2021/10/05.
//

import UIKit

struct MovieInfo: Codable {
    let audience: Int
    let actor: String
    let duration: Int
    let director: String
    let synopsis: String
    let genre: String
    let grade: Int
    let image: String
    let reservation_grade: Int
    let title: String
    let reservation_rate: Double
    let user_rating: Double
    let date: String
    let id: String
       
    var reservationText: String {
        return "\(reservation_grade)위 \(reservation_rate)%"
    }
    
    var GenreDurationText: String {
        return "\(genre)/\(duration)분"
    }
    
    var setGradeImageName: String {
        if grade == 0 {
            return "ic_allages"
        } else {
            return "ic_\(grade)"
        }
    }
    
    var audienceFormat: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: audience)) ?? " "
    }
}
