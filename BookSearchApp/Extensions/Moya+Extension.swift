//
//  Moya.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/25.
//

import Foundation
import Moya

extension MoyaProvider {
    func request(_ target: Target) async throws {
        _ = try await requestData(target)
    }
    
    func request<T: Decodable>(_ target: Target) async throws -> T {
        let data = try await requestData(target)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    private func requestData(_ target: Target) async throws -> Data {
        return try await withUnsafeThrowingContinuation { continuation in
            self.request(
                target, completion: { result in
                    switch result {
                    case .success(let response):
                        continuation.resume(returning: response.data)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                })
        }
    }
}

