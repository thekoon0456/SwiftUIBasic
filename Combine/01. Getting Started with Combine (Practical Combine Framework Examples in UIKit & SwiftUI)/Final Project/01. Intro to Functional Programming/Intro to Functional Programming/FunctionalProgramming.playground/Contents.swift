import UIKit

var items: [String?] = ["Femi", "Pete", "Bryan", nil]

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


let combined = items
            .compactMap { $0 } //nil 제거
            .map { $0 } //string 배열 생성
            .joined(separator: ", ") //하나의 string으로 합침


print(combined)
