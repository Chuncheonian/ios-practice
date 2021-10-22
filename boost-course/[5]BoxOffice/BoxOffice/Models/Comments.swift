//
//  Comments.swift
//  BoxOffice
//
//  Created by dykoon on 2021/10/05.
//

import Foundation

struct Comments: Codable {
    let comments: [Comment]
}

struct Comment: Codable {
    let id: String
    let movie_id: String
    let writer: String
    let contents: String
    let timestamp: Double
    let rating: Double
    
    var timestampToDateFormat: String {
        let timestamp = Date(timeIntervalSince1970: self.timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: timestamp)
    }
}
