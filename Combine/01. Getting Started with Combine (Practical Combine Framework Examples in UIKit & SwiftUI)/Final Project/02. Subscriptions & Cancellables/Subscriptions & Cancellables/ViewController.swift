//
//  ViewController.swift
//  Subscriptions & Cancellables
//
//  Created by Deokhun KIM on 2023/01/30.
//

import UIKit
import Combine

//MARK: - Combine - Reactive Programming: 어떤 종류의 이벤트를 수신하는 객체가 변경사항 등의 값을 수신하면 이에 반응함. 컴바인으로 작업할때 UI가 변경사항에 반응하도록 만듬
/*
 두 가지 큰 개념
 1. Publishers: 게시자. 이벤트를 내보냄
 2. Subscriptions: 구독. 변경되거나 전송되는 이벤트를 받음
 Switch (Publisher) → 켜거나 끌때 이벤트 발생 → Light Bulb (Subscription)
 - 집에서 불 켜거나 끄기 위해 스위치 누름           - 전구 조명이 켜지거나 꺼짐
 */

class ViewController: UIViewController {

    private let countLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "00:00"
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 50, weight: .heavy)
        return lbl
    }()
    
    private let startBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        btn.setTitle("Start", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return btn
    }()
    
    private let stopBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        btn.setTitle("Stop", for: .normal)
        btn.backgroundColor = .systemGray5
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return btn
    }()
    
    private let btnContainerStackVw: UIStackView = {
        let stackVw = UIStackView()
        stackVw.spacing = 8
        stackVw.distribution = .fillEqually
        stackVw.translatesAutoresizingMaskIntoConstraints = false
        return stackVw
    }()
    
    //MARK: - 구독을 유지하려면 기본적으로 AnyCancellable 생성해야 함 - publisher의 변경사항을 들으려먼 어딘가에 저장해야 함 / subscription을 보관할 전역변수를 만듬
    private var subscription: AnyCancellable?
    
    override func loadView() {
        super.loadView()
        setup()
    }
    

    //MARK: - 타이머 함수
    @objc
    func startTimer() {
        print("Start")
        subscription = Timer //Timer: NSObject. 1. subscription에 타이머 저장
            .publish(every: 1, on: .main, in: .common) //2. publish 사용 - 타이머 개체 자체에 대한 publisher 생성 / 기본적으로 every: 1: 매 초마다, on: .main: 메인 스레드에서 타이머 실행
            .autoconnect() //3. 타이머를 publisher에 연결 - 타이머의 변경사항을 들을 수 있음.
            .scan(0, { (count, _) in //4. 값을 생성하고 변경할 수 있도록 허용. 0에서 스캔하고 1씩 count를 증가시킴
                return count + 1
            })
            .sink(receiveCompletion: { completion in //5. sink: 구독, completion handler 2개 있음
                print("Stream has completed") //completion: 구독이 완료되고 종료될때
            }, receiveValue: { count in //receiveValue: 구독 내부의 값이 변경될때
                print("Updating the label to the current value: \(count.format)")
                self.countLbl.text = count.format //레이블에 초 표시하는 포맷 - 아래 extension
            })
    }
   //MARK: - 구독 중지하는 두가지 방법
    @objc
    func stopTimer() {
        print("Stop")
//        subscription = nil //1. subscription값을 nil로 만들기 - 옵셔널타입
        subscription?.cancel() //2. .cancel() 함수 사용
    }
}

private extension ViewController {
    
    func setup() {
        
        btnContainerStackVw.addArrangedSubview(startBtn)
        btnContainerStackVw.addArrangedSubview(stopBtn)
        
        view.addSubview(btnContainerStackVw)
        view.addSubview(countLbl)
        
        NSLayoutConstraint.activate([
            
            countLbl.leadingAnchor.constraint(equalTo: btnContainerStackVw.leadingAnchor),
            countLbl.trailingAnchor.constraint(equalTo: btnContainerStackVw.trailingAnchor),
            countLbl.bottomAnchor.constraint(equalTo: btnContainerStackVw.topAnchor,
                                             constant: -24),

            
            btnContainerStackVw.heightAnchor.constraint(equalToConstant: 50),
            btnContainerStackVw.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            btnContainerStackVw.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnContainerStackVw.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                         constant: 16),
            btnContainerStackVw.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                         constant: -16),
        ])
    }
}

//초를 시간, 분, 초로 변경함
// Taken from: https://stackoverflow.com/questions/26794703/swift-integer-conversion-to-hours-minutes-seconds
extension Int {

    var format: String {

        let (h,m,s) = (self / 3600, (self % 3600) / 60, (self % 3600) % 60)

        let h_string = h < 10 ? "0\(h)" : "\(h)"
        let m_string =  m < 10 ? "0\(m)" : "\(m)"
        let s_string =  s < 10 ? "0\(s)" : "\(s)"

        return "\(h_string):\(m_string):\(s_string)"
    }
}
