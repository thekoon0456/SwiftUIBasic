//
//  ContentView.swift
//  Safe Area In SwiftUI
//
//  Created by Deokhun KIM on 2023/02/05.
//

import SwiftUI

struct ContentView: View {
    
    private var gradientColors: [Color] {
        [
           .blue,
           .red
       ]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                
                backgroundVw
                
                //키보드 설정시 자연스럽게 하기 위해 ScrollView추가
                ScrollView {
                    Text("Content")
                        .bold()
                        .font(.largeTitle)
                    TextField("Some TextField", text: .constant(""))
                    ForEach(0...15, id: \.self) { item in
                        Text("\(item)")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                    }
                }
                .foregroundColor(.white)
                .textFieldStyle(.roundedBorder)
                .padding()
            }
            .navigationTitle("Home")
            .ignoresSafeArea(.keyboard, edges: .bottom) //키보드 안전영역 없애서 뷰 아래 안 잘리고 볼 수 있음
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private extension ContentView {
    
    var backgroundVw: some View {
        LinearGradient(colors: gradientColors,
                       startPoint: .top,
                       endPoint: .bottom)
            .ignoresSafeArea() //주석처리하면 위, 아래 safeArea 확인 가능
//            .ignoresSafeArea(.container, edges: [.bottom, .top])
               //.container: 컨테이너에 적용 / edges: 구체적으로 설정하는것도 가능
    }
}
