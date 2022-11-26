//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by Deokhun KIM on 2022/11/25.
//

import SwiftUI

struct LandmarkDetail: View {
    //Landmark(struct) 타입 landmark 이용해 값에 접근
    var landmark: Landmark
    
    var body: some View {
        ScrollView { //스크롤할수있도록 VStack을 ScrollView로 변경, spacer 삭제
            MapView(coordinate: landmark.locationCoordinate)
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            
            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text(landmark.name)
                    .font(.title)
                
                HStack {
                    Text(landmark.park)
                    Spacer()
                    Text(landmark.state)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                Text("About \(landmark.name)")
                    .font(.title2)
                Text(landmark.description)
            }
            .padding()
        }
        //이전 뷰에서 navigationLink걸어서 되는건가??
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            LandmarkDetail(landmark: landmarks[3])
        }
        // 프리뷰에 NavigationStack 넣어주면 리스트 이동 안해도 타이틀 볼 수 있다!
    }
}
