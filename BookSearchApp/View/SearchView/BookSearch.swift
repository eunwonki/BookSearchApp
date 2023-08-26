//
//  BookSearch.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/26.
//

import ComposableArchitecture

struct BookSearch: Reducer {
    let size = 10
    
    struct State: Equatable {
        var keyword = ""
        var page = 1
        var books = [Book]()
        var loadingState = LoadingState.none
        var isFinished = false
        
        enum LoadingState {
            case none
            case loadingFirst
            case loadingMore
        }
    }
    
    enum Action: Equatable {
        case changeKeyword(String)
        case search
        case dataLoaded(TaskResult<[Book]>)
        case appear(Book)
    }
    
    @Dependency(\.providers) var providers
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .changeKeyword(keyword):
            state.keyword = keyword
            return .none
            
        case .search:
            guard state.loadingState == .none else { return .none }
            
            state.page = 1
            state.loadingState = .loadingFirst
            return Effect.run { [state] send in
                let result = await TaskResult {
                    let response: SearchResponse = try await providers.open.request(
                        .search(query: state.keyword, page: state.page, size: size))
                    return response.docs
                }
                await send(.dataLoaded(result))
            }
            
        case let .dataLoaded(.success(books)):
            state.loadingState = .none
            state.isFinished = books.count != size
            if state.page == 1 {
                state.books = books
            } else {
                state.books.append(contentsOf: books)
            }
            return .none
            
        case .dataLoaded(.failure):
            state.loadingState = .none
            return .none
            
        case let .appear(book):
            guard state.isFinished == false else { return .none }
            guard let index = state.books.firstIndex(of: book) else {
                return .none
            }
            guard index == state.books.count - 1 else { return .none }
            guard state.loadingState == .none else { return .none }
            
            state.page += 1
            state.loadingState = .loadingMore
            return Effect.run { [state] send in
                let result = await TaskResult {
                    let response: SearchResponse = try await providers.open.request(
                        .search(query: state.keyword, page: state.page, size: size))
                    return response.docs
                }
                await send(.dataLoaded(result))
            }
        }
    }
}
