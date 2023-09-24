import UIKit
import Combine

class AccountViewModel {
    
    //계정상태
    enum AccountState {
        case active
        case inactive
    }
    
    //계정
    struct Account {
        var username: String
        var status: AccountState
    }
    
    //user로 관찰.CurrentValueSubject이므로 값을 관찰함
    let user = CurrentValueSubject<Account, Never>(Account(username: "tundsdev",
                                                           status: .active))
    private var accountState: AccountState = .active {
        
        didSet {
            print("The user's account status changed: \(accountState)")
        }
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        
        user
            .map(\.status)
            .sink { [weak self] state in
                self?.accountState = state
            }
            .store(in: &subscriptions)
    }
    
    deinit {
        print("deinit released AccountViewModel") //클래스 더 필요없어서 초기화 해제될때 프린트
    }
}

var viewModel: AccountViewModel? = AccountViewModel() //초기화 해야하므로 옵셔널로

viewModel?.user.value.status = .inactive //계정상태 .inactive로 설정

viewModel = nil //뷰모델 deinit
