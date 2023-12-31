//
//  SearchView.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/25.
//

import SwiftUI
import ComposableArchitecture

struct SearchView: View {
    let store: StoreOf<BookSearch>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            content(viewStore)
        }
    }
        
    @ViewBuilder func content(
        _ store: ViewStore<BookSearch.State, BookSearch.Action>)
    -> some View {
        ZStack {
            VStack {
                HStack {
                    TextField("키워드를 입력해주세요.",
                              text: store.binding(
                                get: \.keyword,
                                send: { .changeKeyword($0) }),
                              onCommit: { store.send(.search) })
                    .frame(maxWidth: .infinity)
                    
                    Button("검색") {
                        store.send(.search)
                    }.buttonStyle(.automatic)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(Color.gray.opacity(0.5)))
                .padding()
                
                ScrollView {
                    LazyVStack {
                        ForEach(store.books, id: \.key) { book in
                            SearchResultCell(
                                book: book,
                                thumbnail: store.thumbnails[book])
                            .onAppear {
                                store.send(.appear(book))
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                store.send(.showDetailView(book))
                            }
                            .background(navigationLink(store: store))
                        }
                        
                        if store.loadingState == .loadingMore {
                            ProgressView()
                        }
                    }.padding(.horizontal, 16)
                }
            }.background(Color.purple.ignoresSafeArea())
            
            if store.loadingState == .loadingFirst {
                FullScreenProgressView()
            }
        }
    }
    
    func navigationLink(
        store: ViewStore<BookSearch.State, BookSearch.Action>)
    -> some View {
        Group {
            if let book = store.showDetailView {
                NavigationLink(
                    destination: DetailView(
                        book: book),
                    isActive: store.binding(
                        get: {
                            $0.showDetailView != nil
                        },
                        send: { state in
                                .showDetailView(
                                    state ? book : nil)
                        })) {
                            EmptyView()
                        }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static let store = Store(initialState: BookSearch.State()) {
        BookSearch()
    } withDependencies: {
        $0.providers = Providers(.preview)
    }
    
    static var previews: some View {
        SearchView(store: store)
            .onAppear {
                store.send(.changeKeyword("Swift"))
                store.send(.search)
            }
    }
}
