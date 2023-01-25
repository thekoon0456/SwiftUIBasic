//
//  ModelData.swift
//  Landmarks
//
//  Created by Deokhun KIM on 2022/11/25.
//

import Foundation

//landmarkData.json을 load메서드로 로드해서 배열로 만드는 landmarks 배열 생성
var landmarks: [Landmark] = load("landmarkData.json")

//JSON 로드하는 메서드
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
