//
//  ContentView.swift
//  BordersInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/25.

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
                .border(.red, width: 5) //테두리, 색상, 너비
                
            
            //자연스럽게 테두리 둥글게
            Text("Hello, world!")
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.blue, lineWidth: 4) //선으로, 색상, 너비
                )
            
            Circle()
                .strokeBorder( //도형에 추가
                    AngularGradient(gradient: Gradient(colors: [.red, .yellow, .red]),
                                    center: .center,
                                    endAngle: .degrees(360)),
                    lineWidth: 50
                )
                .padding()
            
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(AngularGradient(colors: [.red, .orange, .red],
                                              center: .center),
                              lineWidth: 40
                )
                .padding()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
