//
//  OpenAPI+TCA.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/26.
//

import Foundation
import Moya
import ComposableArchitecture

class WebServiceConfiguration {
    
    /// 출처: https://phillip5094.tistory.com/151
    static let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
        do {
            var request = try endpoint.urlRequest()
            request.timeoutInterval = 10
            done(.success(request))
        } catch {
            done(.failure(MoyaError.underlying(error, nil)))
        }
    }
}

class Providers {
    enum DeviceType {
        case real
        case preview
    }
    
    let open: MoyaProvider<OpenAPI>
    
    init(_ type: DeviceType) {
        switch type {
        case .preview:
            open = MoyaProvider<OpenAPI>(
                stubClosure: MoyaProvider.delayedStub(0.5))
        case .real:
            open = MoyaProvider<OpenAPI>(
                requestClosure: WebServiceConfiguration.requestClosure)
        }
    }
}

extension Providers: DependencyKey {
    static var liveValue: Providers {
        return Providers(.real)
    }
}

extension DependencyValues {
  var providers: Providers {
    get { self[Providers.self] }
    set { self[Providers.self] = newValue }
  }
}
