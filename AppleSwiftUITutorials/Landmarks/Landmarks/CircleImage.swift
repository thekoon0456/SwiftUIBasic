//
//  CircleImage.swift
//  Landmarks
//
//  Created by Deokhun KIM on 2022/11/25.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("turtlerock")
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }//overlay: 겹치기
             //stroke 동그라미 가에 흰색 줄 추가
            .shadow(radius: 7)
             //은은하게 그림자 넣기
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
