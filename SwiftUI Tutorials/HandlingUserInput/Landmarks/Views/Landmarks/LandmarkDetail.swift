/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing the details for a landmark.
*/

import SwiftUI

struct LandmarkDetail: View {
    //modelData에 접근하기 위해 EnvironmentObject 추가
    @EnvironmentObject var modelData: ModelData
    var landmark: Landmark
    
    //몇번째 인덱스인지 알려주는 연산 프로퍼티
    //앞선 List에서 넘겨준 landmark가 전체 목록(modelData의 landmarks)에서 몇번째인지 알고자 하는 코드
    var landmarkIndex: Int {
        //modelData.landmarks에 있는것들 죽 확인해서 id가 같은 녀석이 몇 번째인지 확인해서 인덱스 꺼내옴
        modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
    }

    var body: some View {
        ScrollView {
            MapView(coordinate: landmark.locationCoordinate)
//                .ignoresSafeArea(edges: .top)
                .frame(height: 300)

            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.name)
                        .font(.title)
                    //버튼 추가
                    //modelData 객체와 landmarkIndex를 사용해 modelData.landmark의 isFavorite프로퍼티에 접근하고 값을 업데이트하도록
                    FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
                }

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
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    
    static let modelData = ModelData()
    
    static var previews: some View {
        LandmarkDetail(landmark: ModelData().landmarks[0]).environmentObject(modelData)
    }
}
