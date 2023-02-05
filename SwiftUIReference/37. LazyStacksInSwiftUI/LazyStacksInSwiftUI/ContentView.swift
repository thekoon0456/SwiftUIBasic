//
//  ContentView.swift
//  LazyStacksInSwiftUI
//
//  Created by Deokhun KIM on 2023/02/05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.horizontal) {
            //MARK: - 화면에 필요할때만 뷰를 생성. 메모리를 적게 먹음
            LazyHStack(alignment: .top,
                       spacing: 32,
                       pinnedViews: [.sectionHeaders, .sectionFooters]) { //pinnedViews: section header, footer   위치 고정 가능
                
                
                Section {
                    ForEach(0...50, id: \.self) { i in
                        Text("\(i)")
                    }
                } header: { //header: 제일 앞, footer: 제일 뒤
                    Text("First Section")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.mint)
                }

                Section {
                    ForEach(51...100, id: \.self) { i in
                        Text("\(i)")
                    }
                } footer: {
                    Text("Second Section")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.pink)
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
