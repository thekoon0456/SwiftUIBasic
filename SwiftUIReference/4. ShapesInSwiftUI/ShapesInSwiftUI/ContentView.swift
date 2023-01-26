//
//  ContentView.swift
//  ShapesInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Capsule(style: .circular) //원형에 가까움
                .fill(.blue) //파란색을 채우기
            Capsule(style: .continuous) //사각형에 가까움
            Circle() //원
            Ellipse() //타원
            Rectangle()
            RoundedRectangle(cornerRadius: 8) //cornerRadius 지정 필수.
                .fill(.blue)
            Image("Logo")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 12)) //도형 모형 지정 가능
                .clipShape(Circle())  //도형 모형 지정 가능, 원으로
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
