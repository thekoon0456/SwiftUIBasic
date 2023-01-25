//
//  ContentView.swift
//  ColorInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        ZStack {
//            Color("secondary")
//                .ignoresSafeArea()
//            Text("thekoon")
//                .foregroundColor(.accentColor)
//        }
        
        VStack {
            Color.red
                .frame(width: 100, height: 100)
            .opacity(0.5)
            Color("secondary")
                .frame(width: 100, height: 100)
            Color(red: 48 / 255, green: 60 / 255, blue: 255)
            //rgb최댓값인 255로 나눠야 적용됨
                .frame(width: 100, height: 100)
            Color(uiColor: .init(.mint))
                .frame(width: 100, height: 100)
            Text("Custom Color")
                .bold()
                .foregroundColor(Color("secondary"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
