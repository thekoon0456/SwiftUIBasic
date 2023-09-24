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
}

class GithubService {
    func fetchUser(userId: String?) -> AnyPublisher<UserProfile, Error> {
        guard let id = userId, !id.isEmpty,
              let url = URL(string: "https://api.github.com/users/\(id)")
        else {
            print("DEBUG: NetworkError: \(NetworkError.invalidRequest)")
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
            .receive(on: DispatchQueue.main)
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
