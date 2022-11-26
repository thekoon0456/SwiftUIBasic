//
//  Landmark.swift
//  Landmarks
//
//  Created by Deokhun KIM on 2022/11/25.
//

import Foundation
import SwiftUI
import MapKit

//JSON파싱 위해 Codable프로토콜,  landmarkData의 속성들과 이름 같은 사용할 프로퍼티 만들기,
//Identifiable: id속성 필요. Identifiable 추가해 LandmarkList ForEach 돌릴때 id생략 가능
struct Landmark: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    
    //이미지 읽어 올 imageName 프로퍼티 추가, 사진을 읽어오기만 할것이므로 private로 접근, 수정 막고 읽기 전용 연산 프로퍼티 image로 만들어 사용!!
    private var imageName: String
    var image: Image {
        get {
            return Image(imageName)
        }
    }
    
    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        get{
            return CLLocationCoordinate2D(
                latitude: coordinates.latitude,
                longitude: coordinates.longitude
            )
        }
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
