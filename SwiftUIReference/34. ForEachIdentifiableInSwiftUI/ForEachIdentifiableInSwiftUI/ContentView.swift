//
//  ContentView.swift
//  ForEachIdentifiableInSwiftUI
//
//  Created by Deokhun KIM on 2023/02/05.
//

import SwiftUI

struct Person: Identifiable {
    let id = UUID() //고유한 값 수정 불가하도록 let으로 선언
    let firstName: String
    let lastName: String
}

struct ContentView: View {
    
    @State var people: [Person] = []
    
    var body: some View {
        VStack {
            ForEach(people) { person in
               PersonView(person: person)
            }
        }
        .onAppear {
            self.people = Person.data //화면 나오면 빈 people에 데이터 넣어줌
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Person {
    
    static var data: [Person] {
        [
            Person(firstName: "Billy", lastName: "Bob"),
            Person(firstName: "Billy", lastName: "May"),
            Person(firstName: "Jill", lastName: "Jan")
        ]
    }
    /*
     ForEach에서 id를 \.firstName으로 설정하면 Billy가 중복되므로 고유한 값이 아니게되고, Bliiy Bob이 두번 나오게 됨
     Identifiable 프로토콜 따르고, 고유한 값을 id로 주기
     */
}
