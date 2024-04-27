//
//  Book.swift
//  BooksCarousel
//
//  Created by Ismailov Farrukh on 17/04/24.
//

import Foundation

struct Book: Identifiable, Decodable {
    var id: Int
    var title: String
    var img: String
    var bg: String
}
