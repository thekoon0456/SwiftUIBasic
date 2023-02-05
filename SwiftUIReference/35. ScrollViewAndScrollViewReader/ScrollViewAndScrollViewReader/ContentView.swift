//
//  ContentView.swift
//  ScrollViewAndScrollViewReader
//
//  Created by Deokhun KIM on 2023/02/05.
//

import SwiftUI

struct ContentView: View {
    
    private let range: ClosedRange<Int> = 0...50
    
    //끝에 도달했는지 확인
    @State private var hasReachedEnd = false
    
    var body: some View {
        //embed...로 넣을 수 있음
//        ScrollView(showsIndicators: false) {
//            VStack {
//                ForEach(0...50, id: \.self) { i in
//                    createTxtVw(with: i)
//                }
//            }
//        }
        //MARK: - ScrollViewReader: 스크롤하는 프록시에 엑세스
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    HStack {
                        ForEach(range, id: \.self) { i in
                            createTxtVw(with: i)
                                .id(i)
                        }
                    }
                    .padding(.bottom, 50)
                    //hasReachedEnd 변수 상태에 따라 버튼 위치 조절
                    .overlay(alignment: !hasReachedEnd ? .bottomLeading : .bottomTrailing) {
                        
                        HStack {
                            Button {
                                //첫번째 인덱스로 이동
                                if let firstIndex = range.min() { //인덱스를 범위 최소값으로 이동
                                    withAnimation { //애니메이션을 부드럽게 이동
                                        proxy.scrollTo(firstIndex)
                                    }
                                    hasReachedEnd = false //애니메이션 안에 넣으면 같이 이동함
                                }
                            } label: {
                                Image(systemName: "arrow.backward")
                            }
                            Button {
                                if let lastIndex = range.max() {
                                    withAnimation {
                                        proxy.scrollTo(lastIndex)
                                    }
                                    hasReachedEnd = true
                                }
                            } label: {
                                Image(systemName: "arrow.forward")
                            }
                        }
                        .symbolVariant(.circle.fill)
                        .font(.title.weight(.black))
                        
                    }
                }
            }
            
 
        }
    }
}

private extension ContentView {
    
    func createTxtVw(with index: Int) -> some View {
        Text("\(index)")
            .padding()
            .background(.mint, in: RoundedRectangle(cornerRadius: 8,
                                                    style: .continuous))
            .padding(.horizontal, 8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
