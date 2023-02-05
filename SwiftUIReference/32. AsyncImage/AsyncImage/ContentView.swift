//
//  ContentView.swift
//  AsyncImageStarter
//
//  Created by Deokhun KIM on 2023/02/05.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var vm: MenuViewModel
    
    var body: some View {
        //MARK: -data 인덱스로 사용하기 위해 .indices사용!
        List {
            ForEach(vm.data.indices) { index in
                FoodItemView(index: index,
                             item: vm.data[index])
                    .listRowSeparator(.hidden) //리스트 밑에 줄 제거 가능!
                    .listRowBackground(Color.clear) //리스트 배경도 설정 가능
            }
        }
        .listStyle(.grouped)
        .navigationTitle("Menu")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
                .environmentObject(MenuViewModel())
        }
    }
}
