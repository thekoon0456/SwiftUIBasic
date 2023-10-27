//
//  ContentView.swift
//  SwiftUIConcurrency
//
//  Created by Deokhun KIM on 10/22/23.
//

import SwiftUI

struct ContentView: View {
    @State private var asyncletTimer = 0
    @State private var letAwaitTimer = 0
    @State private var timer1: Timer?
    @State private var timer2: Timer?
    
    @State private var downloadedImage1: UIImage?
    @State private var downloadedImage2: UIImage?
    @State private var downloadedImage3: UIImage?
    @State private var downloadedImage4: UIImage?
    @State private var downloadedImage5: UIImage?
    @State private var downloadedImage6: UIImage?
    
    private let counter = Counter(name: "actorCount") //Actor 인스턴스
    @State private var actorCount = 0
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Swift Concurrency")
                .font(.system(size: 30))
                .padding(.vertical, 20)
            
            Group {
                Text("1. async let 과 let = await와 차이점")
                    .font(.system(size: 20, weight: .bold))
                
                Button("async let = 함수(): \(asyncletTimer)초 걸림") {
                    asyncletTimer = 0
                    
                    timer1 = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        asyncletTimer += 1
                    }
                    
                    Task {
                        //async let은 병렬로 동시에 시작됨
                        async let a = async1() //5초 걸림
                        async let b = async2() //3초 걸림
                        
                        await print("async let: \(a + b)리턴, \(asyncletTimer)초 걸림") //총 5초 걸림
                        timer1?.invalidate()
                    }
                }
                
                Button("let a = await 함수(): \(letAwaitTimer)초 걸림") {
                    letAwaitTimer = 0
                    
                    timer2 = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        letAwaitTimer += 1
                    }
                    
                    Task {
                        //Task내에서 직렬로 실행됨
                        let a = await async1() //5초 걸림
                        let b = await async2() //5초 뒤 시작해 3초 더 걸림
                        
                        print("await async: \(a + b)리턴, \(letAwaitTimer)초 걸림") //총 8초 걸림
                        timer2?.invalidate()
                    }
                }
            }
            
            Group {
                Text("2. .withTaskGroup 사용")
                    .font(.system(size: 20, weight: .bold))
                HStack(spacing: 30) {
                    // MARK: - 직렬 다운로드
                    Button {
                        let urlArr = [URL(string: "https://picsum.photos/200/300")!,
                                      URL(string: "https://picsum.photos/200/300")!,
                                      URL(string: "https://picsum.photos/200/300")!]
                        Task {
                            //직렬로 진행됨, 에러 던지지않음
                            await withTaskGroup(of: Void.self) { group in
                                //하나의 group에 addTask해서 직렬로 실행됨
                                group.addTask {
                                    if let data = try? Data(contentsOf: urlArr[0]) {
                                        downloadedImage1 = UIImage(data: data)
                                    }
                                    
                                    if let data = try? Data(contentsOf: urlArr[1]) {
                                        downloadedImage2 = UIImage(data: data)
                                    }
                                    
                                    if let data = try? Data(contentsOf: urlArr[2]) {
                                        downloadedImage3 = UIImage(data: data)
                                    }
                                }
                            }
                        }
                    } label: {
                        button1
                    }
                    
                    // MARK: - 병렬 다운로드
                    Button {
                        let urlArr = [URL(string: "https://picsum.photos/200/300")!,
                                      URL(string: "https://picsum.photos/200/300")!,
                                      URL(string: "https://picsum.photos/200/300")!]
                        Task {
                            //직렬로 진행됨, 에러 던지지않음
                            await withTaskGroup(of: Void.self) { group in
                                //각자 그룹에 addTask해주면 병렬로 실행됨
                                for i in 0...2 {
                                    group.addTask {
                                        if let data = try? Data(contentsOf: urlArr[i]) {
                                            if i == 0 {
                                                downloadedImage4 = UIImage(data: data)
                                            }
                                            
                                            if i == 1 {
                                                downloadedImage5 = UIImage(data: data)
                                            }
                                            
                                            if i == 2 {
                                                downloadedImage6 = UIImage(data: data)
                                            }
                                            
                                        }
                                    }
                                }
                                
                                //모든 태스크가 완료될때까지 기다림
                                for await _ in group {
                                    print("사진 다운로드 완료")
                                }
                                
                            }
                        }
                    } label: {
                        button2
                    }
                }
            }
            
            Group {
                Text("3. Actor 사용")
                    .font(.system(size: 20, weight: .bold))
                
                //let, nonisolated 함수는 접근시 Task 필요없음 (불변성이므로 안전하게 접근)
                Text("Actor nonisolated사용, func 실행: \(counter.getName())")
                
                //var, 일반 함수는 접근시 Task 필요 (가변성이므로 Task로 실행)
                Button("Actor사용, actor Count: \(actorCount)") {
                    Task { //actor 메소드 사용시 Task안에서 사용
                        await counter.plus()
                        print("actor Counter: \(await counter.count)")
                        actorCount = await counter.count
                    }
                }
            }
        }
        .padding(20)
    }
}

// MARK: - 1. async let 과 let = await와 차이점 사용함수

extension ContentView {
    func async1() async -> Int {
        let time: UInt32 = 5
        sleep(time)
        print("async1완료 \(time)")
        return Int(time)
    }
    
    func async2() async -> Int {
        let time: UInt32 = 3
        sleep(time)
        print("async2완료 \(time)")
        return Int(time)
    }
}

// MARK: - 2. .withTaskGroup 사용
//랜덤 이미지 url: https://picsum.photos/200/300

extension ContentView {
    //직렬 다운로드 버튼
    var button1: some View {
        VStack {
            Text("직렬 다운로드")
            if let image = downloadedImage1 {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
            }
            
            if let image = downloadedImage2 {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
            }
            
            if let image = downloadedImage3 {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
            }
        }
    }
    
    //병렬 다운로드 버튼
    var button2: some View {
        VStack {
            Text("병렬 다운로드")
            if let image = downloadedImage4 {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
            }
            
            if let image = downloadedImage5 {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
            }
            
            if let image = downloadedImage6 {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
            }
        }
    }
}

// MARK: - 3. Actor 사용
// actor: 동시성 환경에서 안전하게 데이터를 공유
//내부 함수 async 키워드 따로 안써줘도됨. actor내부 함수는 자동적으로 비동기 처리 가능
//let, let을 읽는 nonisolated func는 불변이므로 Task 필요없이 접근 가능
//var는 가변이므로 nonisolated 사용불가
actor Counter {
    private let name: String
    private(set) var count = 0
    
    init(name: String) {
        self.name = name
    }
    
    func plus() {
        count += 1
    }
    
    nonisolated func getName() -> String {
        name
    }
    
    //var이기 때문에 nonisolated 사용 불가
    //        nonisolated func getCount() -> Int {
    //            count
    //        }
}

#Preview {
    ContentView()
}
