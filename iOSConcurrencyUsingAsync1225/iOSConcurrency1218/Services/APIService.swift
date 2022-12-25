//
//  APIService.swift
//  iOSConcurrency1218
//
//  Created by Deokhun KIM on 2022/12/18.
//

import Foundation

struct APIService {
    let urlString: String //끝점을 나타내는 url문자열, 유저, 포스트 두개이므로 해당 끝점을 나타내는 다른 문자열을 전달해야 함.
    
    //해당 네트워크 호출이 해당 데이터를 가져오는데 시간이 얼마나 걸릴지 몰라서 사용함.
    //코드는 기본적으로 동기식. 데이터를 받기 전에 다음 줄로 이동함
    //Async로 리팩토링
    //JSON 가져오기
    func getJSON<T: Decodable>(dataDecodingStrategy:
                               JSONDecoder.DataDecodingStrategy = .deferredToData, //.deferredToData,함수 호출시 매개변수에 기본값 넣어줌
                               KeyDecodingStrategy:
                               JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) async throws -> T {
        guard
            let url = URL(string: urlString)
        else {
            throw APIError.invalidURL
        }
        do {
            //반환값을 튜플로 할당 / 함수를 던질때 try
            let (data, response) = try await URLSession.shared.data(from: url)
            //URLSession의 데이터 작업함수 dataTask호출(with에 url전달)
            guard //응답확인, 상태코드가 200이고 nil이 아닌지 확인
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                throw APIError.invalidResponseStatus
            }
            //데이터 얻었으니 디코딩 가능, do try catch
            let decoder = JSONDecoder()
            decoder.dataDecodingStrategy = dataDecodingStrategy
            decoder.keyDecodingStrategy = KeyDecodingStrategy
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            } catch {
                throw APIError.decodingError(error.localizedDescription)
            }
        } catch {
            throw APIError.dataTaskError(error.localizedDescription)
        }
    }
}


//실패시 나타날 오류 열거형으로 만들어서 관리하기
enum APIError: Error, LocalizedError { //에러 다루니까 Error 프로토콜 채택, LocalizedError 프로토콜로 지역화된 오류 확인
    case invalidURL //잘못된 URL
    case invalidResponseStatus //응답상태 확인. 잘못된 응답상태일때
    case dataTaskError(String) //데이터 task 오류
    case corruptData //데이터가 손상되어있을때
    case decodingError(String) //데이터 얻은 후에 모델이 잘못 된 경우 디코딩 오류 발생
    
    var errorDescription: String? {
        switch self { //self switch하면 밑에 케이스 자동완성됨
        case .invalidURL:
            return NSLocalizedString("The endpoint URL is invalid", comment: "") //오류에 의미있는 문자열 입력하고, 주석을 빈 문자열로 남겨둠
        case .invalidResponseStatus:
            return NSLocalizedString("The APIO failed to issue a valid response", comment: "")
        case .dataTaskError(let string):
            return string
        case .corruptData:
            return NSLocalizedString("The data provided appears to be currupt", comment: "")
        case .decodingError(let string):
            return string
        }
    }
}
