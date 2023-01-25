//
//  ContentView.swift
//  GradientsInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            //기본 그라데이션, 세로방향
            LinearGradient(gradient: Gradient(colors: [.white, .blue, .black]),
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            
            //기본 그라데이션, 가로방향
            LinearGradient(gradient: Gradient(colors: [.white, .mint]),
                           startPoint: .leading,
                           endPoint: .trailing)
            .ignoresSafeArea()
            
            //영역 지정
            LinearGradient(stops: ([.init(color: .black,
                                          location: 0.2), //위에서부터 화면의 20퍼센트 차지
                                    .init(color: .mint,
                                          location: 0.5)]), //아래에서부터 화면의 50퍼센트 차지, 중간에 자연스레 그라데이션 생김
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            
            //원형 그라데이션, 화면 중앙에서 바깥 방향으로 적용됨
            RadialGradient(colors: [.black, .mint, .purple, .blue],
                           center: .top, //화면 위에서 반원모양으로 시작됨
                           startRadius: 50, //시작 원 반경
                           endRadius: 100) //끝 원 반경
            .frame(width: 200, height: 200)
            
            //각도 그라데이션
            AngularGradient(colors: [.red, .yellow, .green, .blue, .purple],
                            center: .center,
                            angle: .degrees(180)) //시작각도, 3시방향이 0도, 180도니까 9시 방향에서 시작함
            .frame(width: 200, height: 200)
            
            Text("I'm a gradient")
                .bold()
                .foregroundColor(.white)
                .background(
                    //AngularGradient: ShapeStyle 프로토콜 따르므로 background 안에 넣을 수 있음
                    AngularGradient(colors: [.red, .yellow, .green, .blue, .purple],
                                    center: .center,
                                    angle: .degrees(180))
                    .frame(width: 200, height: 200)
                )
            
            AngularGradient(colors: [.red, .yellow, .green, .blue, .purple],
                            center: .center,
                            angle: .degrees(180))
            //mask: 텍스트가 그라데이션으로 채워짐.
            .mask(
                Text("I'm a gradient")
                    .bold()
                    .font(.largeTitle)
            )
            
        }
                    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
