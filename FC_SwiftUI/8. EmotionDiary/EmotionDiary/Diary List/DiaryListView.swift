//
//  ContentView.swift
//  EmotionDiary
//
//  Created by Deokhun Kim on 2023/01/15.
//

import SwiftUI

struct DiaryListView: View {
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
    
    @StateObject var vm: DiaryListViewModel
    
    let layout: [GridItem] = Array(repeating: GridItem(.flexible()), count: 5)
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    //MARK: - 그리드 뷰
                    LazyVGrid(columns: layout) {
                        ForEach(vm.keys, id: \.self) { key in
                            //키 별로 섹션 만들어줌
                            Section {
                                let items = vm.dic[key] ?? []
                                let orderedItems = items.sorted { $0.date < $1.date }
                                ForEach(orderedItems) { item in
                                    MoodDiaryCell(diary: item)
                                        .frame(height: 50)
                                }
                            } header: {
                                Text(formattedSectionTitle(key))
                                    .font(.system(size: 30, weight: .black))
                            }
                            .frame(height: 60)
                            .padding()
                        }
                    }
                }
                .navigationTitle("Emotion Diary")
                
                HStack {
                    Button {
                        print("")
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                    }
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
                    .background(Color.pink)
                    .cornerRadius(40)

                }
            }
        }
    }
}

//날짜 포멧 변환
extension DiaryListView {
    //"2022-04" -> "April 2022" or "4월 2022"
    private func formattedSectionTitle(_ id: String) -> String {
        let dateComponents = id
            .components(separatedBy: "-")
            .compactMap{ Int($0) }
        guard let year = dateComponents.first, let month = dateComponents.last else {
            return id
        }
        
        
        let calendar = Calendar(identifier: .gregorian)
        let dateComponent = DateComponents(calendar: calendar, year: year, month: month)
        let date = dateComponent.date!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            DiaryListView(vm: DiaryListViewModel())
        }
    }
