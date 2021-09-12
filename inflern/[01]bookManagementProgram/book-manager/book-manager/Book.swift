//
//  Book.swift
//  book-manager
//
//  Created by dykoon on 2021/08/08.
//

struct Book {
    var name: String
    var genre: String
    var author: String
    
    func bookPrint() {
        print("Name: \(name)")
        print("Genre: \(genre)")
        print("Author: \(author)")
        print("--------------")
    }
}
