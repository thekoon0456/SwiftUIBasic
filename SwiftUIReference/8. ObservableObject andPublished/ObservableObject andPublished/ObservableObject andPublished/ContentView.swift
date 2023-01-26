//
//  ContentView.swift
//  BreakingDownStateAndDataFlow
//
//  Created by Deokhun KIM on 2023/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm: PeopleViewModel = .init()
    
    var body: some View {
        
        VStack {
            if vm.isLoading {
                ProgressView()
                Text("Loading...")
                    .padding()
            } else {
                Text(vm.people.isEmpty ? "No Users" : "Managed to get \(vm.people.count) users")
            }
            Button {
                vm.fetchPeople()
            } label: {
                Text("Fetch some people")
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
