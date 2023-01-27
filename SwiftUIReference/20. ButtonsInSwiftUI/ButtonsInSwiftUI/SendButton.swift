//
//  SendButton.swift
//  TestProject
//
//  Created by Deokhun KIM on 2023/01/27.
//

import SwiftUI

struct SendButton: View {
    //클로저 만들기
    let action: () -> Void
    
    var body: some View {
        //버튼 클릭할때마다 클로저 트리거
        Button(action: action) {
            Text("Send Mail")
        }
        .buttonStyle(.send)
    }
}

struct SendButton_Previews: PreviewProvider {
    static var previews: some View {
        SendButton {}
    }
}
