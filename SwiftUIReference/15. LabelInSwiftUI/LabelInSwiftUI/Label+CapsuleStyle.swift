//
//  Label+CapsuleStyle.swift
//  LabelInSwiftUI
//
//  Created by Tunde on 25/01/2022.
//

import Foundation
import SwiftUI

//view Modifier처럼 lable에 LabelStyle 적용가능
struct CapsuleStyle: LabelStyle {

    func makeBody(configuration: Configuration) -> some View {
        Label(configuration)
            .padding()
            .background(.blue)
            .clipShape(Capsule())
    }
}

struct StrongCapsuleStyle: LabelStyle {
    //색상 선택 가능하도록
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        Label {
            configuration
                .title
                .foregroundColor(.white)
                .font(.system(size: 15, weight: .bold))
        } icon: {
            configuration.icon //icon까지 바로 설정 가능
        }
        .padding()
        .background(color)
        .clipShape(Capsule())
    }
}

//extension 사용해 점 표기법으로 바로 접근
extension LabelStyle where Self == CapsuleStyle {
    static var capsule: CapsuleStyle { .init() }
}

extension LabelStyle where Self == StrongCapsuleStyle {
    //컬러 기본값으로 init 하거나 설정 따로 할 수 있도록 함수로 만들 수 있음
    static func strongCapsule(color: Color = .red) -> StrongCapsuleStyle { .init(color: color) }
}
