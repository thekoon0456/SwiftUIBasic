//
//  UserLIstViewModel.swift
//  iOSConcurrency1218
//
//  Created by Deokhun KIM on 2022/12/18.
//

import Foundation

class UserListViewModel: ObservableObject {
    @Published var users: [User] = [] //아직 JSON가져오기 전
    @Published var isLoading = false //로딩중에 progressView 사용위한 변수
    @Published var showAlert = false //경고 알림으로 트리거하는 변수
    @Published var errorMessage: String? //에러 있을때 나올 에러메세지
    
    //API서비스 사용하여 해당 함수를 호출할 수 있음
    func fetchUsers() {
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        //데이터를 가져오기 시작할때 토글됨
        isLoading.toggle()
        apiService.getJSON { (result: Result<[User], APIError>) in
            //defer 데이터가 검색되고 처리완료된 후 실행됨!
            defer {
                DispatchQueue.main.async {
                    self.isLoading.toggle() //로딩 완료됐으므로 다시 false로 토글
                }
            }
            switch result {
            case .success(let users): //users는 우리가 돌려받는 사용자를 나타냄
                //백그라운드 스레드에서 실행됨. UI를 업데이트하므로 디스패치큐 사용해 main스레드로 실행
                DispatchQueue.main.async {
                    self.users = users
                }
            case .failure(let error): //받을 수 있는 오류 나타냄
                //오류 있을때 알람 띄워주고 메세지 나오도록
                DispatchQueue.main.async {
                    self.showAlert = true
                    self.errorMessage = error.localizedDescription + "개발자에게 연락하세요"
                }
                
                print(error)
            }
        }
        
        //DispatchQueue.main.asyncAfter(deadline: .now() + 1)  1초 지연해 progressView 확인
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //            apiService.getJSON { (result: Result<[User], APIError>) in
        //                //
        //                defer {
        //                    DispatchQueue.main.async {
        //                        self.isLoading.toggle()
        //                    }
        //                }
        //                switch result {
        //                case .success(let users): //users는 우리가 돌려받는 사용자를 나타냄
        //                    //백그라운드 스레드에서 실행됨. UI를 업데이트하므로 디스패치큐 사용해 main스레드로 실행
        //                    DispatchQueue.main.async {
        //                        self.users = users
        //                    }
        //                case .failure(let error): //받을 수 있는 오류 나타냄
        //                    print(error)
        //                }
        //            }
        //        }
        
    }
}

//미리보기 false인
extension UserListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init() //사용자를 빈배열로 초기화
        if forPreview { //미리보기가 true일때
            self.users = User.mockUsers //user에 mockUsers 배열 넣어서 프리뷰에 보여줌
        }
    }
}
