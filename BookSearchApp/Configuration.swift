//
//  Configuration.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/25.
//

import Foundation
import Moya

class Configuration: ObservableObject {
    enum DeviceType {
        case real
        case preview
    }
    
    let provider: MoyaProvider<OpenAPI>
    
    init(_ type: DeviceType) {
        switch type {
        case .preview:
            provider = MoyaProvider<OpenAPI>(
                stubClosure: MoyaProvider.delayedStub(0.5))
        case .real:
            provider = MoyaProvider<OpenAPI>()
        }
    }
}
