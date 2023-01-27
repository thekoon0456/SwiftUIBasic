//
//  ContentView.swift
//  DatePickerInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/27.
//

import SwiftUI

struct ContentView: View {
    //현재 날짜
    @State private var selectedDate: Date = .now
    
    //생일, 연령 선택할수 있는 picker 만들기
    private let dateRange: ClosedRange<Date> = {
        
        let calendar = Calendar.current
        //연령별로. 오늘 날짜부터 18세 ~ 120세 사이
        let minAgeDate = calendar.date(byAdding: .year, value: -120, to: .now)
        let maxAgeDate = calendar.date(byAdding: .year, value: -18, to: .now)
        
        return minAgeDate!...maxAgeDate! //범위내에서 사용, 선택사항이므로 옵셔널? 강제언래핑 하기
    }()
    
    var body: some View {
        ScrollView {
            VStack {
                
                DatePicker("",
                           selection: $selectedDate,
                           in: dateRange,
                           displayedComponents: [.date]
                )
                .labelsHidden()
                .datePickerStyle(.graphical)
                
                //현재 날짜, style로 날짜, 시간 등 표현 가능
                Text(selectedDate, style: .date)
                
                //제목, selection, displayedComponents: 날짜, 시간 선택 가능
                DatePicker(
                    "Start Date",
                    selection: $selectedDate,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .background(.yellow)
                
                //레벨 숨김 가능, 중앙정렬
                DatePicker(
                    "Start Date",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .labelsHidden()
                
                //클로저로 lable 설정 가능
                DatePicker(
                    selection: $selectedDate,
                    displayedComponents: [.date, .hourAndMinute]
                ) {
                    Label("Select a date", systemImage: "calender")
                }
                
                //
                DatePicker(
                    selection: $selectedDate,
                    in: dateRange,
                    displayedComponents: [.date]
                ) {
                    Text("Over 18's only")
                }
                
                //wheel 스타일로 설정
                DatePicker("",
                           selection: $selectedDate,
                           in: dateRange,
                           displayedComponents: [.date]
                )
                .labelsHidden()
                .datePickerStyle(.wheel)
                
                //graphical 스타일 적용. 화면에서 보면서 선택할 수 있음
                DatePicker("",
                           selection: $selectedDate,
                           in: dateRange,
                           displayedComponents: [.date]
                )
                .labelsHidden()
                .datePickerStyle(.graphical)
                .background(.mint)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
