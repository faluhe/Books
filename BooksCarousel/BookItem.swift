//
//  BookItem.swift
//  BooksCarousel
//
//  Created by Ismailov Farrukh on 26/04/24.
//

import SwiftUI

struct BookItem: View {
    let book: Book
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let midX = geometry.frame(in: .global).midX
            let distance = abs(width - midX)
            let damping: CGFloat = 4.5
            let percentage = abs(distance / width / damping - 1)
            
            VStack {
                Image(book.img)
                    .resizable()
                    .scaledToFit()
                    .border(.white)
                    .frame(width: width, height: height)
                    .shadow(color: .black.opacity(0.5), radius: 10, y: 10)
                
                Text(book.title)
                    .font(.largeTitle).fontWeight(.regular)
                    .foregroundStyle(.white)
                    .shadow(color: .white.opacity(0.5), radius: 20, x: 10 )
                
            }
            .frame(maxHeight: .infinity)
            .scaleEffect(percentage)
        }
        .frame(width: width)
    }
}
