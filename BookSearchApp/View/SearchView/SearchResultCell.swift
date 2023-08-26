//
//  SearchResultCell.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/26.
//

import SwiftUI

struct SearchResultCell: View {
    let book: Book
    
    var body: some View {
        HStack {
            Image(systemName: "heart")
                .resizable()
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("제목: ").foregroundColor(.white)
                    Text(book.title).foregroundColor(.white)
                        .lineLimit(1)
                }
                
                HStack {
                    Text("저자: ").foregroundColor(.white)
                    Text(book.author_name.joined(
                        separator: ",")).foregroundColor(.white)
                        .lineLimit(1)
                }
                
                HStack {
                    Text("출판사: ").foregroundColor(.white)
                    Text(book.publisher.joined(
                        separator: ",")).foregroundColor(.white)
                        .lineLimit(1)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.gray.cornerRadius(20))
        .contentShape(Rectangle())
        .onTapGesture { // TODO: Detail 화면 전환
        }
    }
}

struct SearchResultCell_Previews: PreviewProvider {
    static let book = Book(
        key: "1", type: "1", title: "바람과 함께 사라지다",
        author_name: ["Liam Eun"], publisher: ["오리온", "해태"])
    
    static var previews: some View {
        ZStack {
            SearchResultCell(book: book)
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.purple.ignoresSafeArea())
    }
}
