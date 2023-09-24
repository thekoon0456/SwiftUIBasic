//
//  ViewController.swift
//  CurrentValueSubject
//
//  Created by Deokhun KIM on 2023/02/05.
//

import UIKit
import Combine

//MARK: - CurrentValueSubject
class ViewController: UIViewController {

    private let firstNameTxtField: UITextField = {
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = "First Name"
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    private let lastNameTxtField: UITextField = {
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = "Last Name"
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    private let occupationTxtField: UITextField = {
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = "Occupation"
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    private let confirmBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(confirmDidTouch), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        btn.setTitle("Confirm", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return btn
    }()
    
    private let formContainerStackVw: UIStackView = {
        let stackVw = UIStackView()
        stackVw.spacing = 16
        stackVw.axis = .vertical
        stackVw.distribution = .fillEqually
        stackVw.translatesAutoresizingMaskIntoConstraints = false
        return stackVw
    }()
    
    //MARK: - CurrentValueSubject생성/ 값을 선언하고 관찰하고 변경/ Never사용하는 대신 Error로 에러처리
    private let person = CurrentValueSubject<Person, Error>(Person(firstName: "", //기본적으로 Person타입의 기본값 할당, 이 값을 변경하고 관찰함
                                                                   lastName: "",
                                                                   occupation: ""))
    //MARK: - subscriptions 만듬
    private var subscriptions = Set<AnyCancellable>() //각 텍스트 필드를 구조체 내의 각 속성에 바인딩
    
    //MARK: -loadView에 setupInputSubscriptions넣어서 값이 변경될때마다 뷰가 그려지게
    override func loadView() {
        super.loadView()
        setup()
        setupInputSubscriptions()
        setupPersonSubscription()
    }
    
    @objc
    func confirmDidTouch() {
        
        if person.value.isValid {
            person.send(completion: .finished)
        } else {
            person.send(completion: .failure(UserError.invalid))
        }
    }
}

private extension ViewController {
    
    //입력하는 3개의 텍스트필드를 모두 listen 할수 있는 subscriptions필요
    func setup() {
        
        formContainerStackVw.addArrangedSubview(firstNameTxtField)
        formContainerStackVw.addArrangedSubview(lastNameTxtField)
        formContainerStackVw.addArrangedSubview(occupationTxtField)
        formContainerStackVw.addArrangedSubview(confirmBtn)

        view.addSubview(formContainerStackVw)
        
        NSLayoutConstraint.activate([
            formContainerStackVw.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                          constant: 16),
            formContainerStackVw.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                          constant: -16),
            formContainerStackVw.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            formContainerStackVw.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        formContainerStackVw
            .arrangedSubviews
            .forEach { $0.heightAnchor.constraint(equalToConstant: 44).isActive = true }
    }
    //MARK: - 입력하는 3개의 텍스트필드를 모두 listen 할수 있는 subscriptions필요
    func setupInputSubscriptions() {
        
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification,
                       object: firstNameTxtField)
            .compactMap { ($0.object as? UITextField)?.text }
            .sink(receiveValue: { [weak self] val in //sink 사용해 동기화 사용 / 약한참조 사용. 이것이 처리되고 뷰컨트롤러 내에서 강력한 참조가 없는지 확인할 수 있음
                    self?.person.value.firstName = val //가져온 값을 person의 firstName에 할당
            })
            .store(in: &subscriptions)
        
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification,
                       object: lastNameTxtField)
            .compactMap { ($0.object as? UITextField)?.text }
            .sink(receiveValue: { [weak self] val in
                    self?.person.value.lastName = val
            })
            .store(in: &subscriptions)
        
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification,
                       object: occupationTxtField)
            .compactMap { ($0.object as? UITextField)?.text }
            .sink(receiveValue: { [weak self] val in
                    self?.person.value.occupation = val
            })
            .store(in: &subscriptions)
        
    }
    
    //MARK: - person의 변경사항을 들음
    func setupPersonSubscription() {
        
        person.sink { [weak self] res in //sink: person으로부터 가장 최근 값을 가져와서 동기화함
            switch res {
            case .finished: //최종 입력이 완료되었을때 / 최종입력이 완료되면 구독 완료
                print(self?.person.value.message ?? "") //옵셔널값이므로 언래핑
                print("Subscription is now finished")
            case .failure(let error as UserError):
                self?.showFailed(message: error.errorDescription)
            case .failure(let error):
                self?.showFailed(message: error.localizedDescription)
            }
        } receiveValue: { person in
            print("Updated: \(person)") //값을 받으면 print
        }.store(in: &subscriptions)
    }
}
