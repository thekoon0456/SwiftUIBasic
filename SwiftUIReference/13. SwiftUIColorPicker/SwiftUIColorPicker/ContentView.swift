//
//  ContentView.swift
//  SwiftUIColorPicker
//
//  Created by Deokhun KIM on 2023/01/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var color: Color = .blue //컬러피커 동그라미 내부에 색 나옴, .clear하면 투명상태
    
    var body: some View {
        VStack {
            Image("tundsdev")
                .resizable()
                .frame(width: 200, height: 200)
                .background(color)
                .clipShape(Circle())
            
            ColorPicker(selection: $color,
                        supportsOpacity: false) { //supportsOpacity: false - opacity 변경기능 비활성화
                //레이블 사용
                Label("Color Pallete", systemImage: "paintpalette")
                    .symbolVariant(.fill)
                    .padding(.leading, 8)
            }
//             .labelsHidden() //컬러피커 레이블 숨기고 피커를 중앙으로 이동 가능
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
