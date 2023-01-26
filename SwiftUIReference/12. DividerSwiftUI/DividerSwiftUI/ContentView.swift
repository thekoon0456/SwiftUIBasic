//
//  ContentView.swift
//  DividerSwiftUI
//
//  Created by Deokhun KIM on 2023/01/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            
            VStack {
                Text("1.(VStack) Example Below")
                Divider()
                    .frame(width: 100)
            }
            .padding()
            .background(.yellow)
            
            Group {
                Text("2.(Group) Example Below")
                Divider() //VStack 아니므로 divider도 mint색 적용됨
            }
            .background(.mint)
            
            HStack {
                Text("1.(HStack) Example to the right")
                Divider()
                    .background(.red)
                    .frame(height: 50) //HStack에서는 높이조절
                Image(systemName: "lock")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
