import UIKit

//MARK: -  Functional Programming
var items: [String?] = ["Femi", "Pete", "Bryan", nil]

//1. nil없애는 함수 직접 작정
func filterNils(in items: [String?]) -> [String] {
    var myItems = [String]()
    for item in items {
        if let item = item {
            myItems.append(item)
        }
    }
    return myItems
}

print(filterNils(in: items))

//2. 기존 함수 사용
let combined = items
            .compactMap { $0 } //객체배열 반복, nil값이 있다면 nil 제거
//chain으로 함수 더 연결해 변환
            .map { $0 } //객체배열 생성. string 배열 생성
            .joined(separator: ",") //하나의 string으로 합침


print(combined)
