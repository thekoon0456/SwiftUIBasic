//
//  ContentView.swift
//  BackgroundAndOverlayInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/27.
//

import SwiftUI

//background 와 overlay 의 차이점.
struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                //기본
                Text("5")
                    .font(.footnote.weight(.bold))
                    .padding()
                    .background {
                        Image(systemName: "star")
                            .symbolVariant(.fill)
                            .foregroundColor(.white)
                            .font(.system(size: 32))
                            .offset(y: -2) //background 위치 조정 가능
                    }
                    .background(.yellow)
                
                //background 안에 여러 뷰들이 올 수 있음
                Text("5")
                    .font(.footnote.weight(.bold))
                    .padding()
                    .background {
                        
                        Circle()
                            .fill(.yellow.opacity(0.3))
                        
                        Image(systemName: "star")
                            .symbolVariant(.fill)
                            .foregroundColor(.yellow)
                            .font(.system(size: 32))
                            .offset(y: -2)
                    }
                
                //background에서 처음 쓴 뷰가 젤 밑으로 감. 마지막 코드가 젤 위로. 코드 순서에 따라 달라짐
                Text("5")
                    .font(.footnote.weight(.bold))
                    .padding()
                    .background {
                        
                        Image(systemName: "star")
                            .symbolVariant(.fill)
                            .foregroundColor(.yellow)
                            .font(.system(size: 32))
                            .offset(y: -2)
                        
                        Circle()
                            .fill(.mint)
                    }
                
                //alignment 수정자 사용가능. 별이 뷰 가장 위로 올라감
                Text("5")
                    .font(.footnote.weight(.bold))
                    .padding()
                    .background(alignment: .top) {
                        
                        Image(systemName: "star")
                            .symbolVariant(.fill)
                            .foregroundColor(.yellow)
                            .font(.system(size: 32))
                            .offset(y: -2)

                    }
                //MARK: - background와 overlay의 차이점
                //유일한 차이점은 background: 뒤쪽, overlay는 뷰가 앞쪽으로 이동
                
                //overlay가 가장 위로 올라옴. alignment 사용해 위치를 .bottom으로 내림
                Image("tundsdev")
                    .resizable()
                    .frame(width: 100,
                           height: 100)
                    .background(
                        Circle()
                            .fill(.blue)
                    )
                    .overlay(alignment: .bottom) {
                        Text("Subscribe")
                            .font(.footnote.weight(.bold))
                            .foregroundColor(.white)
                            .padding(4)
                            .background(
                                Capsule()
                                    .fill(.red)
                            )
                    }
                
                //overlay안에서 background 활용
                Image("tundsdev")
                    .resizable()
                    .frame(width: 100,
                           height: 100)
                    .background(
                        Circle()
                            .fill(.blue)
                    )
                    .overlay(alignment: .bottom) {
                        Text("Subscribe")
                            .font(.footnote.weight(.bold))
                            .foregroundColor(.white)
                            .padding(4)
                            .background(.ultraThinMaterial,
                                        in: Capsule())
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
