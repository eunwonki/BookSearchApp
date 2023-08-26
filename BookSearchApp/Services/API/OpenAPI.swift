//
//  OpenAPI.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/25.
//

import Foundation
import Moya

enum OpenAPI: TargetType {
    case search(query: String, page: Int, size: Int)
    
    var baseURL: URL {
        URL(string: "https://openlibrary.org")!
    }
    
    var path: String {
        switch self {
        case .search: return "/search.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search: return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .search(query, page, size):
            return .requestParameters(
                parameters: [
                    "q": query,
                    "page": page,
                    "limit": size,
                ],
                encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
