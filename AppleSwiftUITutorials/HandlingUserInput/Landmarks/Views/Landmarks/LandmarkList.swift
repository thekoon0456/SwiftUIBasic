/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a list of landmarks.
*/

import SwiftUI

struct LandmarkList: View {
    //ModelData 클래스 구독
    //modelData는 EnvironmentObject modifier가 부모에게 적용한 값을 자동으로 가져옴
    //여기서 수정해도 같은 modelData를 쓰므로 변경된 값이 연동됨
    @EnvironmentObject var modelData: ModelData
    
    
    /*
     @State는 시간이 지남에 따라 바뀔 수 있는 값 또는 값의 집합.
      뷰의 동작, 콘텐츠 또는 레이아웃에 영향을 미침
     이 뷰와 하위뷰에서만 사용하므로 private 사용
     */
    @State private var showFavoritesOnly = false
    
    //연산 프로퍼티 사용, showFavoritesOnly 값 true로 바꾸면 필터링된 값만 나옴
    var filteredLandmarks: [Landmark] {
        //landmarks를 modelData에 추가했으므로 접근 수정
        modelData.landmarks.filter { landmark in
            !showFavoritesOnly || landmark.isFavorite
        }
    }
    
    var body: some View {
        NavigationView {

            List { //ForEach사용해서 두 개 이상의 동적 뷰 구현
                //toggle뷰 만들어서 필터링 할 수 있도록 구현
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                //리스트 필터링 연동되게 filteredLandmarks로 수정
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .navigationTitle("Landmarks")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
            .environmentObject(ModelData())
    }
}
