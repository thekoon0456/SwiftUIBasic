//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by Deokhun KIM on 2022/11/25.
//
//Target: 한 앱으로 아이폰, 아이패드 등 앱 다양하게 만들 수 있기 때문에 타겟 설정

import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark
    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(landmark.name)
            Spacer()
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        //초기화값으로 ModelData.swift에서 만든 landmarks의 첫 배열 만들어줌
        Group {
            LandmarkRow(landmark: landmarks[0])
            LandmarkRow(landmark: landmarks[1])
        }
        .previewLayout(.fixed(width: 300, height: 70)) //프리뷰 레이아웃 고정, 한 줄만 볼 수 있도록
    }
}

