//
//  ContentView.swift
//  BreakingDownStateAndDataFlow
//
//  Created by Deokhun KIM on 2023/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var people: [String] = []
    
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
                Text("Loading...")
                    .padding()
            } else {
                Text(people.isEmpty ? "No Users" : "Manage to get \(people.count) users")
            }
            
            Button {
                fetchPeople()
            } label: {
                Text("Fetch some people")
            }

        }
    }
}

private extension ContentView {
    
    func fetchPeople() {
        isLoading = true
        DispatchQueue.main.asyncAfer(deadline: .now() + 1.5) {
            people = ["tunds", "Billy", "Bob", "Aimie"]
            isLoading = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
