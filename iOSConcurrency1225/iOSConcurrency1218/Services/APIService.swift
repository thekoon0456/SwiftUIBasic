//
//  APIService.swift
//  iOSConcurrency1218
//
//  Created by Deokhun KIM on 2022/12/18.
//

import Foundation

struct APIService {
    let urlString: String //끝점을 나타내는 url문자열, 유저, 포스트 두개이므로 해당 끝점을 나타내는 다른 문자열을 전달해야 함.
    
    //iOS 15의 Task 나오기 전에 동시성 처리를 위해 ComplitionHandler 많이 사용했음
    //해당 네트워크 호출이 해당 데이터를 가져오는데 시간이 얼마나 걸릴지 몰라서 사용함.
    //코드는 기본적으로 동기식. 데이터를 받기 전에 다음 줄로 이동함
    //ComplitionHandler는 데이터가 검색될때 실행되도록 인수로 전달할 수 있는 클로저
    //JSON 가져오기
    func getJSON<T: Decodable>(dataDecodingStrategy:
                                JSONDecoder.DataDecodingStrategy = .deferredToData, //.deferredToData,함수 호출시 매개변수에 기본값 넣어줌
                                KeyDecodingStrategy:
                                JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                completion: @escaping (Result<T,APIError>) -> Void){
        //Result: 사용자 배열 또는 설정한 APIError 케이스로 결과 나오도록 //[User] 반환한 User 배열이 될 인수를 가짐.//<T:>Decodable 프로토콜 준수하는 타입만 사용하도록
        //서버에서 가져오므로 완료되기 전에 함수 자체가 범위를 벗어나는 경우가 있음. 완료핸들러가 이스케이프 되도록 지정
        guard //let url = URL(string: urlString)문자열과 같도록 guard, 아니면 종료
            let url = URL(string: urlString)
        else {
            completion(.failure(.invalidURL)) //Error의 .failure, 잘못된 URL일때
            return
        }
        //URLSession의 데이터 작업함수 dataTask호출(with에 url전달)
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard //응답확인, 상태코드가 200이고 nil이 아닌지 확인
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                completion(.failure(.invalidResponseStatus))
                return
            }
            
            guard //에러 있는지 확인
                error == nil
            else {
                completion(.failure(.dataTaskError))
                return
            }
            
            guard //데이터 있는지 확인
                let data = data
            else {
                completion(.failure(.corruptData))
                return
            }
            
            //데이터 얻었으니 디코딩 가능, do try catch
            let decoder = JSONDecoder()
            decoder.dataDecodingStrategy = dataDecodingStrategy
            decoder.keyDecodingStrategy = KeyDecodingStrategy
            do { //성공하면 디코딩된 데이터를 완료핸들러의 인수로 사용
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData)) //데이터 성공적으로 디코딩시 Enum타입의 Result인 .success(decodedData)로
            } catch { //에러있으면 프린트
                completion(.failure(.decodingError))
                print("Error")
            }
        }
        .resume() //처음에는 일시정지된 상태이므로 resume호출
        
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
