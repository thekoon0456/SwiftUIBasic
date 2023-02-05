//
//  ZStackExample.swift
//  Working with Stacks in SwiftUI
//
//  Created by Deokhun KIM on 2023/02/05.
//

import SwiftUI

struct ZStackExample: View {
    //MARK: - ZStack: 인덱스 기반으로 뷰를 서로 위에 배치. 기본적인 인덱스는 0
    var body: some View {
        ZStack(alignment: .center) { //위치 설정
            Image(systemName: "star")
                .resizable()
                .scaledToFit()
                .symbolVariant(.fill)
                .foregroundStyle(.yellow)
            //    .zIndex(-2)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                //  .zIndex(-1) //별 뒤로 감
        }
    }
}

struct ZStackExample_Previews: PreviewProvider {
    static var previews: some View {
        ZStackExample()
    }
}
