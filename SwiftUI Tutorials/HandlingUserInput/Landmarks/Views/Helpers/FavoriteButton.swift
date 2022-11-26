//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by Deokhun KIM on 2022/11/26.
//  Copyright © 2022 Apple. All rights reserved.
//

import SwiftUI

struct FavoriteButton: View {
    //현재 버튼 연동될 프로퍼티
    @Binding var isSet: Bool
    
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
            //.labelStyle(.iconOnly)로 "Toggle Favorite"는 화면에 나타나지는 않지만 VoiceOver 사용시 읽어줌!
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
        }

    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        //.constant로 고정된 값 넣어서 프리뷰 볼 수 있도록
        FavoriteButton(isSet: .constant(true))
    }
}
