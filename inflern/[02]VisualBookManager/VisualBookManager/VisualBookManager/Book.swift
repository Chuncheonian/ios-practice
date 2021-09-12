//
//  Book.swift
//  BookManager
//
//  Created by JinYoung Choi on 11/23/17.
//  Copyright © 2017 fapeng. All rights reserved.
//

struct Book {
    var name:String?
    var genre:String?
    var author:String?
    
    func bookPrint(){
        print("Name : \(name!)")
        print("Genre : \(genre!)")
        print("Author : \(author!)")
        print("------------")
    }
}
