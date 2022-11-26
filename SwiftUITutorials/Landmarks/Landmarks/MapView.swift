//
//  MapView.swift
//  Landmarks
//
//  Created by Deokhun KIM on 2022/11/25.
//

import SwiftUI
import MapKit //지도 사용 위해 import

struct MapView: View {
    @State private var region: MKCoordinateRegion //MK:맵킷, 위치 조정
    = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    //center: 중앙 위치, span: 보여주는 면적
    var body: some View {
        //바인딩 값으로 리전
        Map(coordinateRegion: $region)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
