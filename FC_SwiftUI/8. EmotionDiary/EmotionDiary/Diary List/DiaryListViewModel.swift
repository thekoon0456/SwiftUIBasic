//
//  DiaryListViewModel.swift
//  EmotionDiary
//
//  Created by Deokhun KIM on 2023/01/15.
//

import Foundation

final class DiaryListViewModel: ObservableObject {
    /*
     Sequence -> Dictionary
     AS-IS
     [MoodDiary]
     ->
     TO-BE
     [String: [MoodDiary]]
     "2022-04" : [MoodDiary]
     "2022-05" : [MoodDiary]
     "2022-06" : [MoodDiary]
     "2022-07" : [MoodDiary]
     */
    
    @Published var list: [MoodDiary] = MoodDiary.list
    @Published var dic: [String: [MoodDiary]] = [:]
    
    init() { //sqquence그루핑, 기준은 날짜별로
        self.dic = Dictionary(grouping: self.list, by: { $0.monthlyIdentifier }) //monthlyIdentifier 함수로 날짜 나누고 기준으로 삼음
    }
    
    //딕셔너리 키 별로
    var keys: [String] {
        //2022-4, 5, 6, 7 로 키들 정렬
        dic.keys.sorted { $0 < $1 }
    }
}
