//
//  ScreenOne.swift
//  TabViewInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/27.
//

import SwiftUI

struct ScreenOne: View {
    
    @EnvironmentObject var router: TabRouter
    
    var body: some View {
        ZStack {
            
            VStack {
                
                Text("Screen 1")
                    .bold()
                    .foregroundColor(.white)
                
                Button {
                    router.change(to: .two)
                } label: {
                    Text("Switch to screen 2")
                }

            }
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .background(.mint)
        .clipped() //테두리 자르기
    }
}

struct ScreenOne_Previews: PreviewProvider {
    static var previews: some View {
        ScreenOne()
            .environmentObject(TabRouter())
    }
}
