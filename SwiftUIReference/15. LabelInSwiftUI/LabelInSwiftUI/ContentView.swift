//
//  ContentView.swift
//  LabelInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            //sf심볼 사용
            Label("Pick a Color", systemImage: "paintpalette")
            //이미지 사용
            Label("tundsdev thumbnail", image: "logo-thumbnail")
            
            Link(destination: .init(string: "https://www.youtube.com/c/tundsdev")!) {
                //클로저에 뷰 정의
                
                //title, icon 사용
                Label {
                    Text("Subscribe to the channel")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .background(.red)
                        .clipShape(Capsule())
                } icon: {
                    Image("Logo")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                }
            }
            
            //labelStyle 활용
            Label("tundsdev thumbnail",
                  image: "logo-thumbnail")
                .labelStyle(CapsuleStyle())
            
            Label("tundsdev thumbnail",
                  image: "logo-thumbnail")
                .labelStyle(StrongCapsuleStyle(color: .blue))
            
            //extension - static 활용
            Label("tundsdev thumbnail",
                  image: "logo-thumbnail")
            .labelStyle(.capsule)
            
            Label("tundsdev thumbnail",
                  image: "logo-thumbnail")
            .labelStyle(.strongCapsule(color: .purple))
            
            
            //icon만 보이도록
            Label("tundsdev thumbnail",
                  image: "logo-thumbnail")
                .labelStyle(StrongCapsuleStyle(color: .blue))
                .labelStyle(.iconOnly)
            
            //icon 숨기기
            Label("tundsdev thumbnail",
                  image: "logo-thumbnail")
                .labelStyle(StrongCapsuleStyle(color: .blue))
                .labelStyle(.titleOnly) //.automatic: 기기에 따라 자동 적용
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
