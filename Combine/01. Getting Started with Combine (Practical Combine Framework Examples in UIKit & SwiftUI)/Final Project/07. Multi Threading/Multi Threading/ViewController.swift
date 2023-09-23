//
//  ViewController.swift
//  Multi Threading
//
//  Created by Deokhun KIM on 2023/02/05.
//

import UIKit
import Combine

//MARK: -Multi Threading: 프로세스를 다른 프로세스로 이동
class ViewController: UIViewController {
    
    private let contentImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        imgVw.contentMode = .scaleAspectFill
        imgVw.backgroundColor = .systemGray4
        imgVw.layer.cornerRadius = 8
        return imgVw
    }()
    
    private let downloadBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(downloadDidTouch), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        btn.setTitle("Download", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return btn
    }()
    
    private let contentContainerStackVw: UIStackView = {
        let stackVw = UIStackView()
        stackVw.spacing = 16
        stackVw.axis = .vertical
        stackVw.distribution = .fillProportionally
        stackVw.translatesAutoresizingMaskIntoConstraints = false
        return stackVw
    }()
    
    private let imgLink = "https://blueprint-api-production.s3.amazonaws.com/uploads/story/thumbnail/121489/11a49146-03e6-4f02-8c30-ac3454a1b54b.png"
    
    //뷰모델 인스턴스 생성
    private let imgDownloaderViewModel = ImageDownloaderViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        setup()
        setupImageSubscription()
    }
    
    @objc
    func downloadDidTouch() {
        imgDownloaderViewModel.download(url: imgLink) //이미지 링크 다운로드
    }
}

private extension ViewController {
    
    func setup() {
        
        contentContainerStackVw.addArrangedSubview(contentImgVw)
        contentContainerStackVw.addArrangedSubview(downloadBtn)
        
        view.addSubview(contentContainerStackVw)
        
        NSLayoutConstraint.activate([
            
            downloadBtn.heightAnchor.constraint(equalToConstant: 44),
            contentImgVw.heightAnchor.constraint(equalToConstant: 150),
            
            contentContainerStackVw.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentContainerStackVw.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentContainerStackVw.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                             constant: 16),
            contentContainerStackVw.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                              constant: -16)

        ])
    }
    
    //구독을 만들고 유지
    func setupImageSubscription() {
        
        imgDownloaderViewModel
            .image
            .assign(to: \.image, on: contentImgVw) //contentImgVw를 keypath이용해 image에 바인딩
            .store(in: &subscriptions)
    }
}

class ImageDownloaderViewModel {
    
    let image = PassthroughSubject<UIImage?, Never>() //이미지 관찰할 필요없이 받아오기만 하면 되므로 PassthroughSubject사용
    
    private var subscriptions = Set<AnyCancellable>()

    func download(url: String) {
        
        URLSession //url접근. combine기본 제공
            .shared
            .dataTaskPublisher(for: URL(string: url)!)
            .subscribe(on: DispatchQueue.global(qos: .background)) //background스레드에서 동작하도록
            .handleEvents(receiveSubscription: { _ in //handleEvents로 구독을 직접 관리
                
                print("Starting Subscription on the main thread: \(Thread.isMainThread)") //메인스레드인지 출력
                
                DispatchQueue.main.async { //시스템 메인스레드에서 UI그리도록
                    print("Setting the placeholder image on the main thread: \(Thread.isMainThread)") //placeholer가 메인스레드에서 실행되고 있는지 확인
                    self.image.send(UIImage(named: "placeholder")) //이미지 가져올때 로딩화면 나오게 구현, assets에넣음
                }
            })
            .map { UIImage(data: $0.data) } //받은데이터를 UIImage로 변환
            .receive(on: DispatchQueue.main) //.receive(on:) 특정 스레드에서 이벤트 수신할 수 있도록 - 메인스레드에서
            .sink { (res) in //
                switch res {
                case .failure:
                    print("Failed on the main thread: \(Thread.isMainThread)")
                case .finished:
                    print("Finished on the main thread: \(Thread.isMainThread)") //구독 완료되면 콘솔에 출력
                }
            } receiveValue: { [weak self] (val) in
                self?.image.send(val) //값을 받으면 image로 보냄
                self?.image.send(completion: .finished)
                print("Recieved Value on the main thread: \(Thread.isMainThread)")
            }
            .store(in: &subscriptions)
    }
}
