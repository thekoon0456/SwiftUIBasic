//
//  Service.swift
//  SwiftUI+Combine
//
//  Created by Deokhun KIM on 2023/09/23.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case responseError(statusCode: Int)
    case jsonDecodingError(error: Error)
    
    var errorDescription: String {
        switch self {
        case .invalidRequest:
            "유효하지 않은 요청입니다"
        case .invalidResponse:
            "유효하지 않은 응답입니다"
        case .responseError(let statusCode):
            "응답 에러코드: \(statusCode)"
        case .jsonDecodingError(let error):
            "JSON 파싱 에러입니다. \(error)"
        }
    }
}

class GithubService {
    func fetchUser(userId: String?) -> AnyPublisher<UserProfile, Error> {
        guard let id = userId, !id.isEmpty,
              let url = URL(string: "https://api.github.com/users/\(id)")
        else {
            print("DEBUG: NetworkError: \(NetworkError.invalidRequest.errorDescription)")
            return Fail(error: NetworkError.invalidRequest)
            .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode)
                else {
                    let response = result.response as? HTTPURLResponse
                    let statusCode = response?.statusCode ?? -1
                    throw NetworkError.responseError(statusCode: statusCode)
                }
                
                return result.data
            }
            .decode(type: UserProfile.self, decoder: JSONDecoder())
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    return NetworkError.jsonDecodingError(error: decodingError)
                } else {
                    return error
                }
            }
            .subscribe(on: DispatchQueue.global()) //데이터 받아오는 스레드
            .eraseToAnyPublisher()
    }
}

//class GithubService {
//    func fetchUser(userId: String?) -> AnyPublisher<UserProfile, Error> {
//        guard let id = userId, !id.isEmpty,
//              let url = URL(string: "https://api.github.com/users/\(id)")
//        else {
//            print("DEBUG: NetworkError: \(NetworkError.invalidRequest)")
//            return Fail(error: NetworkError.invalidRequest)
//            .eraseToAnyPublisher()
//        }
//        
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: UserProfile.self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
//}
