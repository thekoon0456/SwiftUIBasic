//
//  ProgressView+RoundedStyle.swift
//  ProgressViewInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/26.
//

import Foundation
import SwiftUI

struct RoundedProgressViewStyle: ProgressViewStyle {
    
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .padding()
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

//점 표기법으로 접근가능
extension ProgressViewStyle where Self == RoundedProgressViewStyle {
    static var rounded: RoundedProgressViewStyle { .init(color: .blue) }
}
