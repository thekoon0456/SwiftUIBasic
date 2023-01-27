//
//  Toggle+CheckboxStyle.swift
//  ToggleInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/26.
//

import Foundation
import SwiftUI

struct ToggleCheckboxStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Image(systemName: "checkmark.square")
                .symbolVariant(configuration.isOn ? .fill : .none)
        }
        .tint(.red)
    }
}

//extension 활용해 점 표기법 사용 가능
extension ToggleStyle where Self == ToggleCheckboxStyle {
    static var checklist: ToggleCheckboxStyle { .init() }
}
