//
//  ViewModel.swift
//  SwiftUI+Combine
//
//  Created by Deokhun KIM on 2023/09/23.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    private let service = GithubService()
    @Published var user: UserProfile?
    @Published var errorMessage: String?
    @Published var isLoading = false
    var userId = ""
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchUser() {
        isLoading = true
        print(#function)
        print("userId: \(userId)")
        service
            .fetchUser(userId: userId)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    isLoading = false
                case .failure(let error):
                    isLoading = false
                    if let error = error as? NetworkError {
                        print("DEBUG: Nerwork Error: \(error.errorDescription)")
                        errorMessage = error.errorDescription
                    }
                    user = nil
                }
            } receiveValue: { user in
                print("DEBUG: 유저정보 가져오기 성공: \(user)")
                self.user = user
                self.errorMessage = nil
            }
            .store(in: &cancellables)
    }
}
