//
//  BooksCarouselApp.swift
//  BooksCarousel
//
//  Created by Ismailov Farrukh on 17/04/24.
//

import SwiftUI

@main
struct BooksCarouselApp: App {

    var bookViewModel = BookViewModel(networkService: NetworkService())
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: bookViewModel)
        }
    }
}
