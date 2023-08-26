//
//  BookSearchApp.swift
//  BookSearchApp
//
//  Created by wonki on 2023/08/25.
//

import SwiftUI

// TODO: API 분석 및 서버로 부터 데이터 얻어오는 Service단 코드 작성.
// TODO: Cover Image를 얻어오는 방법 확인.

// TODO: MVVM Architecture로 요구 화면 완성. (이 단계는 생략하고 바로 TCA를 적용하는 것이 좋겠다.)

// TODO: 페이징 처리 구현.
// TODO: 메모리 캐시 구현. (이미지 파일을 중복으로 다운받지 않도록)

// TODO: 로딩 애니메이션 추가. (API Response 시간제한을 10초로 제한하는 코드를 넣어야 사용성을 해치지 않을 듯.)
// TODO: Preview를 위한 Sample Data 추가.

// 선택 추가 사항
// TODO: Architecture를 TCA로 구성 (학습해서 해야하므로 조금 시간이 걸릴듯.)
// TODO: UnitTest 작성. (Unit Test 작성 경험이 적어 여기까지는 힘들듯.)

// 선택 추가 구현
// TODO: 책 제목, 저자, 출판사 등의 검색 결과를 따로 보여주는 것.

@main
struct BookSearchApp: App {
    let configuration = Configuration(.real)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(configuration)
        }
    }
}
