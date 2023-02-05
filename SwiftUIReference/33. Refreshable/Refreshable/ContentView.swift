//
//  ContentView.swift
//  Searchable
//
//  Created by Deokhun KIM on 2023/02/05.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = PeopleViewModel()
    
    var body: some View {
        NavigationView {
            PeopleView(vm: vm)
                .refreshable {
                    await vm.generatePerson()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
