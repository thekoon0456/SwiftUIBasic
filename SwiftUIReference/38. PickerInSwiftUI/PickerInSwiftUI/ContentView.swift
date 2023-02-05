//
//  ContentView.swift
//  PickerInSwiftUI
//
//  Created by Deokhun KIM on 2023/02/05.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedName: String = "" //피커에서 선택한 사람 변수
    
    let names: [String] = [
        "Tunde",
        "Billy",
        "Bob"
    ]
    
    
    var body: some View {
        ScrollView {
            VStack {
                
                VStack {
                    
                    Text("Selected Name \(selectedName)")
                    Picker("Choose a name",
                           selection: $selectedName) {
                        ForEach(names, id: \.self) { name in
                            Text(name)
                        }
                    }
                    .pickerStyle(.menu) //기본 스타일
                    
                    Picker("Choose a name",
                           selection: $selectedName) {
                        ForEach(names, id: \.self) { name in
                            Text(name)
                        }
                    }
                    .pickerStyle(.inline) //스크롤
                    
                    Picker("Choose a name",
                           selection: $selectedName) {
                        ForEach(names, id: \.self) { name in
                            Text(name)
                        }
                    }
                    .pickerStyle(.segmented) //세그먼트
                    
                    Picker("Choose a name",
                           selection: $selectedName) {
                        ForEach(names, id: \.self) { name in
                            Text(name)
                        }
                    }
                    .pickerStyle(.wheel) //휠
                    
                    Picker("Choose a name",
                           selection: $selectedName) {
                        ForEach(names, id: \.self) { name in
                            Text(name)
                        }
                    }
                    .pickerStyle(.automatic) //아이폰, 맥 등 화면에 따라 자동으로 설정
                    
                }
            }
        }
        .onAppear {
            //화면 나타날때 기본 선택값 넣을 수 있음
            self.selectedName = names.first ?? ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
