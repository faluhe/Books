//
//  BookViewModel.swift
//  BooksCarousel
//
//  Created by Ismailov Farrukh on 17/04/24.
//

import Foundation

protocol BookViewModelType {
    var books: [Book] { get }
    func loadData()
}

final class BookViewModel: BookViewModelType, ObservableObject {

    @Published var books: [Book] = []

    var networkService: NetworkServiceType!

    init(networkService: NetworkServiceType!) {
        self.networkService = networkService
        loadData()
    }

    func loadData() {
        if let loadedBooks: [Book] = networkService.loadData(fileName: "Books") {
            self.books = loadedBooks
        }
    }
}
