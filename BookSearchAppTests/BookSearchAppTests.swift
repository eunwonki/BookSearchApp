//
//  BookSearchAppTests.swift
//  BookSearchAppTests
//
//  Created by wonki on 2023/08/25.
//

import XCTest
import ComposableArchitecture

@testable import BookSearchApp

@MainActor
final class BookSearchAppTests: XCTestCase {
    
    func test_user_get_search_books_when_search() async {
        
        let providers = Providers(.preview)
        let store = TestStore(
            initialState: BookSearch.State()) {
                BookSearch()
            }
        store.dependencies.providers = providers
        
        // 1. 키워드를 입력했을때 keyword 상태가 정상적으로 변경되는지
        await store.send(.changeKeyword("Swift")) { newState in
            newState.keyword = "Swift"
        }
        
        // 2. 검색을 했을때, 예상하는 검색 결과가 나오는지를 테스트.
        await store.send(.search) { newState in
            newState.page = 1
            newState.loadingState = .loadingFirst
        }
        
        let result = OpenAPI.search(query: "Swift", page: 1, size: 10).searchResult("Swift", 1, 10).docs.map { BookWithCover(
            book: $0, cover: nil) }
        await store.receive(.dataLoaded(.success(result))) { newState in
            newState.page = 1
            newState.loadingState = .none
            newState.books = result.map { $0.book }
        }
    }
}
