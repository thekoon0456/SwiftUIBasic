//
//  FoodItemView.swift
//  FoodItemView
//
//  Created by Deokhun KIM on 2023/02/05.
//

import SwiftUI

struct FoodItemView: View {
    
    let index: Int
    let item: FoodItem
   
    private let cornerRadius: CGFloat = 12
    
    var body: some View {
        
        HStack(alignment: .top) {
            
            VStack {
                //기존 사각형
//                Rectangle()
//                .frame(width: 100, height: 100)
//                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                
                //MARK: - AsyncImage로 대체
                //두개의 클로저. 위는 받아오는거 성공, 아래는 받아올때
                AsyncImage(url: URL(string: item.imgUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                } placeholder: {
                    Color.random //.random: Color extension으로 랜덤 컬러 배열 만듬
                        .overlay {
                            ProgressView()
                        }
                }
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                
                //MARK: - AsyncImage phase 구문 사용해서 url 받아오는거 깨졌을 때 기본 화면 만들기
                //두개의 클로저. 위는 받아오는거 성공, 아래는 받아올때
                AsyncImage(url: URL(string: item.imgUrl)) { phase in
                    
                    if let image = phase.image { //image는 optional, 언래핑하기
                        
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                        
                    } else if phase.error != nil { //url에 에러가 있다면 기본 photo 보여주기
                        
                        Color
                            .gray
                            .opacity(0.75)
                            .overlay {
                                Image(systemName: "photo")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30, weight: .bold))
                            }
                        
                    } else {
                        
                        Color.random //이미지 다운로드 중이면 progressView 나오도록.
                                     //.random: Color extension으로 랜덤 컬러 배열 만듬
                            .overlay {
                                ProgressView()
                            }
                        
                    }
                }
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))

                //MARK: - switch - case로 phase 리팩토링
                AsyncImage(url: URL(string: item.imgUrl),
                           //MARK: -transaction으로 애니메이션 추가
//                           transaction: .init(animation: .easeInOut)) {
                           transaction: .init(animation: .spring().delay(Double(index) * 0.5))) //딜레이 0.5초 넣어서 애니메이션 확인, 인덱스 별로 * 0.5초씩 되므로 계단식 로딩 가능
                           { phase in
                    
                    //MARK: - phase가 enum이므로 switch 활용 가능, 언래핑 따로 할 필요 없음
                    switch phase {

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    case .failure(let error): //error 사용해 콘솔에 프린트 가능
                        Color
                            .gray
                            .opacity(0.75)
                            .overlay {
                                Image(systemName: "photo")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30, weight: .bold))
                            }
                    case .empty:
                        Color.random
                            .overlay {
                                ProgressView()
                            }
                    @unknown default: //알수 없는 값일때 케이스
                        EmptyView()
                        
                    }
                }
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .transition(.opacity.combined(with: .scale)) //.transition 사용하여 .opacity를 scale과 결합해 로딩시 이미지 팝 애니메이션 효과 주기
                //TODO: -왜 안돼...
                
            }
            
            VStack(alignment: .leading,
                   spacing: 8) {
                Text(item.title)
                    .font(.headline)
                Text(item.attributedPrice)
                Text(item.desc)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

struct FoodItemView_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemView(index: 0,
                     item: FoodItem.preview)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.black.opacity(0.7))
    }
}
