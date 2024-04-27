//
//  ContentView.swift
//  BooksCarousel
//
//  Created by Ismailov Farrukh on 17/04/24.
//

import SwiftUI

struct ContentView: View {

    var viewModel: BookViewModelType
    @State private var offsetX: CGFloat = 0
    @State private var maxOffsetX: CGFloat = -1

    init(viewModel: BookViewModelType) {
        self.viewModel = viewModel
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundCarousel(reader: geometry)
                booksCarousel(reader: geometry)
            }
        }
    }

    func backgroundCarousel(reader: GeometryProxy) -> some View {
        //calculations
        let bgWidth: CGFloat = reader.size.width * CGFloat(viewModel.books.count)
        let scrollPercentage = offsetX / maxOffsetX
        let clampedPercentage: CGFloat = 1 - max(0, min(scrollPercentage, 1))
        let posX: CGFloat = (bgWidth - reader.size.width) * clampedPercentage

        return HStack(spacing: 0) {
            ForEach(viewModel.books.reversed()) { book in
                Image(book.bg)
                    .resizable()
                    .scaleEffect(1.05)
                    .frame(width: reader.size.width)
                    .blur(radius: 8)
                    .overlay(Color.black.opacity(0.5))
                    .clipped()
                    .ignoresSafeArea()
            }
        }
        .frame(width: bgWidth)
        .position(x: bgWidth / 2 - posX, y: reader.size.height / 2)
    }

    func booksCarousel(reader: GeometryProxy) -> some View {
        //calculations
        let screenSize = reader.size
        let itemWidth = screenSize.width * 0.8
        let itemHeight = screenSize.height * 0.6
        let paddingX: CGFloat = (screenSize.width - itemWidth) / 2
        
        return ScrollView(.horizontal) {
            HStack {
                HStack {
                    GeometryReader { geometry -> Color in
                        DispatchQueue.main.async {
                            offsetX = (geometry.frame(in: .global).minX - paddingX) * -1
                            let scrollContentWidth = itemWidth * CGFloat(viewModel.books.count) +  CGFloat(viewModel.books.count - 1)
                            let maxOffSetX = scrollContentWidth + 2 * paddingX - screenSize.width
                            if self.maxOffsetX == -1 {
                                self.maxOffsetX = maxOffSetX
                            }
                        }
                        return Color.clear
                    }
                    .frame(width: 0)

                    ForEach(viewModel.books) { book in
                        BookItem(book: book, width: itemWidth, height: itemHeight)
                    }
                }
            }
            .padding(.horizontal, paddingX)
        }
        .scrollIndicators(.hidden)
    }
}



#Preview {
    ContentView(viewModel: BookViewModel(networkService: NetworkService()))
}





