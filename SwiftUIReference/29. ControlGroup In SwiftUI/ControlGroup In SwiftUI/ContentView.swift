//
//  ContentView.swift
//  ControlGroup In SwiftUI
//
//  Created by Deokhun KIM on 2023/01/27.
//

import SwiftUI

//ControlGroup: iOS 15 이상
struct ContentView: View {
    var body: some View {
        ScrollView {
            
            VStack(spacing: 32) {
             
                VStack {
                    Text("Quantity")
                    ControlGroup { //스테퍼 스타일
                        increaseBtn
                        decreaseBtn
                    }
                }
                
                VStack {
                    Text("Quantity")
                    ControlGroup {
                        increaseBtn
                        decreaseBtn
                    }
                    .controlGroupStyle(.navigation) //버튼 스타일
                }
                
                ControlGroup {
                    increaseBtn
                    decreaseBtn
                }
                .controlGroupStyle(.quantity)
            }
            .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private extension ContentView {
    
    private var increaseBtn: some View {
        Button {
            
        } label: {
            Label("Increase", systemImage: "plus")
        }
    }
    
    private var decreaseBtn: some View {
        Button {
            
        } label: {
            Label("Decrease", systemImage: "minus")
        }
    }
}
