import UIKit
import Combine

//새 값을 기본 값에 할당

final class LevelsManager {
    //사용자의 level 가지고 있음
    var level: Int = 0 {
        didSet { //didSet 이용해 level이 변화할때 print
            if let message = level.message {
                print(message)
            }
        }
    }
}

extension Int {
    
    var message: String? {
        
        switch self {
        case 25:
            return "You've achieved bronze status"
        case 50:
            return "You've achieved silver status"
        case 100:
            return "You've achieved gold status"
        default:
            return nil
        }
    }
}

let lvlManager = LevelsManager()
let levelsRange = (0...100)
let cancellable = levelsRange
    .publisher //levelsRange를 publisher로 전환
    .assign(to: \.level, on: lvlManager) //\.:keypath class의 level에 저장하고 싶은지 확인
