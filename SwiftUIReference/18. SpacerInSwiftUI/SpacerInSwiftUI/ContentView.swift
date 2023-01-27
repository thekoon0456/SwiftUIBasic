//
//  ContentView.swift
//  SpacerInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            
            HStack {
                Spacer()
                Text("Name:")
                    .bold()
                Text("tundsdev")
            }
            .background(.red)
            
            HStack {
                Text("Name:")
                    .bold()
                Text("tundsdev")
                Spacer()
            }
            .background(.mint)
            
            HStack {
                Text("Name:")
                    .bold()
                Text("tundsdev")
            }
            //frame 사용해 spacer 효과 내기
            .frame(maxWidth: .infinity,
               alignment: .trailing)
            .background(.green)
            
            
            HStack {
                Text("Name:")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .background(.gray)
                Spacer()
                Text("tundsdev")
                    .frame(maxWidth: .infinity)
                    .background(.indigo)
            }
            .background(.yellow)
            
            HStack {
                Text("Name:")
                    .bold()
                    .background(.orange)
                Spacer(minLength: 50) //spacer의 최소길이 정해서 간격 조정 가능
                Text("tundsdev")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.pink)
            }
            .background(.teal)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
