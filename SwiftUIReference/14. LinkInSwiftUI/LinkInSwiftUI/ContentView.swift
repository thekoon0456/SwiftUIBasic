//
//  ContentView.swift
//  LinkInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //앱 외부 사파리로 이동
//        Link("Open WebSite", destination: .init(string:"https://www.youtube.com/c/tundsdev")!)
        
        Link(destination: .init(string: "https://www.youtube.com/c/tundsdev")!) {
            Image("Logo")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
