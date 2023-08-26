//
//  CacheManager.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/26.
//

import Foundation
import UIKit

@globalActor
struct FileActor {
  actor ActorType { }
  static let shared: ActorType = ActorType()
}

enum CacheSaveError: Error {
    case invalidPath(key: String)
}

enum CacheLoadError: Error {
    case invalidPath(key: String)
}

class CacheManager {
    static let shared = CacheManager()
    
    func loadImage(origin: String) async throws -> UIImage? {
        guard let url = URL(string: origin) else {
            throw CacheLoadError.invalidPath(key: origin)
        }
        
        guard let cacheUrl = cacheUrlOf(origin: url) else {
            throw CacheLoadError.invalidPath(key: origin)
        }
        if FileManager.default.fileExists(atPath: cacheUrl.path) {
            let data = try Data(contentsOf: cacheUrl)
            return UIImage(data: data)
        } else {
            let data = try Data(contentsOf: url)
            Task { try! await saveToLocal(origin: url, data: data) }
            return UIImage(data: data)
        }
    }
    
    private func cacheUrlOf(origin: URL) -> URL? {
        let cacheDirectoryURL = FileManager.default.urls(
            for: .libraryDirectory, in: .userDomainMask).first
        return cacheDirectoryURL?.appendingPathComponent(
            origin.absoluteString.replacingOccurrences(of: "/", with: "_"))
    }
    
    @FileActor
    private func saveToLocal(origin: URL, data: Data) throws -> URL {
        guard let cacheUrl = cacheUrlOf(origin: origin) else {
            throw CacheSaveError.invalidPath(key: origin.absoluteString)
        }
        if FileManager.default.fileExists(atPath: cacheUrl.path) {
            try FileManager.default.removeItem(at: cacheUrl)
        }
        try data.write(to: cacheUrl)
        return cacheUrl
    }
}
