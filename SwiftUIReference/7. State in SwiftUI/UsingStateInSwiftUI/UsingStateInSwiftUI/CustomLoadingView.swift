//
//  CustomLoadingView.swift
//  UsingStateInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/26.
//

import SwiftUI

struct CustomLoadingView: View {
    
    @Binding var isLoading: Bool
    
    var body: some View {
        if isLoading {
            ProgressView()
        } else {
            Text("Finished loading")
        }
    }
}

struct CustomLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CustomLoadingView(isLoading: .constant(true))
            CustomLoadingView(isLoading: .constant(false))
                .previewDevice("iPhone SE (3rd generation)")
        }
    }
}
