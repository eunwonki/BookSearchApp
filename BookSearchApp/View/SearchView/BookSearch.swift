//
//  BookSearch.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/26.
//

import ComposableArchitecture
import UIKit

struct BookWithCover: Equatable {
    let book: Book
    let cover: UIImage?
}

struct BookSearch: Reducer {
    let size = 10
    
    struct State: Equatable {
        var keyword = ""
        var page = 1
        var books = [Book]()
        var loadingState = LoadingState.none
        var isFinished = false
        var thumbnails: [Book: UIImage] = [:]
        
        var showDetailView: Book?
        
        enum LoadingState {
            case none
            case loadingFirst
            case loadingMore
        }
    }
    
    enum Action: Equatable {
        case changeKeyword(String)
        case search
        case dataLoaded(TaskResult<[BookWithCover]>)
        case appear(Book)
        case showDetailView(Book?)
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
                    return await loadCovers(response)
                }
                await send(.dataLoaded(result))
            }
            
        case let .dataLoaded(.success(result)):
            state.loadingState = .none
            state.isFinished = result.count != size
            if state.page == 1 {
                state.books = result.map { $0.book }
            } else {
                state.books.append(contentsOf: result.map { $0.book })
            }
            result.forEach { state.thumbnails[$0.book] = $0.cover }
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
                    return await loadCovers(response)
                }
                await send(.dataLoaded(result))
            }
            
        case let .showDetailView(book):
            state.showDetailView = book
            return .none
        }
    }
    
    func loadCovers(_ response: SearchResponse) async -> [BookWithCover] {
        do {
            return try await response.docs.concurrentMap {
                if let thumbnailUrl = $0.coverUrl(.thumbnail) {
                    do {
                        let image = try await CacheManager.shared.loadImage(
                            origin: thumbnailUrl)
                        return BookWithCover(book: $0, cover: image)
                    } catch {
                        return BookWithCover(book: $0, cover: nil)
                    }
                }
                return BookWithCover(book: $0, cover: nil)
            }
        } catch {
            return response.docs.map { BookWithCover(book: $0, cover: nil) }
        }
    }
}
