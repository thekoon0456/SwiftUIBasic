//
//  PurchaseViewModel.swift
//  EnvironmentObjectInSwiftUI
//
//  Created by Deokhun KIM on 2023/01/26.
//

import Foundation

final class PurchaseViewModel: ObservableObject {
    
    @Published var hasPurchased: Bool = false
    @Published var isLoading: Bool = false
    
    func purchase() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.isLoading = false
            self?.hasPurchased = true
        }
    }
}
