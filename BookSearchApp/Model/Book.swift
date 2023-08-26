//
//  Book.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/26.
//

import Foundation

struct SearchResponse: Codable {
    var start = 0
    var numFound = 0
    var docs: [Book]
}

struct Book: Codable, Hashable {
    var key: String
    var type: String
    var title: String
    var author_name: [String]
    var publisher: [String]
    var cover_i: Int?
    
    var edition_count: Int?
    var first_publish_year: Int?
    var number_of_pages_median: Int?
    var publish_place: [String]?
    var subject: [String]?
    var person: [String]?
    
    enum CoverType: String {
        // https://openlibrary.org/dev/docs/api/covers
        // 'S'는 thumbnail, 'M'은 detail page를 위한 이미지. 'L'로 Large Image까지 지원.
        case thumbnail = "S"
        case detail = "M"
        case large = "L"
    }
    
    func coverUrl(_ type: CoverType) -> String? {
        guard let cover_i else { return nil }
        return "https://covers.openlibrary.org/b/id/\(cover_i)-\(type.rawValue).jpg"
    }
}
