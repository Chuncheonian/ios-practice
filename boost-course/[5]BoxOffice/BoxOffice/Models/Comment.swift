//
//  Comment.swift
//  BoxOffice
//
//  Created by dykoon on 2021/10/05.
//

import UIKit

struct CommentReq: Codable {
    
    let movie_id: String
    let rating: Double
    let timestamp: Double
    let writer: String
    let contents: String
}
