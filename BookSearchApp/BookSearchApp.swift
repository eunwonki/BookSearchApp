//
//  BookSearchApp.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/25.
//

import SwiftUI

// TODO: 페이징 처리 구현.
// TODO: 상세 페이지 구현.
// TODO: 메모리 캐시 구현. (이미지 파일을 중복으로 다운받지 않도록)

// TODO: 로딩 애니메이션 추가. (API Response 시간제한을 10초로 제한하는 코드를 넣어야 사용성을 해치지 않을 듯.)
// TODO: Preview를 위한 Sample Data 추가.

// 선택 추가 구현
// TODO: 책 제목, 저자, 출판사 등의 검색 결과를 따로 보여주는 것.

@main
struct BookSearchApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
