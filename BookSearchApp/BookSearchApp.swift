//
//  BookSearchApp.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/25.
//

import SwiftUI

// TODO: API 분석 및 서버로 부터 데이터 얻어오는 Service단 코드 작성.
// TODO: MVVM Architecture로 요구 화면 완성.
// TODO: 메모리 캐시 구현.
// TODO: 로딩 애니메이션 추가. (API Response 시간제한을 10초로 제한)
// TODO: Preview를 위한 Sample Data 추가.

// 선택 추가 사항
// TODO: Architecture를 TCA로 구성 (학습해서 해야하므로 조금 시간이 걸릴듯.)
// TODO: UnitTest 작성. (Unit Test 작성 경험이 적어 여기까지는 힘들듯.)

@main
struct BookSearchApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
