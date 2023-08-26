//
//  SearchView.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject var model: ViewModel
    
    @State var isLoading = false
    @State var keyword = ""
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    TextField("키워드를 입력해주세요.", text: $keyword,
                              onCommit: fetchFirstPage)
                    .frame(maxWidth: .infinity)
                    
                    Button("검색", action: fetchFirstPage)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color.gray.opacity(0.5)))
                .padding()
                
                ScrollView {
                    LazyVStack {
                        ForEach(model.books, id: \.key) { book in
                            SearchResultCell(book: book)
                        }
                    }.padding(.horizontal, 16)
                }
            }.background(Color.purple.ignoresSafeArea())
            
            if isLoading {
                FullScreenProgressView()
            }
        }
        .onAppear {
            keyword = "ocean"
            fetchFirstPage()
        }
    }
    
    func fetchFirstPage() {
        guard isLoading == false else { return }
        
        isLoading = true
        Task {
            defer { isLoading = false }
            do {
                try await model.populate(query: keyword)
                print(model.books)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static let provider = Configuration(.real).provider
    static let model = SearchView.ViewModel(provider: provider)
    
    static var previews: some View {
        SearchView(model: model)
    }
}
