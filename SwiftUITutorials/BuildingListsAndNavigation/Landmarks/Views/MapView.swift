//
//  MapView.swift
//  Landmarks
//
//  Created by Deokhun KIM on 2022/11/25.
//

import SwiftUI
import MapKit //지도 그리는거는 기본 스유에 없고, 따로 불러야됨

struct MapView: View {
    //coordinate 변수 추가
    var coordinate: CLLocationCoordinate2D
    
    @State private var region: MKCoordinateRegion //MK:맵킷, 위치 조정
    = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    //center: 중앙 위치, span: 보여주는 면적
    
    var body: some View {
        //바인딩 값으로 리전
        Map(coordinateRegion: $region)
            .onAppear { //.onAppear 추가해서 맵 나타날때 setRegion 함수 이용해 좌표 수정해서 나오도록!
                setRegion(coordinate)
            }
    }
    
    //coordinate값에 따라 좌표값 업데이트하는 함수 추가
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 0.2, longitudinalMeters: 0.2)
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
    }
}
