//
//  HintView.swift
//  HintView
//
//  Created by Deokhun KIM on 2023/02/05.
//

import SwiftUI

struct HintView: View {
    
    var body: some View {
        
        Text("Pull me down to generate a new person")
            .multilineTextAlignment(.center)
            .allowsTightening(true)
            .font(.system(size: 16, weight: .bold))
            .padding()
    }
}

struct HintView_Previews: PreviewProvider {
    static var previews: some View {
        HintView()
    }
}
