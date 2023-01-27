//
//  ContentView.swift
//  TestProject
//
//  Created by Deokhun KIM on 2023/01/27.
//

import SwiftUI

struct ContentView: View {
    
    @State private var exampleOneCounter: Int = 0
    @State private var exampleTwoCounter: Int = 0
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 32) {
                
                VStack {
                    Text("Number of times pressed: \(exampleOneCounter)")
                    Button {
                        exampleOneCounter += 1
                    } label: {
                        Text("Example 1 Increase")
                    }
                }
                
                VStack {
                    //함수 만들어서 사용
                    Text("Number of times pressed: \(exampleTwoCounter)")
                    Button(action: increaseCounterTwo) {
                        Text("Example 2 Increase")
                    }
                }
                
                Group {
                    //버튼에 role 지정 가능. 버튼 역할 명확하게 지정 가능
                    //취소작업
                    Button(role: .cancel) {
                        
                    } label: {
                        Text("Cancel Example Role")
                    }
                    
                    //destructive: 파괴작업. 버튼 빨간색으로 바뀜
                    Button(role: .destructive) {
                        
                    } label: {
                        Text("Destructive Role")
                    }
                    
                    //none: 표준작업
                    Button(role: .none) {
                        
                    } label: {
                        Text("Default Role")
                    }
                    
                }
                
                
                Button {
                    print("Hey i've been pressed")
                } label: {
                    Text("Press Me")
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(.red)
                        .tint(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding()
                
                //custom buttonStyle 사용
                Button {
                    
                } label: {
                    Text("Send Mail")
                }
                .buttonStyle(SendButtonStyle())
                
                
                //extension - 점표기법 사용
                Button {
                    
                } label: {
                    Text("Send Mail")
                }
                .buttonStyle(.send)
                
                //SendButton struct 만들어서 사용
                SendButton {
                 print("Heyyy it works!!!")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//증가 함수 만들어서 활용 가능
private extension ContentView {
    
    func increaseCounterTwo() {
        exampleTwoCounter += 1
    }
}
