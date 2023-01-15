//
//  EmotionDiaryApp.swift
//  EmotionDiary
//
//  Created by Deokhun Kim on 2023/01/15.
//

import SwiftUI

@main
struct EmotionDiaryApp: App {
    var body: some Scene {
        WindowGroup {
            let vm = DiaryListViewModel()
            DiaryListView(vm: vm)
        }
    }
}
