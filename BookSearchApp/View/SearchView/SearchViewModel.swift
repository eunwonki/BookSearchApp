//
//  SearchViewModel.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/25.
//

import Foundation
import Moya

extension SearchView {
    @MainActor
    class ViewModel: ObservableObject {
        let provider: MoyaProvider<OpenAPI>
        @Published var books: [Book] = []
        
        init(provider: MoyaProvider<OpenAPI>) {
            self.provider = provider
        }
        
        var query: String = ""
        var page = 1
        let size = 10
        func populate(query: String) async throws {
            self.query = query
            let response: SearchResponse = try! await provider.request(
                .search(query: self.query, page: page, size: size))
            books = response.docs
        }
    }
}

struct SearchResponse: Codable {
    var start = 0
    var numFound = 0
    var docs: [Book]
}

struct Book: Codable {
    var key: String
    var type: String
    var title: String
    var author_name: [String]
    var publisher: [String]
    var cover_i: Int?
    
    enum CoverType: String {
        // https://openlibrary.org/dev/docs/api/covers
        // 'S'는 thumbnail, 'M'은 detail page를 위한 이미지. 'L'로 Large Image까지 지원.
        case thumbnail = "S"
        case detail = "M"
        case large = "L"
    }
    
    func coverUrl(_ type: CoverType) -> String? {
        guard let cover_i else { return nil }
        return "https://covers.openlibrary.org/b/isbn/\(cover_i)-\(type.rawValue).jpg"
    }
}
