//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Deokhun KIM on 2022/11/25.
//

import SwiftUI

struct LandmarkList: View {
    var body: some View {
//        List {
//            //LandmarkRow 뷰 가져옴, 프로퍼티는 JSON 넣은 배열인 landmarks[0], 수동으로 하나하나 넣어야 함
//            LandmarkRow(landmark: landmarks[0])
//            LandmarkRow(landmark: landmarks[1])
//        }
        //landmarks 배열 자동으로 넣어주기, Identifiable 프로토콜 따르고 내부에 id 프로퍼티 있으면 id:\.id 생략 가능
        NavigationStack {
            List(landmarks) { landmark in
                NavigationLink {
                    LandmarkDetail(landmark: landmark)
                } label: {
                    //각 줄,LandmarkRow 뷰 띄우기
                    LandmarkRow(landmark: landmark)
                }
            }
            .navigationTitle("Landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        //ForEach는 List와 같은 방식으로 작동, 데이터 간단하면 id값 \.self로 사용
        ForEach(["iPhone SE (3nd generation)", "iPhone 14"], id: \.self) { deviceName in
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName) //프리뷰 디바이스별로 이름 표시
        }
    }
}
