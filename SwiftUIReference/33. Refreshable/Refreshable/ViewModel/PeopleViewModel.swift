//
//  PeopleViewModel.swift
//  PeopleViewModel
//
//  Created by Deokhun KIM on 2023/02/05.
//

import Foundation
import SwiftUI

//UI 업데이트 하기때문에 메인스레드에서 처리되도록
@MainActor
final class PeopleViewModel: ObservableObject {
    
    private let data: [Person] = [
        Person(name: "Billy Bob", gender: .male),
        Person(name: "Paschalis Ausma", gender: .male),
        Person(name: "Napoleon Donovan", gender: .male),
        Person(name: "Woodrow Ortega", gender: .male),
        Person(name: "Renee Guzman", gender: .male),
        Person(name: "Bradford Powell", gender: .male),
        Person(name: "Hattie James", gender: .male),
        Person(name: "Eloise Wolfe", gender: .male),

        Person(name: "Gunna Wido", gender: .genderNeutral),
        Person(name: "Citlalli Laokoon", gender: .genderNeutral),
        Person(name: "Antoniu Mina", gender: .genderNeutral),
        Person(name: "Karla Sharp", gender: .genderNeutral),
        Person(name: "Flora Elliott", gender: .genderNeutral),
        Person(name: "Ana Lawrence", gender: .genderNeutral),
        Person(name: "Angel Powers", gender: .genderNeutral),

        Person(name: "Anantha Rufus", gender: .female),
        Person(name: "Kephalos Akanksha", gender: .female),
        Person(name: "Kerry Mitchell", gender: .female),
        Person(name: "Geraldine Howard", gender: .female),
        Person(name: "Cecilia Ray", gender: .female),
        Person(name: "Johanna Castillo", gender: .female),
        Person(name: "Leah Perez", gender: .female),
        Person(name: "Lora Mccormick", gender: .female),
    ]
    
    @Published private(set) var people: [Person] = []
    @Published private(set) var isLoading = false
    
    //person 추가함수 
    func generatePerson() async {//비동기 사용
        isLoading = true //로딩 애니메이션 사용하기 위해
        Task {
            Thread.sleep(forTimeInterval: 1.5) //스레드 1.5초동안 sleep (네트워크처럼 연습)
            withAnimation { //추가 애니메이션
                people.append(data.randomElement()!)
                isLoading = false
            }
        }
    }
}
