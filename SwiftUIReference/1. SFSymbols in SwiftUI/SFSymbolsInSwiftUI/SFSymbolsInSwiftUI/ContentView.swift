//
//  ContentView.swift
//  SFSymbolsInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            
            Image(systemName: "cloud.sun")
                  .font(.system(size: 50,
                                weight: .bold))
                  .foregroundColor(.blue)
                  .symbolVariant(.fill) //심볼 채우기
            
            Divider()
            
            //심볼 사이즈 조절
            VStack {
                Label("Cloudy", systemImage: "cloud.sun")
                    .imageScale(.small) //심볼 사이즈만 조절
                
                Label("Cloudy", systemImage: "cloud.sun")
                    .imageScale(.medium)
                
                Label("Cloudy", systemImage: "cloud.sun")
                    .imageScale(.large)
            }
            .font(.system(size: 20, weight: .bold))
            .symbolVariant(.fill)
            
            Divider()
            
            //렌더링 모드
            VStack {
                Image(systemName: "cloud.sun")
                    .symbolRenderingMode(.monochrome) //단색, 기본적용
                    .foregroundColor(.red)
                
                Image(systemName: "cloud.sun")
                    .symbolRenderingMode(.multicolor) //기본제공 컬러
                
                Image(systemName: "cloud.sun")
                    .symbolRenderingMode(.hierarchical) //계층 - 블랙, 회색
                
                Image(systemName: "cloud.sun")
                    .symbolRenderingMode(.palette) //색 조합
                    .foregroundStyle(.red, .blue)
            }
            .padding()
            .background(.mint)
            .font(.system(size: 20, weight: .bold))
            .symbolVariant(.fill) //심볼 색 채우기, iOS 15부터
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
