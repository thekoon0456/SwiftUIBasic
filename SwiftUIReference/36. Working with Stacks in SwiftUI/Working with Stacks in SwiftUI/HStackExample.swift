//
//  HStackExample.swift
//  Working with Stacks in SwiftUI
//
//  Created by Deokhun KIM on 2023/02/05.
//

import SwiftUI

struct HStackExample: View {
    var body: some View {
        HStack(spacing: 32) { //아이템 간 간격 설정
            
            Group { //한 stack 당 최대 10개, 넘으면 Group으로 묶어주기

                Text("Item")
                Text("Item")
                Text("Item")
                Text("Item")
                Text("Item")
                Text("Item")
                Text("Item")
            }

            Group {

                Text("Item")
                Text("Item")
                Text("Item")
                Text("Item")
                Text("Item")
                Text("Item")
                Text("Item")
            }



//            ForEach(1...10, id: \.self) {
//                Text("Item \($0)")
//                    .fixedSize() //컨텐츠 기반으로 크기 설정
//            }
            
        }
    }
}

struct HStackExample_Previews: PreviewProvider {
    static var previews: some View {
        HStackExample()
    }
}
