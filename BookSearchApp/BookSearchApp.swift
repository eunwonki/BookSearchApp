//
//  BookSearchApp.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/25.
//

import SwiftUI

// 선택 추가 구현 (시간상 이번 과제에서 수행하기는 힘들 듯)
// TODO: 검색화면에서 페이징이 씹히는 경우가 있는데 확인해 볼 것. (로딩 상태가 바뀌기 전에 요청해서 그런거 같은데 나중에 해결하자.)
// TODO: 책 제목, 저자, 출판사 등의 검색 결과를 따로 보여주는 것.
// TODO: TCA-Coordinator 적용. (https://green1229.tistory.com/272)

@main
struct BookSearchApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
