//
//  TabViewInSwiftUIApp.swift
//  TabViewInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/27.
//

import SwiftUI

//화면 전환하는 enum
enum Screen {
    case one
    case two
}
//ObservableObject 생성
final class TabRouter: ObservableObject {
    
    @Published var screen: Screen = .one
    
    func change(to screen: Screen) {
        self.screen = screen
    }
}
//아이폰 앱인경우 루트 앱에 탭뷰 설정
@main
struct TabViewInSwiftUIApp: App {
    
    @StateObject private var router = TabRouter()
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $router.screen) {
                ScreenOne()
                    .badge(10) //화면에 빨간색 알람 띄워줌!
                    .tag(Screen.one) //화면 고유 id - 스크린 변경
                    .environmentObject(router)
                    .tabItem { //tabItem - Lable 추가
                        Label("Screen 1", systemImage: "calendar")
                    }
                ScreenTwo()
                    .tag(Screen.two)
                    .environmentObject(router)
                    .tabItem {
                        Label("Screen 2", systemImage: "house")
                    }
            }
        }
    }
}
