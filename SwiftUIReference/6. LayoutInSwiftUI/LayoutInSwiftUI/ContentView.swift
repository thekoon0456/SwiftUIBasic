//
//  ContentView.swift
//  LayoutInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
                    Text("Hello, world!")
                        .frame(width: 200, height: 250, alignment: .topLeading)
                        .background(.mint)
            
                    Text("Hello, world!")
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity,
                               alignment: .topLeading)
                        .background(.mint)
                        .clipped()
            
                    VStack {
                        Text("Hey i'm some text")
                            .background(.blue)
                        Text("Hey i'm some text")
                            .background(.yellow)
                        Text("Hey i'm some text")
                            .background(.green)
                        Text("Hey i'm some text")
                            .background(.red)
                        Text("Hey i'm some text")
                            .background(.purple)
                        Text("Hey i'm some text")
                            .background(.brown)
                    }
                    .frame(idealWidth: 150,
                           minHeight: 100, //최소 100이상, 늘어나면 계속 늘어남
                           alignment: .topLeading)
                    .background(.mint)
                    .clipped() //safeArea 안으로 들어오도록 자름
            
            Image("Logo")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(alignment: .bottomTrailing) {
                    Text("New Video")
                        .foregroundColor(.white)
                        .bold()
                        .font(.callout)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(.red)
                        .clipShape(Capsule())
                        .offset(x: 25, y: 10) //위치 세부 지정
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
