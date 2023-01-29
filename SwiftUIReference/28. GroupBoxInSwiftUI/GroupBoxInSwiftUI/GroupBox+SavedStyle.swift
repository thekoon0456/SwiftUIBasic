//
//  GroupBox+SavedStyle.swift
//  GroupBoxInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/27.
//

import Foundation
import SwiftUI

struct GroupBoxSavedStyle: GroupBoxStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading,
               spacing: 8) {
            
            configuration.label
            configuration.content
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thickMaterial, in: RoundedRectangle(cornerRadius: 8)) //thickMaterial 로 배경 기본 회색이랑 다름
    }
}

extension GroupBoxStyle where Self == GroupBoxSavedStyle {
    static var saved: GroupBoxSavedStyle { .init() }
}
