//
//  CircleImage.swift
//  Landmarks
//
//  Created by Deokhun KIM on 2022/11/25.
//

import SwiftUI

struct CircleImage: View {
    //이미지 프로퍼티 추가
    var image: Image
    
    var body: some View {
        image //추가한 이미지 프로퍼티로 변경
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        //프로퍼티 추가했으니 프리뷰에서 볼 수 있도록 값 넣어줌
        CircleImage(image: Image("turtlerock"))
    }
}
