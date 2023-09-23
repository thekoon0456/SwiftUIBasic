//
//  ViewController.swift
//  Assigning Subscriptions
//
//  Created by Deokhun KIM on 2023/01/30.
//

import UIKit
import Combine

class ViewController: UIViewController {

    private let inputTxtField: UITextField = {
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = "Enter some text here"
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    private let textLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "The user entered:"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 24, weight: .semibold)
        return lbl
    }()
    
    private var subscriptions = Set<AnyCancellable>() //구독할 subscriptions 생성 - 여러 textfield를 바인딩 - set으로 할당
    
    override func loadView() {
        super.loadView()
        setup()
        createSubscriptions()
    }
}

private extension ViewController {
    
    func setup() {
        
        view.addSubview(inputTxtField)
        view.addSubview(textLbl)
        
        NSLayoutConstraint.activate([
            inputTxtField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            inputTxtField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputTxtField.heightAnchor.constraint(equalToConstant: 44),
            inputTxtField.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: 8),
            textLbl.topAnchor.constraint(equalTo: inputTxtField.bottomAnchor,
                                         constant: 16),
            textLbl.leadingAnchor.constraint(equalTo: inputTxtField.leadingAnchor),
            textLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                              constant: -8)
        ])
    }
    
    //구독 설정
    func createSubscriptions() {
        //textfield와 lable 바인딩
        NotificationCenter //알람센터 사용 - 기본 알람 프레임워크
            .default
            .publisher(for: UITextField.textDidChangeNotification, //textfield 변경 알림 듣기 위해
                       object: inputTxtField) //입력되는 텍스트필드
            .compactMap { ($0.object as? UITextField)?.text } //UITextField로 타입 변환한 다음 엑세스. campactMap으로 nil제거
            .map { "The user entered: \($0)" }
            .assign(to: \.text, on: textLbl) //textLBl에 text값 할당. keypath인 레이블의 text속성 할당
            .store(in: &subscriptions) //구독을 저장하고, text publisher 설정. &은 입력 및 출력 속성(in&out)을 의미
    }
}
