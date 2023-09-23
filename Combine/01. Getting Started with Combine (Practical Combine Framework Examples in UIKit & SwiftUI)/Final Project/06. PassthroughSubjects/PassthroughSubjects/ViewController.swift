//
//  ViewController.swift
//  PassthroughSubjects
//
//  Created by Deokhun KIM on 2023/02/05.
//

import UIKit
import Combine

//MARK: - PassthroughSubjects
class ViewController: UIViewController {

    private let commentTxtVw: UITextView = {
        let txtVw = UITextView()
        txtVw.layer.borderColor = UIColor.systemGray4.cgColor
        txtVw.layer.borderWidth = 1
        txtVw.layer.cornerRadius = 8
        txtVw.translatesAutoresizingMaskIntoConstraints = false
        return txtVw
    }()
    
    private let commentBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(commentDidTouch), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        btn.setTitle("Comment", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return btn
    }()
    
    private let formContainerStackVw: UIStackView = {
        let stackVw = UIStackView()
        stackVw.spacing = 16
        stackVw.axis = .vertical
        stackVw.distribution = .fillProportionally
        stackVw.translatesAutoresizingMaskIntoConstraints = false
        return stackVw
    }()

    //lazy로 사용할때 생성. 아니면 오류 발생
    private lazy var accountManager = AccountViewModel()
    //MARK: -CommentsViewModel 초기화
    private lazy var commentsViewModel = CommentsViewModel(manager: accountManager) //CommentsViewModel에 CommentsViewModel 넣음
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        setup()
        accountSubscription()
    }
    
    @objc
    func commentDidTouch() {
        commentsViewModel.send(comment: commentTxtVw.text) //댓글입력하고 버튼 누르면 텍스트 보냄
    }
}

private extension ViewController {
    
    func setup() {
        
        formContainerStackVw.addArrangedSubview(commentTxtVw)
        formContainerStackVw.addArrangedSubview(commentBtn)

        view.addSubview(formContainerStackVw)
        
        NSLayoutConstraint.activate([
                        
            commentBtn.heightAnchor.constraint(equalToConstant: 44),
            commentTxtVw.heightAnchor.constraint(equalToConstant: 150),
            formContainerStackVw.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                          constant: 16),
            formContainerStackVw.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                          constant: -16),
            formContainerStackVw.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                         constant: -44)
        ])
    }
    
    func accountSubscription() {
        accountManager
            .userAccountStatus //AccountViewModel의 userAccountStatus(CurrentValueSubject)
            .sink { [weak self] (status) in
                guard let self = self else { return }
                if status == .banned { //사용자 계정 상태가 .banned되면
                    self.showBlocked() //alert 띄워주기
                }
            }
            .store(in: &subscriptions)
    }
}
