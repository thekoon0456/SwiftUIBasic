//
//  ContentView.swift
//  TextInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/27.
//

import SwiftUI

struct ContentView: View {
    
    let money: Decimal = 50.2
    private let dateFormat: Date.FormatStyle = .init(date: .abbreviated,
                                                     time: .shortened)
    
    var body: some View {
        VStack {
            Group {
                Text("My Text Here")

                Text("My Text Here")
                    .bold()
                    .italic()
                    .underline(true, color: .red) //밑줄 색상 지정 가능

                Text("My Text Here")
                    .foregroundColor(.mint)
                    .font(.largeTitle.weight(.black))

                Text("My Text Here")
                    .foregroundColor(.blue)
                    .font(.system(size: 18,
                                  weight: .semibold,
                                  design: .rounded)) //text 둥글게 설정
                
            }

            Group {
                
                Text(.now, style: .timer) //자동 타이머 설정 가능

                Text(.now, style: .time) //시간
                Text(.now, style: .date) //날짜

                Text("View calendar \(Image(systemName: "calendar")) here")

                Text(Date.now...Date.now.addingTimeInterval(3600)) //지금부터 1시간 범위 보여줌
                             
                Text(Date.now, format: Date.FormatStyle(date: .abbreviated,
                                                         time: .shortened))

                
                Text(72.3, format: .currency(code: "GBP")) //통화 코드로 설정 가능
                Text(72.3, format: .currency(code: "USD"))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
