//
//  AnimeView.swift
//  PickerInSwiftUI
//
//  Created by Deokhun KIM on 2023/02/05.
//

import SwiftUI

enum Anime: CaseIterable, Identifiable, Hashable  { //CaseIterable 열거형 내에서 가능 한 모슨 사례의 배열을 자동으로 얻음
    case demonSlayer
    case attackOnTitan
    case bokuNoHero
    
    var id: Self { self } //각 case를 고유한 id로 사용
}
//enum 사용해 한정된 케이스의 안전한 type으로 사용
extension Anime {
    var title: String {
        switch self {
        case .demonSlayer:
            return "Demon Slayer"
        case .attackOnTitan:
            return "Attack On Titan"
        case .bokuNoHero:
            return "My Hero Academia"
        }
    }
}

struct AnimeView: View {
    
    @State private var selectedItem: Anime = Anime.allCases.first! //CaseIterable로 .allCases 사용해 모든 case 배열로 가져오기 / enum으로 case가 nil이 아니니 강제언래핑 사용
    
    var body: some View {
        VStack {
            Text("Selected Anime \(selectedItem.title)")

            Picker("Choose a name",
                   selection: $selectedItem) {
                ForEach(Anime.allCases) { item in
                    Text(item.title)
//                        .tag(item)
                }
            }
            .pickerStyle(.wheel)
        }
    }
}

struct AnimeView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeView()
    }
}
