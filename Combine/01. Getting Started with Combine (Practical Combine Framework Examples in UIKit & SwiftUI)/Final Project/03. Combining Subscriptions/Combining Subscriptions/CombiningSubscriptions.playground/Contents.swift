import UIKit
import Combine

/*
 * Combine two publishers and validate any nil values remove it
 *
 */
//MARK: - 두 publisher 결합, 값을 변겅하는 방법

let meals: Publishers.Sequence<[String?], Never> = ["🍔", "🌭", "🍕", "🥓"].publisher
let people: Publishers.Sequence<[String?], Never> = ["Tunde", "Bob", "Toyo", "Jack"].publisher
//[String?] 타입인 Publisher
//Never: 오류가 없고 절대 실패하지 않음
//.publisher: [String?] 배열을 publisher로 전환

//Person 데이터 에러처리 enum
enum PersonError: Error {
    case emptyData  //data가 nil일때 error처리
}

extension PersonError {
    
    public var errorDescription: String {
        switch self {
        case .emptyData: //데이터가 nil일때 아래 메세지 출력됨
            return "There is a nil value somewhere"
        }
    }
}

//데이터 유효성 검사 함수
//guard let 으로 person, meal 확인하고 둘다 값이 정상이면 아래 문자 반환
func validate(person: String?, meal: String?) throws -> String {
    guard let person = person,
          let meal = meal else {
        throw PersonError.emptyData
    }
    
    return "\(person) enjoys \(meal)"
}

//MARK: - people publisher을 확보하고, meals publisher와 결합
let subscription = people
    .zip(meals) //people과 meals와 결합
    .tryMap({ try validate(person: $0, meal: $1) }) //validate: 유효성 검사.
//     .filter 대신 tryMap 사용: 값 변경 시도 - 실패하면 알려주고 정상이면 계속 진행됨
//    .filter { $0 != nil && $1 != nil } //filter 사용시
    .sink { completion in //완료되었을때 case에 맞게 프린트할 수 있도록
        
        switch completion {
        case .finished: //성공적으로 완료되었을때 출력
            print("Finished")
        case .failure(let error as PersonError):
            print("Failed: \(error.errorDescription)")
        case .failure(let error):
            print("Failed: \(error.localizedDescription)")
        }
        
    } receiveValue: { message in //meals publisher로 부터 값 받을때 출력
        print(message)
    }
