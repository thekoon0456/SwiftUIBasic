//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by Deokhun KIM on 2022/11/25.
//

import SwiftUI

/*
 SwiftUI 앱 수명 주기를 사용하는 앱은 앱 프로토콜을 준수하는 구조를 가지고 있습니다. 구조의 본문 속성은 하나 이상의 장면을 반환하며, 이는 디스플레이를 위한 콘텐츠를 제공합니다. @Main 속성은 앱의 진입점을 식별합니다.
 */

@main
struct LandmarksApp: App {
    var body: some Scene { //
        //macOS, iPadOS에서 WindowGroup사용! 경우에 따라 여러개 윈도우 구성 가능
        WindowGroup {
            ContentView()
        }
    }
}
