//
//  CommentsViewModel.swift
//  PassthroughSubjects
//
//  Created by Deokhun KIM on 2023/02/05.
//

import Foundation
import Combine

//MARK: - 사람들이 작성한 댓글 뷰모델
final class CommentsViewModel { //final: 이 클래스의 상속을 원치 않음
    //PassthroughSubject 전달한 값을 가지고 있지 않음. 변경사항을 관찰하지 않아도 됨
    private let commentEntered = PassthroughSubject<String, Error>()
    private var subscriptions = Set<AnyCancellable>()
    
    //필터링하기 위한 나쁜 단어 배열 만들기
    private let badWords = ["💩", "🍆"]

    private let manager: AccountViewModel
    
    init(manager: AccountViewModel) {
        self.manager = manager
        setupSubscription() //초기화할때마다 setupSubscription실행
    }
    
    func send(comment: String) {
        commentEntered.send(comment)
    }
}

private extension CommentsViewModel {
    
    func setupSubscription() {
        
        commentEntered
            .filter({ !$0.isEmpty }) //텍스트필드 비어있으면 콘솔에 출력 안되도록
            .sink(receiveCompletion: { _ in }) //게시될 때 값을 가져옴
            { [weak self] val in
                
                guard let self = self else { return }
                if self.badWords.contains(val) { //나쁜단어 포함되어있는지 확인 //3번 입력했을때 계정 차단 등 기능 사용 가능
                    self.manager.increaseWarning() //포함되어있으면 경고 올림
                } else {
                    print("New Comment: \(val)")
                }
            }
            .store(in: &subscriptions)
    }
}
