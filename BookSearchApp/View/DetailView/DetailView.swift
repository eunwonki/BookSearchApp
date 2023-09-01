//
//  DetailView.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/25.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let book: Book
    
    @State var cover: UIImage?
    
    var body: some View {
        VStack {
            HStack {
                Button("Back") {
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }.padding()
            
            ScrollView {
                ZStack {
                    Color.purple
                    
                    if let cover {
                        Image(uiImage: cover)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Image(systemName: "photo.artframe")
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                }
                .frame(width: 128, height: 178)
                .clipShape(Rectangle())
                
                Spacer().frame(height: 20)
                
                VStack(alignment: .leading, spacing: 15) {
                    descriptionRow(title: "제목", content: book.title)
                    descriptionRow(title: "저자", content: book.author_name?.joined(separator: ", ") ?? "")
                    descriptionRow(title: "출판사", content: book.publisher?.joined(separator: ", ") ?? "")
                    if let person = book.person {
                        descriptionRow(title: "등장인물", content: person.joined(separator: ", "))
                    }
                }.frame(alignment: .leading)
            }
        }
        .navigationViewStyle(.stack)
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            guard let coverUrl = book.coverUrl(.detail) else { return }
            Task {
                self.cover = try await CacheManager.shared.loadImage(
                    origin: coverUrl)
            }
        }
    }
    
    func descriptionRow(title: String, content: String) -> some View {
        HStack(alignment: .top) {
            Text("\(title): ")
                .frame(width: 100, alignment: .leading)
            Text(content)
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let book = Book(key: "1", type: "work",
                           title: "해리포터", author_name: ["조앤롤링"],
                           publisher: ["영국 출판사"], person: ["해리포터", "헤르미온느", "론 그레인저스"])
    
    static var previews: some View {
        DetailView(book: book)
    }
}
