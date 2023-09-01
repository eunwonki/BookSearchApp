//
//  SearchResultCell.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/26.
//

import SwiftUI

struct SearchResultCell: View {
    let book: Book
    let thumbnail: UIImage?
    
    var body: some View {
        HStack {
            ZStack {
                Color.blue
                
                if let thumbnail {
                    Image(uiImage: thumbnail)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "photo.artframe")
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
            }
            .frame(width: 64, height: 89)
            .clipShape(Rectangle())
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("제목: ").foregroundColor(.white)
                    Text(book.title).foregroundColor(.white)
                        .lineLimit(1)
                }
                
                HStack {
                    Text("저자: ").foregroundColor(.white)
                    Text(book.author_name?.joined(
                        separator: ",") ?? "").foregroundColor(.white)
                        .lineLimit(1)
                }
                
                HStack {
                    Text("출판사: ").foregroundColor(.white)
                    Text(book.publisher?.joined(
                        separator: ",") ?? "").foregroundColor(.white)
                        .lineLimit(1)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.gray.cornerRadius(20))
    }
}

struct SearchResultCell_Previews: PreviewProvider {
    static let book = Book(
        key: "1", type: "1", title: "바람과 함께 사라지다",
        author_name: ["Liam Eun"], publisher: ["오리온", "해태"])
    
    static var previews: some View {
        ZStack {
            SearchResultCell(book: book, thumbnail: nil)
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.purple.ignoresSafeArea())
    }
}
