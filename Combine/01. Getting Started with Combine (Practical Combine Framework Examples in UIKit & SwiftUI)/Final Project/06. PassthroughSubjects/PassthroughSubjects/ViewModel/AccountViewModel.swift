//
//  AccountViewModel.swift
//  PassthroughSubjects
//
//  Created by Deokhun KIM on 2023/02/05.
//

import Foundation
import Combine

//계정 뷰모델
class AccountViewModel {
    
    enum AccountStatus {
        case active
        case banned
    }
    
    //경고 3회
    private let warningLimit = 3
    
    let userAccountStatus = CurrentValueSubject<AccountStatus, Never>(.active)
    let warnings = CurrentValueSubject<Int, Never>(0) //경고 수 관찰, 기본값은 0

    var subscriptions = Set<AnyCancellable>()
    
    init() {
        createSubscriptions()
    }
    
    func increaseWarning() { //경고 증가함수
        warnings.value += 1
        print("Warning: \(warnings.value)")
    }
}

private extension AccountViewModel {
    
    func createSubscriptions() {
        
        warnings //CurrentValueSubject. 경고하면
            .filter({ [weak self] val in //값이 경고3회보다 같거나 클때 필터링
                guard let self = self else { return false }
                return val >= self.warningLimit
            })
            .sink { [weak self] _ in //사용자 계정상태 .banned로
                guard let self = self else { return }
                self.userAccountStatus.value = .banned
            }
            .store(in: &subscriptions)
    }
}
