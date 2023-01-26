//
//  LoginViewModel.swift
//  StateObjectInSwiftUI
//
//  Created by Tunde on 16/01/2022.
//

import Foundation

struct User: Equatable { //값이 동일한지 비교할 수 있는 프로토콜, == 사용 가능
    var username: String = ""
    var password: String = ""
    
    //로그아웃 했을때 바인딩된 값 초기화. 밸류타입 속성 수정하려면 mutating 사용
    mutating func reset() {
        username = ""
        password = ""
    }
}

final class LoginViewModel: ObservableObject {

    //프로퍼티 상태 변경 - 불리언 사용헤서 참, 거짓만 쓰기보다는 열거형 사용하는 것 추천. 상태를 기반으로 변경해야할때 비교해서 볼 수 있으므로 enum편리
    enum CurrentState {
        case loading
        case notLoggedIn
        case loggedIn
    }
    
    @Published var user: User = .init()
    @Published var state: CurrentState = .notLoggedIn //로그인 상태

    func login() {
        
        //유저네임, 비밀번호 입력했는지 확인
        guard !user.username.isEmpty && !user.password.isEmpty else {
            return
        }
        
        state = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
       
            self?.state = .loggedIn
        }
    }
    
    func logout() {
        self.state = .notLoggedIn
        user.reset() //초기화 함수 추가
    }
}
