//
//  PeopleViewModel.swift
//  UsingStateInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/26.
//

import Foundation

final class PeopleViewModel: ObservableObject {
    
    @Published var people: [String] = []
    @Published var isLoading: Bool = false
    
    func fetchPeople() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.people = ["Tunds", "Billy", "Bob", "Aimie"]
            self.isLoading = false
        }
    }
}
