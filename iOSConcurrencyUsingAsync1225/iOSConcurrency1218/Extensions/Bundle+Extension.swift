//
//  Bundle+Extension.swift
//  iOSConcurrency1218
//
//  Created by Deokhun KIM on 2022/12/25.
//

import Foundation

//프리뷰 JSON 디코딩되도록 번들
extension Bundle {
    public func decode<T: Decodable>(_ type: T.Type,
                                     from file: String,
                                     dateDecodingStategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                     keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStategy
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        return decodedData
    }
}

