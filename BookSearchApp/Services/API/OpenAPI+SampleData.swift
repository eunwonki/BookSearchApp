//
//  OpenAPI+SampleData.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/27.
//

import Foundation

#if DEBUG
extension OpenAPI {
    var sampleData: Data {
        switch self {
        case let .search(query, page, size):
            return try! JSONEncoder().encode(
                searchResult(query, page, size))
        }
    }
    
    func titleCandidates() -> [String] {
        return [
            "SwiftUI", "SwiftyUI",
            "SaltyUI", "SwiftJSON",
            "HarryPorter", "Apple",
            "Banana", "Canna"
        ]
    }
    
    func searchResult(_ query: String, _ page: Int, _ size: Int) -> SearchResponse {
        var response = SearchResponse(docs: [])
        let titleCandidates = titleCandidates().filter { $0.contains(query) }
        if titleCandidates.count == 0 { return response }
        for id in (page * size)..<((page + 1) * size) {
            var book = Book(key: "\(id)", type: "work",
                            title: titleCandidates.randomElement()!,
                            author_name: ["Liam"], publisher: ["America"])
            response.docs.append(book)
        }
        return response
    }
}
#endif
