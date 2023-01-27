//
//  ContentView.swift
//  Shared
//
//  Created by Deokhun KIM on 2023/01/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var progressSecondExample: Double = 0
    @State private var progressThirdExample: Double = 0

    var body: some View {
        VStack(spacing: 24) {
            Group {
                ProgressView()
                Text("Example 1")
                    .padding()
            }
            
            Group {
                //Progress bar: 이름, value: 0 - 1. 진행률 나타낼 수 있음.
                ProgressView("Example 2", value: progressSecondExample)
                Button("Increase Example 2") {
                    //부드럽게 작동. animation 추가
                    withAnimation {
                        progressSecondExample += 0.1
                    }
                }
            }
            
            Group {
                //total: 0 - 100 기준
                ProgressView(value: progressThirdExample, total: 100)
                Button("Increase Example 3") {
                    withAnimation {
                        progressThirdExample += 10
                    }
                }
            }
            
            Group {
                ProgressView(value: progressThirdExample,
                             total: 100) {
                    //클로저로 이름에 Lable 넣을 수 있음
                    Label("Upload Progress \(progressThirdExample)",
                          systemImage: "arrow.counterclockwise.icloud")
                    //frame 사용한 화면 중앙정렬
                        .frame(maxWidth: .infinity, alignment: .center)
                }

                Button("Increase Example 4") {
                    withAnimation {
                        progressThirdExample += 10
                    }
                }
            }
            
            Group {
                ProgressView() {
                    //클로저로 Lable 넣어줌
                    Label("Fetching some content",
                          systemImage: "face.smiling")
                }
                //extension 점표기법 사용
                .progressViewStyle(.rounded)
                Text("Example 5")
                    .padding()
            }

            //커스텀 progressView 사용
            Group {
                ProgressView()
                    .progressViewStyle(RoundedProgressViewStyle(color: .gray))
                    .tint(.blue) //progressView색 넣어줌
                Text("Example 5")
                    .padding()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
