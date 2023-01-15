//
//  MoodDiaryStorage.swift
//  TextfieldTest
//
//  Created by Deokhun Kim on 2023/01/15.
//

import Foundation

//MARK: - 데이터를 앱 내부에 저장. DB사용 안하고 json으로 저장
final class MoodDiaryStorage {

    func persist(_ items: [MoodDiary]) {
        Storage.store(items, to: .documents, as: "diary_list.json")
    }
    
    func fetch() -> [MoodDiary] {
        let list = Storage.retrive("diary_list.json", from: .documents, as: [MoodDiary].self) ?? []
        return list
    }
}
