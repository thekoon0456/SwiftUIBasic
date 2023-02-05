//
//  NumberList.swift
//  Safe Area In SwiftUI
//
//  Created by Deokhun KIM on 2023/02/05.
//
//MARK: - https://developer.apple.com/design/human-interface-guidelines/foundations/layout
import SwiftUI

struct NumberList: View {
    var body: some View {
        NavigationView {
            
            List(0..<20) { i in
                Text("Number \(i)")
            }
            .navigationTitle("Numbers")
            
            //floating button 만들 수 있음. 오른쪽 하단 모서리에 추가!
            .safeAreaInset(edge: .bottom,
                           alignment: .trailing,
                           spacing: 0) { //spacing: safearea 밑에 spacing만큼 영역이 추가됨
                plusBtn
            }
            
            //사이드바 만들기
            .safeAreaInset(edge: .leading,
                           alignment: .top,
                           spacing: 0) {
                sideBar
            }
        }
    }
}

struct NumberList_Previews: PreviewProvider {
    static var previews: some View {
        NumberList()
    }
}

private extension NumberList {
    
    var plusBtn: some View {
        Button {
         // Add something
        } label: {
            Image(systemName: "plus")
                .symbolVariant(.circle.fill) //테두리도 넣을 수 있음!
                .font(.system(size: 44,
                              weight: .bold,
                              design: .rounded))
                .padding(.trailing, 4)
        }
    }
    
    var sideBar: some View {
        
        VStack(alignment: .leading) {
            ForEach([
                "Home",
                "Features",
                "My Profile",
                "Settings"
            ], id: \.self) { item in
                Text("\(item)")
                    .bold()
                    .padding()
            }
        }
    }
}
