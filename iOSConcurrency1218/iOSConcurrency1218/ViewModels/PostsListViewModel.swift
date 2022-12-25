//
//  PostsListViewModel.swift
//  iOSConcurrency1218
//
//  Created by Deokhun KIM on 2022/12/25.
//

import Foundation

class PostsListViewModel: ObservableObject {
    //게시물 객체 배열
    @Published var posts: [Post] = []
    @Published var isLoading = false //로딩중에 progressView 사용위한 변수
    @Published var showAlert = false //경고 알림으로 트리거하는 변수
    @Published var errorMessage: String? //에러 있을때 나올 에러메세지
    //유저아이디 옵셔널로 닐값 줌
    var userId: Int?
    
    func fetchPost() {
        if let userId = userId {
            let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
            isLoading.toggle()
            apiService.getJSON { (result: Result<[Post], APIError>) in
                defer {
                    DispatchQueue.main.async {
                        self.isLoading.toggle()
                    }
                }
                switch result {
                case .success(let posts): //users는 우리가 돌려받는 사용자를 나타냄
                    //백그라운드 스레드에서 실행됨. UI를 업데이트하므로 디스패치큐 사용해 main스레드로 실행
                    DispatchQueue.main.async {
                        self.posts = posts
                    }
                case .failure(let error): //받을 수 있는 오류 나타냄
                    DispatchQueue.main.async {
                        self.showAlert = true
                        self.errorMessage = error.localizedDescription + "개발자에게 연락하세요"
                    }
                }
            }
        }
    }
}

//미리보기 false인
extension PostsListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init() //사용자를 빈배열로 초기화
        if forPreview { //미리보기가 true일때
            self.posts = Post.mockPosts //user에 mockUsers 배열 넣어서 프리뷰에 보여줌
        }
    }
}
