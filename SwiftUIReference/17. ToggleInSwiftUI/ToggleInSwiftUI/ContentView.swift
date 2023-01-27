//
//  ContentView.swift
//  ToggleInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isSelected: Bool = false
    
    var body: some View {
        VStack {
            
            Group {
                Toggle("Turn me on?", isOn: $isSelected)
                Text(isSelected ? "I am turned on" : "I'm turned off")
                    .padding()
            }
            
            
            Group {
                Toggle("Turn me on?", isOn: $isSelected)
                    .labelsHidden() //레이블 숨김
                Text(isSelected ? "I am turned on" : "I'm turned off")
                    .padding()
            }
            
            Toggle(isOn: $isSelected) { //클로저로 Lable 사용

                Label(isSelected ? "Is On" : "Is Off",
                      systemImage: "lightbulb")
                    .symbolVariant(isSelected ? .fill : .none)
            }
            
            
            Toggle(isOn: $isSelected) {

                Label(isSelected ? "Is On" : "Is Off",
                      systemImage: "lightbulb")
                    .symbolVariant(isSelected ? .fill : .none)
            }
            .toggleStyle(.button) //토글 스타일 버튼으로

            //커스텀 토글 스타일 적용
            Toggle("", isOn: $isSelected)
                .labelsHidden()
                .toggleStyle(ToggleCheckboxStyle())
                .font(.title)
            
            //점표기법 사용
            Toggle("", isOn: $isSelected)
                .labelsHidden()
                .toggleStyle(.checklist)
                .font(.title)

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
