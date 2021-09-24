//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by dykoon on 2021/08/29.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    let text: String
    let answer: String
    
    init(q: String, a: String) {
        self.text = q
        self.answer = a
    }
}
